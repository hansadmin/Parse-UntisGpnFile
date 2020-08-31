Remove-Module UntisGpnFileTools -ErrorAction SilentlyContinue
Import-Module ./UntisGpnFileTools.psm1

# --- helper functions

function Write-ExampleDescription {
    param($desc)
    Write-Output ''
    Write-Output ('~' * 79)
    Write-Output ''
    $str = ("[$(Get-UntisGpnFile)] $desc")
    Write-Output $str
    Write-Output ('=' * $str.Length)
}

function Write-Separator {
    Write-Output ''
    Write-Output ('~' * 79)
    Write-Output ('~' * 79)
    Write-Output ''
}

# ---

Open-UntisGpnFile -Path ./demo-files/be_gy1_Hantal.GPN

Write-ExampleDescription "Get-UntisPeriode"
Get-UntisPeriodes | Select-Object afkorting, volledig, isActief

Write-ExampleDescription "Get-UntisPeriode"
Get-UntisPeriodes | Format-Table

# --- 
Write-Separator
# --- 

Open-UntisGpnFile -Path ./demo-files/be_uv1_Nijverheidsschool.gpn

#Write-ExampleDescription "Get-UntisActiviteiten met data"
#Get-UntisActiviteiten | Where-Object {$_.startdatum -GE [datetime]'2009-10-05' -and $_.einddatum -LE [datetime]'2009-10-06'} | Format-List

#Write-ExampleDescription "Get-UntisPeriodes met filtering"
#Get-UntisPeriodes | Select-Object afkorting, volledig, isActief | Format-Table

Write-ExampleDescription "Get-UntisPeriode"
Get-UntisPeriodes | Format-Table
