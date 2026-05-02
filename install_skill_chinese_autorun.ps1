$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $PSCommandPath
$syncScript = Join-Path $scriptDir "sync_skill_chinese.py"
$pythonw = (Get-Command pythonw.exe -ErrorAction Stop).Source
$python = (Get-Command python.exe -ErrorAction Stop).Source
$taskName = "CodexSkillChineseWatcher"
$taskDescription = "Automatically sync Codex skills to Chinese names and create 技能作用.txt files."
$startupDir = [Environment]::GetFolderPath("Startup")
$startupVbs = Join-Path $startupDir "CodexSkillChineseWatcher.vbs"

if (-not (Test-Path -LiteralPath $syncScript)) {
    throw "Sync script not found: $syncScript"
}

$installedMode = "startup"

try {
    $taskExists = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
    if ($taskExists) {
        Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

    $action = New-ScheduledTaskAction -Execute $pythonw -Argument ('"{0}" --watch' -f $syncScript)
    $trigger = New-ScheduledTaskTrigger -AtLogOn
    $settings = New-ScheduledTaskSettingsSet `
        -AllowStartIfOnBatteries `
        -DontStopIfGoingOnBatteries `
        -MultipleInstances IgnoreNew

    Register-ScheduledTask `
        -TaskName $taskName `
        -Action $action `
        -Trigger $trigger `
        -Settings $settings `
        -Description $taskDescription | Out-Null

    $installedMode = "task"
} catch {
    $vbs = @"
Set shell = CreateObject("WScript.Shell")
shell.Run """" & "$pythonw" & """ """ & "$syncScript" & """ --watch", 0, False
"@
    Set-Content -LiteralPath $startupVbs -Value $vbs -Encoding ASCII
}

& $python $syncScript --once | Out-Null
Start-Process -WindowStyle Hidden -FilePath $pythonw -ArgumentList @($syncScript, "--watch") -WorkingDirectory $scriptDir

if ($installedMode -eq "task") {
    Write-Output "Auto sync installed with a Windows logon task."
} else {
    Write-Output "Auto sync installed with a Startup-folder launcher."
}
