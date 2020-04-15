# Parse-UntisGpnFile
Powershell regex-based parser for Untis' GPN-files

## How to run
Dot source `Parse-UntisGpnFile.ps1`

    . ./Parse-UntisGpnFile.ps1

Execute `Get-Klassen`

    Get-Klassen

## How to test
Have Pester installed

    Install-Module Pester

Run Tests

    ./Parse-UntisGpnFile.Tests.ps1


## TODO
First focus is to be able to export **classes**, **teachers** and **subjects**
to be used for scripting Microsoft Teams (names, channels, membership).

:warning: Done:
- `Get-Klassen`

:construction: TODO's (with estimated difficulty):

- add a test (for each encountered problem)
- fix tests
- :star: rename `Get-Klassen` to `Get-UntisKlassen`
- :star: `Get-UntisVakken`
- :star: `Get-UntisLeerkrachten` / `Get-UntisDocenten`
- :star: :star: Only do raw parsing or also logic (e.g. `Get-UntisLeerkrachten -Klas $klasnaam`)?
- :star: :star: :star: `Get-UntisLesrooster`
- ...
