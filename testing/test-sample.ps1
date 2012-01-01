set-psdebug -strict -trace 0

# define all test cases here
function TestGetPathToMSDeploy01 {
    $expectedMsdeployExe = "C:\Program Files\IIS\Microsoft Web Deploy V2\msdeploy.exe"
    
    $actualMsdeployExe = GetPathToMSDeploy
    
    $msg = "TestGetPathToMSDeploy01"
    AssertNotNull $actualMsdeployExe $msg
    AssertEqual $expectedMsdeployExe $actualMsdeployExe
    RaiseAssertions
}

$currentDirectory = split-path $MyInvocation.MyCommand.Definition -parent

$modPath = Join-Path -Path $currentDirectory -ChildPath "PublishIntModule.psm1"
$modFileName = (Get-Item $modPath).BaseName

"mod filename: {0}" -f $modFileName | Write-Host

# load the module, make sure it's a fresh copy
if((Get-Module -Name $modFileName)){
    Remove-Module $modFileName
}

Import-Module $modPath
# Import-Module $modPah

# load psexpect resources
if (!(Test-Path variable:_TESTLIB)) {
    $testLib = Join-Path -Path $currentDirectory -ChildPath "psexpect\TestLib.ps1"
    & $testLib
}

# start running test cases
TestGetPathToMSDeploy01


Remove-Module $modFileName