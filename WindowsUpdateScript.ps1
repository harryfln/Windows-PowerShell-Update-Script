if (!(Test-Path C:\path\to\logs\WindowsUpdateScript.log)) {
    New-Item -ItemType File -Path C:\Users\harry\Scripts\WindowsUpdateScript.log -Force
}

try {
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
    $log = "Updates installed on: $(Get-Date)"
    if ($Updates -ne $null) {
        $log += "Updates found for installed software, installing..."
        foreach ($Update in $Updates) {
            wusa.exe $Update.Path /quiet /norestart
            $log += "Installed update: $Update.HotFixID"
        }
    }

    if ($DriversUpdates -ne $null) {
        $log += "Updates found for drivers, installing..."
        foreach ($DriverUpdate in $DriversUpdates) {
            pnputil.exe -i -a $DriverUpdate.Path
            $log += "Installed update: $DriverUpdate.HotFixID"
        }
    }

    if ($OSUpdates -ne $null) {
        $log += "Updates found for operating system, installing..."
        foreach ($OSUpdate in $OSUpdates) {
            wusa.exe $OSUpdate.Path /quiet /norestart
            $log += "Installed update: $OSUpdate.HotFixID"
        }
    }

    $log += "`n"
    # Output the log to a file
    $log | Out-File -FilePath C:\Users\harry\Scripts\WindowsUpdateScript.log -Append

}
catch {
    Write-Host "An error occurred: $_"
    # Log the error to a file
    $_ | Out-File -FilePath C:\Users\harry\Scripts\WindowsUpdateScript.log -Append
}

    if ($DriversUpdates -ne $null) {
        $log += "Updates found for drivers, installing..."
        foreach ($DriverUpdate in $DriversUpdates) {
            pnputil.exe -i -a $DriverUpdate.Path
            $log += "Installed update: $DriverUpdate.HotFixID"
        }
    }

    if ($OSUpdates -ne $null) {
        $log += "Updates found for operating system, installing..."
        foreach ($OSUpdate in $OSUpdates) {
            wusa.exe $OSUpdate.Path /quiet /norestart
            $log += "Installed update: $OSUpdate.HotFixID"
        }
    }

    $log += "`n"
    # Output the log to a file
    $log | Out-File -FilePath C:\Users\harry\Scripts\WindowsUpdateScript.log -Append

}
catch {
    Write-Host "An error occurred: $_"
    # Log the error to a file
    $_ | Out-File -FilePath C:\Users\harry\Scripts\WindowsUpdateScript.log -Append
}
