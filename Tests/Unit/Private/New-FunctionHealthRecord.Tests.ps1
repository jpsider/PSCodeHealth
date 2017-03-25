$ModuleName = 'PSCodeHealth'
Import-Module "$PSScriptRoot\..\..\..\$ModuleName\$($ModuleName).psd1" -Force

Describe 'New-FunctionHealthRecord' {
    InModuleScope $ModuleName {

        $Files = (Get-ChildItem -Path "$($PSScriptRoot)\..\TestData\" -Filter '*.psm1').FullName
        $FunctionDefinitions = Get-FunctionDefinition -Path $Files
        $Function = $FunctionDefinitions | Where-Object Name -eq 'Set-Nothing'

        Context '1 PSScriptAnalyzer result is specified for ScriptAnalyzerResultDetails' {

            $Result = New-FunctionHealthRecord -FunctionDefinition $Function -FunctionTestCoverage 91.54

            It 'Should return an object of the type [PSCodeHealth.Function.HealthRecord]' {
                $Result | Should BeOfType [PSCustomObject]
                ($Result | Get-Member).TypeName | Should Be 'PSCodeHealth.Function.HealthRecord'
            }
            It 'Should return an object with the expected property "Name"' {
                $Result.Name | Should Be 'Set-Nothing'
            }
            It 'Should return an object with the expected property "FilePath"' {
                $Result.FilePath | Should BeLike '*Unit\TestData\2PublicFunctions.psm1'
            }
            It 'Should return an object with the expected property "CodeLength"' {
                $Result.CodeLength | Should Be 16
            }
            It 'Should return an object with the expected property "ScriptAnalyzerViolations"' {
                $Result.ScriptAnalyzerViolations | Should Be 1
            }
            It 'Should return an object with the expected property "ScriptAnalyzerResultDetails"' {
                $Result.ScriptAnalyzerResultDetails.RuleName |
                Should Be 'PSUseShouldProcessForStateChangingFunctions'
            }
            It 'Should return an object with the expected property "ContainsHelp"' {
                $Result.ContainsHelp | Should Be $True
            }
            It 'Should return an object with the expected property "TestCoverage"' {
                $Result.TestCoverage | Should Be 91.54
            }
            It 'Should return an object with the expected property "Complexity"' {
                $Result.Complexity | Should Be 1
            }
        }
    }
}