# Check for updates for installed software
$Updates = Get-WmiObject -Class "Win32_QuickFixEngineering" | Where-Object {$_.HotFixID -like "*KB*"}

# Check for updates for drivers
$DriversUpdates = Get-WmiObject -Class Win32_DriverVXD | Where-Object {$_.HotFixID -like "*KB*"}

# Check for updates for the operating system
$OSUpdates = Get-WmiObject -Class "Win32_OperatingSystem" | Where-Object {$_.HotFixID -like "*KB*"}

# Install Updates
if ($Updates -ne $null) {
    Write-Host "Updates found for installed software, installing..."
    foreach ($Update in $Updates) {
        wusa.exe $Update.Path /quiet /norestart
    }
}

if ($DriversUpdates -ne $null) {
    Write-Host "Updates found for drivers, installing..."
    foreach ($DriverUpdate in $DriversUpdates) {
        pnputil.exe -i -a $DriverUpdate.Path
    }
}

if ($OSUpdates -ne $null) {
    Write-Host "Updates found for operating system, installing..."
    foreach ($OSUpdate in $OSUpdates) {
        wusa.exe $OSUpdate.Path /quiet /norestart
    }
}
