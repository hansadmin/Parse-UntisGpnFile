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

Done :warning:
- `Get-Klassen`

TODO :construction: (with estimated difficulty):
- :star: rename `Get-Klassen` to `Get-UntisKlassen` (eases possible future refactoring to installable module)
- :star: parameterize: e.g. `-UntisFile xyz.gpn`
- :star: `Get-UntisVakken`
- :star: `Get-UntisLeerkrachten` / `Get-UntisDocenten`
- :star: :star: Only do raw parsing or also logic (e.g. `Get-UntisLeerkrachten -Klas $klasnaam`)?
- :star: :star: :star: `Get-UntisLesrooster`
- ...

Suggested workflow:
- add tests
    - for each bug/encountered problem
    - for new functionality
- fix tests
