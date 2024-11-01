# Active TCP Connections Monitor

## Overview
This Python script monitors and displays active TCP connections on your system. It provides detailed information about each connection, including local and foreign addresses, connection state, process ID (PID), and the associated process name.

## Features
- **Local Address**: The IP address and port number of the local machine.
- **Foreign Address**: The IP address and port number of the remote machine.
- **State**: The current state of the connection (e.g., ESTABLISHED, LISTENING).
- **PID (Process ID)**: The identifier of the process using the connection.
- **Process Name**: The name of the process associated with the given PID.

## Requirements
- Python 3.x
- `psutil` library

## Installation

### Install Python
If you haven't already, download and install Python from [python.org](https://www.python.org/downloads/).

### Install `psutil`
You can install the `psutil` library using pip. Open your terminal or command prompt and run:
```bash
pip install psutil
```
## Usage
Save the Script: Copy the script into a Python file (e.g., active_connections.py).
Run the Script: Execute the script from the command line:
```
python active_connections.py
```
Output: The script will output a table of active TCP connections in the following format:
```bash
Local Address                    Foreign Address                 State          PID        Process Name
=========================================================================================================
192.168.0.40:57287               40.113.110.67:443              ESTABLISHED    1234       chrome.exe
0.0.0.0:135                      N/A                             LISTENING      5678       svchost.exe
```

## Code Overview
**Function** ```get_active_connections()```
- Retrieves a list of active TCP connections using  ```psutil.net_connections()```.
- For each connection, it gathers the local and foreign addresses, connection state, PID, and process name.
**Function** ```display_connections(connections)```
- Formats and displays the collected connection details in a readable table format.
**Example Output**
When executed, the script provides a structured view of all active TCP connections, allowing users to identify and analyze network activity on their system.

## Conclusion
This script serves as a useful tool for network administrators and developers to monitor TCP connections on their systems, providing insights into active processes and network usage.

## License
This project is licensed under the MIT License - see the LICENSE file for details.





