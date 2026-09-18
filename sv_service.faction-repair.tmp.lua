local Registry, State, Invites, BankBalances, Ready = {}, {}, {}, {}, false
local Rank = { owner=3, officer=2, member=1 }
local function q(sql,p) return exports.oxmysql:query_async(sql,p or {}) or {} end
local function one(sql,p) return q(sql,p)[1] end
local function x(sql,p) return exports.oxmysql:execute_async(sql,p or {}) end
local function p(src) return exports.bs_core:GetPlayer(tonumber(src)) end
local function can(r,need) return (Rank[r or ''] or 0) >= (Rank[need] or 99) end
local function sync(src)
 local s=State[src]; if not s then return end; local f=s.id and Registry[s.id]
 Player(src).state:set('bsFactionTag', f and { tag=f.short, name=f.label, rank=s.rank } or nil, true)
 TriggerClientEvent('bs:factions:sync',src,{factionId=s.id,label=f and f.label,short=f and f.short,rank=s.rank,reputation=s.rep or 0,unlocks={}})
end
local function load(src)
 local pl=p(src); if not pl or not pl.charId then return nil end; local cid=tonumber(pl.charId); local m=one('SELECT faction_id, rank FROM bs_faction_members WHERE character_id=? LIMIT 1',{cid}); local rep=0
 if m then local v=one('SELECT reputation FROM bs_faction_reputation WHERE character_id=? AND faction_id=? LIMIT 1',{cid,m.faction_id}); rep=v and tonumber(v.reputation) or 0 end
 State[tonumber(src)]={cid=cid,id=m and m.faction_id,rank=m and m.rank,rep=rep}; sync(tonumber(src)); return State[tonumber(src)]
end
local function state(src) return State[tonumber(src)] or load(src) end
local function save(s) if s and s.id then x('INSERT INTO bs_faction_reputation(character_id,faction_id,reputation) VALUES(?,?,?) ON DUPLICATE KEY UPDATE reputation=VALUES(reputation)',{s.cid,s.id,s.rep or 0}) end end
local function members(id)
 local rows=q('SELECT m.character_id,m.rank,c.first_name,c.last_name FROM bs_faction_members m JOIN bs_characters c ON c.id=m.character_id WHERE m.faction_id=? ORDER BY FIELD(m.rank,\'owner\',\'officer\',\'member\'),c.first_name',{id}); local online={}; for _,v in ipairs(GetPlayers()) do local s=State[tonumber(v)];if s then online[s.cid]=tonumber(v) end end; local out={}
 for _,v in ipairs(rows) do out[#out+1]={charId=tonumber(v.character_id),rank=v.rank,src=online[tonumber(v.character_id)],name=((v.first_name or '?')..' '..(v.last_name or '')):gsub('%s+$','')} end; return out
end
local function treasury(id)
    -- The database write is asynchronous in this stack. Mirror the balance so
    -- a successful deposit is visible in the panel immediately after the callback.
    if BankBalances[id] == nil then
        local row=one('SELECT balance FROM bs_faction_banks WHERE faction_id=? LIMIT 1',{id})
        BankBalances[id]=row and tonumber(row.balance) or 0
    end
    local history=q('SELECT direction,amount,note,created_at FROM bs_faction_bank_log WHERE faction_id=? ORDER BY id DESC LIMIT 8',{id})
    return { balance=BankBalances[id], history=history }
end
local function directory()
    local rows=q([[SELECT r.faction_id,r.label,r.short,r.description,r.logo,
        (SELECT COUNT(*) FROM bs_faction_members m WHERE m.faction_id=r.faction_id) AS members,
        (SELECT COALESCE(SUM(rep.reputation),0) FROM bs_faction_reputation rep WHERE rep.faction_id=r.faction_id) AS reputation
        FROM bs_faction_registry r ORDER BY reputation DESC,members DESC,r.label ASC]])
    local out={}
    for _,v in ipairs(rows) do out[#out+1]={id=v.faction_id,label=v.label,short=v.short,description=v.description or '',logo=v.logo,members=tonumber(v.members) or 0,reputation=tonumber(v.reputation) or 0} end
    return out
end
local function bankMove(src, amount, withdraw)
    local s=state(src); amount=math.floor(tonumber(amount) or 0)
    if not s or not s.id or amount<1 then return {ok=false,error='Enter a valid amount.'} end
    local pl=p(src); if not pl then return {ok=false,error='Character is unavailable.'} end; local bank=treasury(s.id)
    if withdraw then
        if s.rank~='owner' then return {ok=false,error='Only the faction Leader may withdraw.'} end
        if bank.balance<amount then return {ok=false,error='The faction bank does not have enough cash.'} end
        x('UPDATE bs_faction_banks SET balance=balance-? WHERE faction_id=?',{amount,s.id}); BankBalances[s.id]=bank.balance-amount; pl:AddMoney('cash',amount,'faction treasury withdrawal'); x('INSERT INTO bs_faction_bank_log(faction_id,character_id,direction,amount,note) VALUES(?,?,\'withdraw\',?,?)',{s.id,s.cid,amount,'Leader withdrawal'})
    else
        if not pl:RemoveMoney('cash',amount,'faction treasury deposit') then return {ok=false,error='You do not have enough cash.'} end
        x('INSERT INTO bs_faction_banks(faction_id,balance) VALUES(?,?) ON DUPLICATE KEY UPDATE balance=balance+VALUES(balance)',{s.id,amount}); BankBalances[s.id]=bank.balance+amount; x('INSERT INTO bs_faction_bank_log(faction_id,character_id,direction,amount,note) VALUES(?,?,\'deposit\',?,?)',{s.id,s.cid,amount,'Member deposit'})
    end
    return {ok=true}
end
local function panel(src)
 if not Ready then return {ok=false,error='Faction service is starting.'} end; local s=state(src); if not s then return {ok=false,error='Character is loading.'} end; local pl=p(src); if not pl then return {ok=false,error='Character is unavailable.'} end; local out={ok=true,faction=nil,rank=nil,members={},nearby={},invite=nil,canCreate=not s.id,directory=directory()}; local i=Invites[src]
 if i and i.until_>os.time() and Registry[i.id] then out.invite={faction=i.id,label=Registry[i.id].label,seconds=i.until_-os.time()} end
 if not s.id then return out end; local f=Registry[s.id]; if not f then return {ok=false,error='Faction data is missing.'} end; out.rank=s.rank;out.faction={id=f.id,label=f.label,short=f.short,blurb=(f.description and f.description~='' and f.description or 'No faction description has been written yet.'),description=f.description or '',lore=f.config,reputation=s.rep,bank=treasury(s.id),cash=pl:GetMoney('cash'),logo=f.logo}; for _,m in ipairs(members(s.id)) do m.you=m.charId==s.cid;out.members[#out.members+1]=m end
 if can(s.rank,'officer') then local ped=GetPlayerPed(src);if ped and ped~=0 then local at=GetEntityCoords(ped);for _,v in ipairs(GetPlayers()) do local t=tonumber(v);local ts=state(t);local tp=GetPlayerPed(t);if t~=src and ts and not ts.id and tp and tp~=0 and #(GetEntityCoords(tp)-at)<=25.0 then out.nearby[#out.nearby+1]={src=t,name=GetPlayerName(t) or 'Survivor'} end end end end;return out
end
local function description(src,text)
 local s=state(src);if not s or not s.id or s.rank~='owner' then return {ok=false,error='Only the faction Leader may edit the description.'} end;local f=Registry[s.id];if not f then return {ok=false,error='Faction data is missing.'} end;text=tostring(text or ''):gsub('[%c]',' '):gsub('%s+',' '):sub(1,360);x('UPDATE bs_faction_registry SET description=? WHERE faction_id=?',{text,s.id});f.description=text;return {ok=true}
end
local function logo(src, mark, color)
 local s=state(src); if not s or not s.id or s.rank~='owner' then return {ok=false,error='Only the faction Leader may change the emblem.'} end
 mark=tostring(mark or ''):lower(); color=tostring(color or ''):lower()
 local allowed={wolf=true,skull=true,claw=true,shield=true,eye=true,bolt=true,crown=true,serpent=true}
 if not allowed[mark] or not color:match('^#[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]$') then return {ok=false,error='That emblem is invalid.'} end
 local value=json.encode({mark=mark,color=color}); local f=Registry[s.id]; if not f then return {ok=false,error='Faction data is missing.'} end
 x('UPDATE bs_faction_registry SET logo=? WHERE faction_id=?',{value,s.id}); f.logo=value; return {ok=true,logo=value}
end
local function create(src,name,short)
 local s=state(src);name=tostring(name or ''):gsub('[%c]',''):sub(1,48);short=tostring(short or ''):upper():gsub('[^A-Z0-9]',''):sub(1,8);local id=name:lower():gsub('[^a-z0-9]',''):sub(1,24)
 if not s then return {ok=false,error='Character is loading.'} end;if s.id then return {ok=false,error='Leave your current faction first.'} end;if #name<3 or #short<2 or #id<3 then return {ok=false,error='Use a name and 2–8 character tag.'} end;if Registry[id] then return {ok=false,error='That faction already exists.'} end
 local ok=pcall(x,'INSERT INTO bs_faction_registry(faction_id,label,short,owner_character_id,created_by,is_config) VALUES(?,?,?,?,?,0)',{id,name,short,s.cid,s.cid});if not ok then return {ok=false,error='Faction could not be saved.'} end;Registry[id]={id=id,label=name,short=short,owner=s.cid,config=false};x('INSERT INTO bs_faction_members(character_id,faction_id,rank) VALUES(?,?,?)',{s.cid,id,'owner'});s.id=id;s.rank='owner';s.rep=0;sync(src);return {ok=true,label=name}
end
local function invite(src,target)
 local s=state(src);target=tonumber(target);local t=target and state(target);if not s or not s.id or not can(s.rank,'officer') then return {ok=false,error='Only an owner or officer may invite.'} end;if not t or t.id then return {ok=false,error='That survivor is unavailable.'} end;local a,b=GetPlayerPed(src),GetPlayerPed(target);if not a or a==0 or not b or b==0 or #(GetEntityCoords(a)-GetEntityCoords(b))>25.0 then return {ok=false,error='Stand closer to invite them.'} end;Invites[target]={id=s.id,until_=os.time()+120};TriggerClientEvent('bs:ui:notify',target,{type='info',message='Faction invitation received. Open U → Faction.',duration=6000});return {ok=true}
end
local function accept(src)local s=state(src);local i=Invites[src];if not s or s.id then return {ok=false,error='You are already in a faction.'} end;if not i or i.until_<os.time() or not Registry[i.id] then Invites[src]=nil;return {ok=false,error='Invitation expired.'} end;x('INSERT INTO bs_faction_members(character_id,faction_id,rank) VALUES(?,?,?)',{s.cid,i.id,'member'});s.id=i.id;s.rank='member';s.rep=0;Invites[src]=nil;sync(src);return {ok=true,label=Registry[s.id].label}end
local function rank(src,target,want)local s=state(src);local t=state(target);want=tostring(want or ''):lower();if not s or s.rank~='owner' or not t or t.id~=s.id or t.rank=='owner' or (want~='member' and want~='officer') then return {ok=false,error='That role change is unavailable.'} end;x('UPDATE bs_faction_members SET rank=? WHERE character_id=?',{want,t.cid});t.rank=want;sync(target);return {ok=true,rank=want}end
local function kick(src,target)local s=state(src);local t=state(target);if not s or not can(s.rank,'officer') or not t or t.id~=s.id or t.rank=='owner' or(s.rank~='owner' and t.rank=='officer')then return {ok=false,error='You cannot remove that member.'}end;save(t);x('DELETE FROM bs_faction_members WHERE character_id=?',{t.cid});t.id=nil;t.rank=nil;t.rep=0;sync(target);return {ok=true}end
local function leave(src)local s=state(src);if not s or not s.id then return {ok=false,error='You are not in a faction.'}end;if s.rank=='owner'then return {ok=false,error='Transfer ownership or disband first.'}end;return kickOwnerless(src,s)end
function kickOwnerless(src,s) save(s);x('DELETE FROM bs_faction_members WHERE character_id=?',{s.cid});s.id=nil;s.rank=nil;s.rep=0;sync(src);return {ok=true}end
local function disband(src)local s=state(src);if not s or s.rank~='owner' then return {ok=false,error='Only the owner may disband.'}end;local f=Registry[s.id];if not f or f.config then return {ok=false,error='This faction cannot be disbanded.'}end;local id=s.id;for _,v in ipairs(GetPlayers())do local t=State[tonumber(v)];if t and t.id==id then t.id=nil;t.rank=nil;t.rep=0;sync(tonumber(v))end end;x('DELETE FROM bs_faction_members WHERE faction_id=?',{id});x('DELETE FROM bs_faction_registry WHERE faction_id=?',{id});Registry[id]=nil;return {ok=true,label=f.label}end
BSB.RegisterCallback('factions:description',description);BSB.RegisterCallback('factions:logo',logo);BSB.RegisterCallback('factions:bank:deposit',function(src,amount)return bankMove(src,amount,false)end);BSB.RegisterCallback('factions:bank:withdraw',function(src,amount)return bankMove(src,amount,true)end);BSB.RegisterCallback('factions:panel',panel);BSB.RegisterCallback('factions:create',create);BSB.RegisterCallback('factions:invite',invite);BSB.RegisterCallback('factions:targetInvite',invite);BSB.RegisterCallback('factions:accept',accept);BSB.RegisterCallback('factions:promote',rank);BSB.RegisterCallback('factions:kick',kick);BSB.RegisterCallback('factions:leave',leave);BSB.RegisterCallback('factions:leave2',leave);BSB.RegisterCallback('factions:disband',disband);BSB.RegisterCallback('factions:status',function(src)local s=state(src);return s and {ok=true,factionId=s.id,rank=s.rank,reputation=s.rep}or{ok=false}end);BSB.RegisterCallback('factions:roster',function(src)local s=state(src);return s and s.id and{ok=true,members=members(s.id)}or{ok=false}end);BSB.RegisterCallback('factions:join',function()return{ok=false,error='Join by invitation only.'}end)
exports('GetFaction',function(src)local s=state(src);return s and s.id end);exports('GetFactionSummary',function(src)local s=state(src);local f=s and Registry[s.id];return s and{factionId=s.id,label=f and f.label,short=f and f.short,reputation=s.rep,rank=s.rank}end);exports('FactionRank',function(src)local s=state(src);return s and s.rank end);exports('AddReputation',function(src,n)local s=state(src);if not s or not s.id then return false end;s.rep=math.max(0,math.min(Factions.Settings.maxReputation,(s.rep or 0)+math.floor(tonumber(n)or 0)));sync(src);return s.rep end)
local function staff(src) return IsPlayerAceAllowed(src, 'bs.admin') or IsPlayerAceAllowed(src, 'bs.superadmin') end
BSB.RegisterCallback('factions:admin:list', function(src)
 if not staff(src) then return {ok=false,error='Not allowed.'} end
 local out={};for _,f in pairs(Registry) do out[#out+1]={faction_id=f.id,label=f.label,short=f.short,is_config=f.config and 1 or 0,owner_character_id=f.owner,members=#members(f.id)} end;return {ok=true,factions=out}
end)
BSB.RegisterCallback('factions:admin:delete', function(src,id)
 if not staff(src) then return {ok=false,error='Not allowed.'} end;local f=Registry[tostring(id or '')];if not f or f.config then return {ok=false,error='Faction cannot be deleted.'} end
 for source,s in pairs(State) do if s.id==f.id then s.id=nil;s.rank=nil;s.rep=0;sync(source) end end;x('DELETE FROM bs_faction_members WHERE faction_id=?',{f.id});x('DELETE FROM bs_faction_registry WHERE faction_id=?',{f.id});Registry[f.id]=nil;return {ok=true}
end)
BSB.RegisterCallback('factions:admin:reset', function(src)
 if not staff(src) then return {ok=false,error='Not allowed.'} end;local ids={};for id,f in pairs(Registry)do if not f.config then ids[#ids+1]=id end end;for _,id in ipairs(ids)do x('DELETE FROM bs_faction_members WHERE faction_id=?',{id});x('DELETE FROM bs_faction_registry WHERE faction_id=?',{id});Registry[id]=nil end;for source,s in pairs(State)do if s.id and not Registry[s.id]then s.id=nil;s.rank=nil;s.rep=0;sync(source)end end;return {ok=true,removed=#ids}
end)
AddEventHandler('bs:hook:player:loaded',function(pl)if pl and pl.source then load(pl.source)end end);AddEventHandler('playerDropped',function()save(State[source]);State[source]=nil;Invites[source]=nil end)
CreateThread(function()while GetResourceState('oxmysql')~='started'do Wait(250)end;x('CREATE TABLE IF NOT EXISTS bs_faction_banks (faction_id VARCHAR(32) NOT NULL,balance INT NOT NULL DEFAULT 0,PRIMARY KEY(faction_id))');x('CREATE TABLE IF NOT EXISTS bs_faction_bank_log (id INT UNSIGNED NOT NULL AUTO_INCREMENT,faction_id VARCHAR(32) NOT NULL,character_id INT UNSIGNED NULL,direction VARCHAR(16) NOT NULL,amount INT NOT NULL,note VARCHAR(96) NULL,created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,PRIMARY KEY(id),KEY(faction_id))');x('CREATE TABLE IF NOT EXISTS bs_faction_registry (faction_id VARCHAR(32) NOT NULL,label VARCHAR(48) NOT NULL,short VARCHAR(8) NOT NULL DEFAULT \'\',owner_character_id INT UNSIGNED NULL,created_by INT UNSIGNED NULL,is_config TINYINT(1) NOT NULL DEFAULT 0,description TEXT NULL,created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,PRIMARY KEY(faction_id))');pcall(x,"ALTER TABLE bs_faction_members ADD COLUMN IF NOT EXISTS rank VARCHAR(16) NOT NULL DEFAULT 'member'");pcall(x,"ALTER TABLE bs_faction_registry ADD COLUMN IF NOT EXISTS description TEXT NULL");pcall(x,"ALTER TABLE bs_faction_registry ADD COLUMN IF NOT EXISTS logo VARCHAR(128) NULL");Wait(500);for _,row in ipairs(q('SELECT * FROM bs_faction_registry'))do Registry[row.faction_id]={id=row.faction_id,label=row.label,short=row.short or '',owner=tonumber(row.owner_character_id),config=tonumber(row.is_config)==1,description=row.description or '',logo=row.logo}end;Ready=true;for _,id in ipairs(GetPlayers())do load(tonumber(id))end;print('^2[BeyondSurvival]^7 faction service ready')end)


CreateThread(function()
    while true do
        Wait(1000)
        local zones = GetResourceState('bs_zombies') == 'started' and exports.bs_zombies:SafeZones() or {}
        for _, idText in ipairs(GetPlayers()) do
            local src = tonumber(idText); local ped = GetPlayerPed(src); local inside = false
            if ped and ped ~= 0 then
                local c = GetEntityCoords(ped)
                for _, z in ipairs(zones or {}) do
                    local dx, dy = c.x - z.x, c.y - z.y
                    if (dx * dx + dy * dy) <= (z.radius * z.radius) then inside = true; break end
                end
            end
            Player(src).state:set('bsFactionSafeZone', inside, true)
        end
    end
end)


