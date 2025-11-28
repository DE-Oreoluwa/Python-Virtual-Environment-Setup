# Python Virtual Environment Setup
This is a Bash script that automates the setup of a clean, ready-to-use Python development environment. It handles virtual environment creation and activation, pip upgrades, package installation, gitignore file generation, and detailed logging, with colorful and user-friendly output.

## What the Script Does
When you run the bash script, it:
1.	Checks for an existing Python virtual environment.
    - If `.venv` exists, it activates it.
    - If missing, it creates a new `.venv` and activates it.
2.	Upgrades pip inside the virtual environment: Ensures the latest version of pip is used for clean, modern package installs.
3.	Generates a gitignore file
    - Includes standard Python ignore rules.
    - Avoids overwriting if the file already exists.
4. Installs essential Python packages which includes numpy, pandas, requests, SQLAlchemy, boto (you can modify the list incase you need any package that is not in the script).
5. Logs all operations: All activity is written to `setup.log` for debugging or auditing.
6. Displays colored output: INFO, SUCCESS, WARNING, and ERROR messages are shown clearly using ANSI color codes.

## How to Execute the Script
1. Create a bash file named `setup.sh` using;
    ```bash
      touch setup.sh
    ```
2. Give the script execute permission using
    ```bash
      chmod u+x setup.sh
    ```
3. Input the script in the `setup.sh` from this repo and paste it in the bash script file you have created. Save it and run it using the command below on your terminal.
   ```bash
       ./setup.sh
   ```
   The output will be the:
   - Creation and activation of a python virtual environment with python packages listed in the script which you can check after installation in the `.venv` directory
   - Generation of a gitignore file (`.gitignore`) which has some standard ignore rules.
   -  Creation of a log file (`setup.log`) which stores the process of running the script.

## Example of Output on the Terminal
This is a sample of the output on the terminal when the script is running
```bash
    [INFO] Starting project setup...
    [INFO[INFO] Starting project setup...
    [INFO] Checking for Python virtual environment.
    [INFO] Creating virtual environment...
    [SUCCESS] Virtual environment created.
    [INFO] Activating virtual environment...
    [SUCCESS] Virtual environment activated.
    [INFO] Upgrading pip inside virtual environment...
    [SUCCESS] Pip upgrade successful.
    [INFO] Checking for .gitignore file...
    [INFO] .gitignore does not exist.
    [SUCCESS] .gitignore file created.
    [SUCCESS] .gitignore file created with standard ignore rules added.
    [INFO] Installing Python packages...
    Collecting numpy
      Using cached numpy-2.3.5-cp312-cp312-manylinux_2_27_x86_64.manylinux_2_28_x86_64.whl.metadata (62 kB)
    Collecting pandas
      Using cached pandas-2.3.3-cp312-cp312-manylinux_2_24_x86_64.manylinux_2_28_x86_64.whl.metadata (91 kB)
    Collecting requests
      Using cached requests-2.32.5-py3-none-any.whl.metadata (4.9 kB)
    Collecting SQLAlchemy
      Using cached sqlalchemy-2.0.44-cp312-cp312-manylinux_2_17_x86_64.manylinux2014_x86_64.whl.metadata (9.5 kB)
    Collecting boto3
      Using cached boto3-1.41.5-py3-none-any.whl.metadata (6.8 kB)
    Collecting python-dateutil>=2.8.2 (from pandas)
```
  - This is a sample of the `setup.log` file which stores processes:
```bash
[1;36m[INFO][0m Starting project setup...
[1;36m[INFO][0m Checking for Python virtual environment.
[1;36m[INFO][0m Creating virtual environment...
[1;32m[SUCCESS][0m Virtual environment created.
[1;36m[INFO][0m Activating virtual environment...
[1;32m[SUCCESS][0m Virtual environment activated.
[1;36m[INFO][0m Upgrading pip inside virtual environment...
Requirement already satisfied: pip in ./.venv/lib/python3.12/site-packages (24.0)
Collecting pip
  Using cached pip-25.3-py3-none-any.whl.metadata (4.7 kB)
Using cached pip-25.3-py3-none-any.whl (1.8 MB)
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 24.0
    Uninstalling pip-24.0:
      Successfully uninstalled pip-24.0
Successfully installed pip-25.3
[1;32m[SUCCESS][0m Pip upgrade successful.
[1;36m[INFO][0m Checking for .gitignore file...
[1;36m[INFO][0m .gitignore does not exist.
[1;32m[SUCCESS][0m .gitignore file created.
[1;32m[SUCCESS][0m .gitignore file created with standard ignore rules added.
[1;36m[INFO][0m Installing Python packages...
```

## Challenges Faced
**1. PEP 668 / Externally Managed Environment Errors**: Initially, I could not upgrade python pip version because Ubuntu/WSL Python 3.12 blocks global pip installs. I tried `apt install python3-pip` but it was not reliable as I got a warning message from the system that "apt does not have a stable CLI interface. Use with caution in scripts"

**Solution**: I had to use `.venv/bin/python -m pip install --upgrade pip` to avoid touching system Python, and I learnt that there are restrictions to global when using WSL. I had to use the same path to install other python packages too.

**2. Color Codes for process display:** It took a while before I could understand how to use colors to display output messages.

**3. Logging both stdout and stderr:** I needed to see some of the output of the commands on the terminal, so I discovered `>> "$LOG_FILE" 2>&1` will not show them but only append them.

**Solution:** I found out that `| tee -a "LOG_FILE"` will show the output and append them. So I mixed the use of the two together to get the outcome I desire.

## Lessons Learned
1. I now understand how a python virtual environment is created and activated.
2. You can create python virtual environment and it will fail to activate. When this occur, you will have to signify the path for activaton.
3. `| tee -a logfile` shows the output of commands to the user and logs it while `>> logfile 2>&1` logs everything silently.
4. The use of functions for the tasks and a main function to call the individual task made the script run smoothly and together.
5. The use of `set -e` was very helpful as it stopped the script from running whenever there was an error.
