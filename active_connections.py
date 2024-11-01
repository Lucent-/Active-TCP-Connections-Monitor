# ------------------------------------------------------------------------------
# @Lucent- https://github.com/Lucent-
# A Python script to display active TCP connections along with
# their local and foreign addresses, state, process ID, and 
# associated process names. This script utilizes the psutil library
# for system and network-related information.
# ------------------------------------------------------------------------------


import psutil

def get_active_connections():
    # Get the active TCP connections
    connections = psutil.net_connections(kind='tcp')
    connection_details = []

    for conn in connections:
        # Get local and foreign address information
        local_address = f"{conn.laddr.ip}:{conn.laddr.port}"
        foreign_address = f"{conn.raddr.ip}:{conn.raddr.port}" if conn.raddr else "N/A"
        
        # Get the connection state
        state = conn.status
        
        # Get the process ID associated with the connection, if any
        pid = conn.pid
        process_name = None
        if pid:
            try:
                process = psutil.Process(pid)
                process_name = process.name()
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                process_name = "N/A"

        # Gather additional information about the connection
        connection_details.append({
            "Local Address": local_address,
            "Foreign Address": foreign_address,
            "State": state,
            "PID": pid,
            "Process Name": process_name,
        })

    return connection_details

def display_connections(connections):
    print(f"{'Local Address':<30} {'Foreign Address':<30} {'State':<15} {'PID':<10} {'Process Name':<25}")
    print("=" * 120)
    for conn in connections:
        print(f"{conn['Local Address']:<30} {conn['Foreign Address']:<30} {conn['State']:<15} {conn['PID']:<10} {conn['Process Name']:<25}")

if __name__ == "__main__":
    active_connections = get_active_connections()
    display_connections(active_connections)
