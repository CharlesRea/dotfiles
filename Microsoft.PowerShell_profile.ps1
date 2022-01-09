$env:POSH_SESSION_DEFAULT_USER = [System.Environment]::UserName

Import-Module oh-my-posh
oh-my-posh --init --shell pwsh --config ~/.pstheme.omp.json | Invoke-Expression

Import-Module -Name Terminal-Icons

Import-Module posh-git

if ($host.Name -eq 'ConsoleHost')
{
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History

    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'
}

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
     param($commandName, $wordToComplete, $cursorPosition)
         dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
         }
 }