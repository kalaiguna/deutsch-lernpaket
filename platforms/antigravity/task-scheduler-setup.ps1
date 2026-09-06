# Deutsch B2 — Windows Task Scheduler setup for Google Antigravity
# Registers all 7 skills as scheduled tasks that run agy at the configured times.
# Run this script once from an elevated PowerShell prompt.
#
# Usage:
#   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   .\task-scheduler-setup.ps1
#
# To remove all tasks later:
#   Get-ScheduledTask -TaskPath "\DeutschB2\" | Unregister-ScheduledTask -Confirm:$false

$taskPath = "\DeutschB2\"

$tasks = @(
    @{
        Name        = "DeutschB2-Daily"
        Skill       = "/daily-german-practice"
        Description = "Tue/Thu B2 conversation session (Deutsch B2 Konversation)"
        DaysOfWeek  = @("Tuesday", "Thursday")
        StartTime   = "09:00"
        TriggerType = "Weekly"
    },
    @{
        Name        = "DeutschB2-Weekend"
        Skill       = "/german-weekend-review"
        Description = "Friday B2 quiz (Deutsch B2 Quiz)"
        DaysOfWeek  = @("Friday")
        StartTime   = "09:00"
        TriggerType = "Weekly"
    },
    @{
        Name        = "DeutschB2-Sunday"
        Skill       = "/german-sunday-schreiben-und-hoeren"
        Description = "Sunday listening + translation (Deutsch B2 Übersetzung & Hören)"
        DaysOfWeek  = @("Sunday")
        StartTime   = "09:00"
        TriggerType = "Weekly"
    },
    @{
        Name        = "DeutschB2-Schreiben"
        Skill       = "/schreib-skill"
        Description = "Saturday writing session (Deutsch B2 Schreiben)"
        DaysOfWeek  = @("Saturday")
        StartTime   = "09:00"
        TriggerType = "Weekly"
    },
    @{
        Name        = "DeutschB2-Lektuere"
        Skill       = "/lektuere-skill"
        Description = "Every other Wednesday reading (Deutsch B2 Lektüre)"
        DaysOfWeek  = @("Wednesday")
        StartTime   = "09:00"
        TriggerType = "Weekly"
        # Note: Task Scheduler has no built-in every-other-week trigger.
        # The task runs every Wednesday; skip alternate weeks manually,
        # or set the trigger interval to 2 weeks in Task Scheduler GUI after creation.
    },
    @{
        Name        = "DeutschB2-Monatsrueckblick"
        Skill       = "/monatsrueckblick"
        Description = "1st of month report card (Deutsch B2 Monatsrückblick)"
        StartTime   = "09:00"
        TriggerType = "Monthly"
        DayOfMonth  = 1
    },
    @{
        Name        = "DeutschB2-Grammatik"
        Skill       = "/grammatik-vertiefung"
        Description = "10th of month grammar deep-dive (Deutsch B2 Grammatik)"
        StartTime   = "09:00"
        TriggerType = "Monthly"
        DayOfMonth  = 10
    }
)

foreach ($task in $tasks) {
    if ($task.TriggerType -eq "Weekly") {
        $action = New-ScheduledTaskAction `
            -Execute "agy" `
            -Argument "--print --dangerously-skip-permissions `"$($task.Skill)`""

        $trigger = New-ScheduledTaskTrigger `
            -Weekly `
            -DaysOfWeek $task.DaysOfWeek `
            -At $task.StartTime

        $settings = New-ScheduledTaskSettingsSet `
            -ExecutionTimeLimit (New-TimeSpan -Hours 2) `
            -MultipleInstances IgnoreNew `
            -StartWhenAvailable

        $existing = Get-ScheduledTask -TaskPath $taskPath -TaskName $task.Name -ErrorAction SilentlyContinue
        if ($existing) {
            Write-Host "Updating existing task: $($task.Name)" -ForegroundColor Yellow
            Set-ScheduledTask `
                -TaskPath $taskPath `
                -TaskName $task.Name `
                -Action $action `
                -Trigger $trigger `
                -Settings $settings | Out-Null
        } else {
            Write-Host "Registering task: $($task.Name)" -ForegroundColor Green
            Register-ScheduledTask `
                -TaskPath $taskPath `
                -TaskName $task.Name `
                -Description $task.Description `
                -Action $action `
                -Trigger $trigger `
                -Settings $settings `
                -RunLevel Limited | Out-Null
        }
    } elseif ($task.TriggerType -eq "Monthly") {
        Write-Host "Registering monthly task: $($task.Name)" -ForegroundColor Green
        $taskName = "$taskPath$($task.Name)"
        $argStr = "agy --print --dangerously-skip-permissions `"$($task.Skill)`""
        schtasks /Create /SC MONTHLY /D $task.DayOfMonth /TN $taskName /TR $argStr /ST $task.StartTime /F | Out-Null
    }
}

Write-Host ""
Write-Host "Done. Tasks registered under $taskPath" -ForegroundColor Cyan
Write-Host "Open Task Scheduler (taskschd.msc) → Task Scheduler Library → DeutschB2 to verify."
Write-Host ""
Write-Host "Note: lektuere-skill is registered as weekly (every Wednesday)."
Write-Host "To make it fortnightly, open the DeutschB2-Lektuere task in the GUI and"
Write-Host "set 'Recur every 2 weeks' under the trigger settings."
