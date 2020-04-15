. ./Parse-UntisGpnFile.ps1

Describe 'Get-Klassen' {
    It "moet alle 56 klassen returnen" {
        $alle_klassen = Get-Klassen
        $alle_klassen.Count | Should -Be 56
    }

    It "moet als eerste klas 1BMA returnen" {
        $eerste_klas = Get-Klassen | Select -First 1
        $eerste_klas.afkorting | Should -Be '1BMA'
        $eerste_klas.volledig | Should -Be 'Accountancy-Talen & Fiscaliteit'
    }

    It "moet 1 klas zonder volledige naam bevatten (STVMK)" {
        $klas_zonder_volledige_naam = Get-Klassen | Where volledig -eq ""
        $klas_zonder_volledige_naam.Count | Should -Be 1
        $klas_zonder_volledige_naam.afkorting | Should -Be 'STVMK'
    }

    It "moet deeltekens correct parsen (2IMA)" {
        $klas2IMA = Get-Klassen | Where afkorting -eq 2IMA
        $klas2IMA.volledig | Should -Be "Immobiliën- en Verzekeringswezen"
    }
}