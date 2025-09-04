fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression
fnm use 22 >$null

function Get-GitBranch
{
	return git branch --show-current
}

function prompt
{
	$gitbranch = Get-GitBranch
	Write-Host "$($executionContext.SessionState.Path.CurrentLocation)" -NoNewLine 

	if ($gitbranch)
	{
		$color = switch ($gitbranch)
		{
			{($_ -eq 'main') -or ($_ -eq 'master')}
			{ "Red" 
			}
			{($_ -eq 'develop')}
			{ "Green" 
			}
			default
			{ "Blue" 
			}
		}
		Write-Host "($gitbranch)" -ForegroundColor $color -NoNewLine
	}

	Write-Host "$('>'*($NestedPromptLevel + 1))" -ForegroundColor Green -NoNewLine
	return ' '
}

$NVIM = $env:localappdata + '\nvim'
$NVIM_INIT = $NVIM + '\init.lua'
$DEV = '~\Documents'
