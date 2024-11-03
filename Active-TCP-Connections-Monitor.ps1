# ------------------------------------------------------------------------------
# A PowerShell script to display active TCP connections along with
# their local and foreign addresses, state, process ID, and 
# associated process names.
# ------------------------------------------------------------------------------

function Get-ActiveConnections {
    # Get the active TCP connections
    $connections = Get-NetTCPConnection | Where-Object { $_.State -ne 'Listen' }
    $connectionDetails = @()

    foreach ($conn in $connections) {
        # Get local and foreign address information
        $localAddress = "$($conn.LocalAddress):$($conn.LocalPort)"
        $foreignAddress = if ($conn.RemoteAddress -ne '::') {
            "$($conn.RemoteAddress):$($conn.RemotePort)"
        } else {
            "N/A"
        }

        # Get the connection state
        $state = $conn.State

        # Get the process ID and process name associated with the connection
        $pid = $conn.OwningProcess
        $processName = try {
            (Get-Process -Id $pid).Name
        } catch {
            "N/A"
        }

        # Gather additional information about the connection
        $connectionDetails += [PSCustomObject]@{
            "Local Address"   = $localAddress
            "Foreign Address" = $foreignAddress
            "State"           = $state
            "PID"             = $pid
            "Process Name"    = $processName
        }
    }

    return $connectionDetails
}

function Display-Connections {
    param (
        [Parameter(Mandatory = $true)]
        [array]$connections
    )

    Write-Host "Local Address                     Foreign Address                   State           PID       Process Name" -ForegroundColor Cyan
    Write-Host ("=" * 100)

    foreach ($conn in $connections) {
        Write-Host ("{0,-30} {1,-30} {2,-15} {3,-10} {4,-25}" -f $conn.'Local Address', $conn.'Foreign Address', $conn.State, $conn.PID, $conn.'Process Name')
    }
}

# Main script execution
$activeConnections = Get-ActiveConnections
Display-Connections -connections $activeConnections
