Function Get-FunctionScriptAnalyzerResult {
<#
.SYNOPSIS
    Gets the best practices violations in the specified function definition, using PSScriptAnalyzer.
.DESCRIPTION
    Gets the best practices violations in the specified function definition specified as a [System.Management.Automation.Language.FunctionDefinitionAst].
    It uses the PSScriptAnalyzer PowerShell module.

.PARAMETER FunctionDefinition
    To specify the function definition to analyze.

.EXAMPLE
    Get-FunctionScriptAnalyzerResult -FunctionDefinition $MyFunctionAst

    Returns the best practices violations (PSScriptAnalyzer results) in the specified function definition.

.OUTPUTS
    Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord

.NOTES
    General notes
#>
    [CmdletBinding()]
    [OutputType([Microsoft.Windows.PowerShell.ScriptAnalyzer.Generic.DiagnosticRecord])]
    Param (
        [Parameter(Position=0, Mandatory=$True)]
        [System.Management.Automation.Language.FunctionDefinitionAst]$FunctionDefinition
    )
    
    $Results = Invoke-ScriptAnalyzer -ScriptDefinition $FunctionDefinition.Extent.Text -Verbose:$False
    return $Results
}