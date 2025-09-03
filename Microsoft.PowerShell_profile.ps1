fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
fnm use 22 >$null

function Get-GitBranch {
  return git branch --show-current
}
function prompt {
  $gitbranch = Get-GitBranch
  if ($gitbranch) {
    $color = switch ($gitbranch) {
	{($_ -eq 'main') -or ($_ -eq 'master')} { "Red" }
	{($_ -eq 'develop')} { "Green" }
	default { "Blue" }
    }
    Write-Host "$($executionContext.SessionState.Path.CurrentLocation)" -ForegroundColor DarkMagenta -NoNewLine 
    Write-Host " ($gitbranch)" -ForegroundColor $color -NoNewLine
    Write-Host "$('>'*($NestedPromptLevel + 1))" -NoNewLine
    return ' '
  }
  else {
    Write-Host "$($executionContext.SessionState.Path.CurrentLocation)$('>' * ($NestedPromptLevel + 1)) " -Foreground DarkMagenta -NoNewLine
    return ' '
  }
}

$nvim = $env:localappdata + '\nvim'