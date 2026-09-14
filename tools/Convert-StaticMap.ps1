param(
    [Parameter(Mandatory)] [string] $Source,
    [Parameter(Mandatory)] [string] $Destination,
    [Parameter(Mandatory)] [ValidateSet('MapEditor','Menyoo')] [string] $Format,
    [switch] $NoPrune
)

$ErrorActionPreference = 'Stop'
$project = 'H:\The-Apocalypse-Project'
$resource = Join-Path $project '[the_apocalypse_project]'
$template = Join-Path $resource 'apocalypse-statewide\stream\community\crazy-city\zratoncanyon.ymap'
Add-Type -Path 'H:\Desktop\CodeWalker30_dev35\CodeWalker.Core.dll'

function Get-Key([double] $X, [double] $Y, [double] $Z) {
    '{0}|{1}|{2}' -f [math]::Floor($X / 3), [math]::Floor($Y / 3), [math]::Floor($Z / 3)
}

function Test-NearExisting($Grid, [double] $X, [double] $Y, [double] $Z) {
    $cx = [math]::Floor($X / 3); $cy = [math]::Floor($Y / 3); $cz = [math]::Floor($Z / 3)
    foreach ($dx in -1..1) { foreach ($dy in -1..1) { foreach ($dz in -1..1) {
        $key = "$($cx + $dx)|$($cy + $dy)|$($cz + $dz)"
        if ($Grid.ContainsKey($key)) {
            foreach ($p in $Grid[$key]) {
                if ([math]::Sqrt(($X-$p.X)*($X-$p.X)+($Y-$p.Y)*($Y-$p.Y)+($Z-$p.Z)*($Z-$p.Z)) -lt 3) { return $true }
            }
        }
    } } }
    return $false
}

$grid = @{}
Get-ChildItem -LiteralPath $resource -Recurse -File -Filter '*.ymap' | ForEach-Object {
    $ymap = [CodeWalker.GameFiles.YmapFile]::new(); $ymap.Load([IO.File]::ReadAllBytes($_.FullName))
    foreach ($entity in $ymap.CEntityDefs) {
        $p = $entity.position; $key = Get-Key $p.X $p.Y $p.Z
        if (!$grid.ContainsKey($key)) { $grid[$key] = [Collections.Generic.List[object]]::new() }
        $grid[$key].Add($p)
    }
}

[xml] $xml = Get-Content -LiteralPath $Source
$candidates = [Collections.Generic.List[object]]::new()
if ($Format -eq 'MapEditor') {
    foreach ($item in @($xml.Map.Objects.MapObject | Where-Object { $_.Type -eq 'Prop' -and $_.Dynamic -ne 'true' })) {
        $hash = [int64]$item.Hash; if ($hash -lt 0) { $hash += 4294967296 }
        # Map Editor stores its quaternion in the opposite entity space used by YMAP.
        $qx=[double]$item.Quaternion.X; $qy=[double]$item.Quaternion.Y; $qz=[double]$item.Quaternion.Z; $qw=[double]$item.Quaternion.W
        if ($qw -lt 0) { $qw = -$qw } else { $qx = -$qx; $qy = -$qy; $qz = -$qz }
        $candidates.Add([pscustomobject]@{ Hash=[uint32]$hash; X=[double]$item.Position.X; Y=[double]$item.Position.Y; Z=[double]$item.Position.Z; QX=$qx; QY=$qy; QZ=$qz; QW=$qw })
    }
} else {
    foreach ($item in @($xml.SpoonerPlacements.Placement | Where-Object { $_.Type -eq '3' -and $_.Attachment.isAttached -ne 'true' -and $_.IsVisible -ne 'false' })) {
        $r = $item.PositionRotation
        # Menyoo/Spooner stores a negated Roll/Pitch/Yaw vector which must be remapped
        # through GTA's RotationYawPitchRoll before it becomes a YMAP quaternion.
        $yaw=-[double]$r.Roll*[math]::PI/180; $pitch=-[double]$r.Pitch*[math]::PI/180; $roll=-[double]$r.Yaw*[math]::PI/180
        $cy=[math]::Cos($yaw/2); $sy=[math]::Sin($yaw/2); $cp=[math]::Cos($pitch/2); $sp=[math]::Sin($pitch/2); $cr=[math]::Cos($roll/2); $sr=[math]::Sin($roll/2)
        $hash = [convert]::ToUInt32(([string]$item.ModelHash).Substring(2),16)
        $candidates.Add([pscustomobject]@{ Hash=$hash; X=[double]$r.X; Y=[double]$r.Y; Z=[double]$r.Z; QX=($cy*$sp*$cr+$sy*$cp*$sr); QY=($sy*$cp*$cr-$cy*$sp*$sr); QZ=($cy*$cp*$sr-$sy*$sp*$cr); QW=($cy*$cp*$cr+$sy*$sp*$sr) })
    }
}

$accepted = if ($NoPrune) { @($candidates) } else { @($candidates | Where-Object { !(Test-NearExisting $grid $_.X $_.Y $_.Z) }) }
$ymap = [CodeWalker.GameFiles.YmapFile]::new(); $ymap.Load([IO.File]::ReadAllBytes($template))
@($ymap.RootEntities) | ForEach-Object { $ymap.RemoveEntity($_) | Out-Null }
for ($i = 0; $i -lt $accepted.Count; $i++) {
    $item = $accepted[$i]; $def = [CodeWalker.GameFiles.CEntityDef]::new()
    $def.archetypeName = [CodeWalker.GameFiles.MetaHash]::new($item.Hash); $def.flags = 32; $def.guid = [uint32]$i
    $def.position = [SharpDX.Vector3]::new([single]$item.X,[single]$item.Y,[single]$item.Z); $def.rotation = [SharpDX.Vector4]::new([single]$item.QX,[single]$item.QY,[single]$item.QZ,[single]$item.QW)
    $def.scaleXY=1; $def.scaleZ=1; $def.parentIndex=-1; $def.lodDist=200; $def.childLodDist=0; $def.lodLevel=[CodeWalker.GameFiles.rage__eLodType]::LODTYPES_DEPTH_ORPHANHD; $def.priorityLevel=[CodeWalker.GameFiles.rage__ePriorityLevel]::PRI_REQUIRED; $def.ambientOcclusionMultiplier=255; $def.artificialAmbientOcclusion=255
    $entity = [CodeWalker.GameFiles.YmapEntityDef]::new(); $entity.CEntityDef=$def; $ymap.AddEntity($entity) | Out-Null
}
New-Item -ItemType Directory -Force (Split-Path $Destination) | Out-Null
[IO.File]::WriteAllBytes($Destination, $ymap.Save())
$validated=[CodeWalker.GameFiles.YmapFile]::new(); $validated.Load([IO.File]::ReadAllBytes($Destination)); $validated.BuildCEntityDefs(); $validated.CalcFlags() | Out-Null; $validated.CalcExtents() | Out-Null; [IO.File]::WriteAllBytes($Destination, $validated.Save())
$check=[CodeWalker.GameFiles.YmapFile]::new(); $check.Load([IO.File]::ReadAllBytes($Destination))
"source=$($candidates.Count) pruned=$($candidates.Count-$accepted.Count) output=$($check.CEntityDefs.Count) extents=$($check.CMapData.entitiesExtentsMin) -> $($check.CMapData.entitiesExtentsMax)"
