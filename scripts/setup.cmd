@echo off
rem Usage: scripts\setup.cmd   (run from the repository root, in cmd or PowerShell)
rem Checks the tools the product track needs. It never installs a tool for you.
rem This script has not been tested on Windows. If it misbehaves, use Git Bash or WSL and run scripts/setup.sh.
setlocal
set FAIL=0
echo Checking your tools
git --version >nul 2>&1
if errorlevel 1 (
  echo   Stop: git is not installed. Install it from https://git-scm.com and run this script again.
  set FAIL=1
) else (
  for /f "delims=" %%v in ('git --version') do echo   %%v
  for /f "delims=" %%n in ('git config user.name') do set GNAME=%%n
  for /f "delims=" %%e in ('git config user.email') do set GMAIL=%%e
  if not defined GNAME (
    echo   Stop: git does not know your name. Run: git config --global user.name "Your Name"
    set FAIL=1
  )
  if not defined GMAIL (
    echo   Stop: git does not know your email. Run: git config --global user.email "you@example.com"
    set FAIL=1
  )
)
uv --version >nul 2>&1
if errorlevel 1 (
  echo   Stop: uv is not installed. The BMad scripts use it. Install it with: pip install uv
  set FAIL=1
) else (
  for /f "delims=" %%v in ('uv --version') do echo   %%v
)
where code >nul 2>&1
if errorlevel 1 (
  echo   Note: the code command was not found. You can still open the folder from VS Code with File, Open Folder.
) else (
  echo   VS Code command code found
)
if "%FAIL%"=="1" (
  echo.
  echo Fix the items above, open a new terminal and run scripts\setup.cmd again.
  exit /b 1
)
echo.
echo Checking the project
if not exist "product\.agents\skills" (
  echo   Stop: product\.agents\skills is missing. Clone the repository again.
  exit /b 1
)
if not exist "product\_bmad" (
  echo   Stop: product\_bmad is missing. Clone the repository again.
  exit /b 1
)
pushd product
uv run --no-cache _bmad/scripts/resolve_config.py --project-root . --key core.active_initiative
if errorlevel 1 (
  popd
  echo   Stop: BMad could not read its configuration. Re-run this script. If it still fails, tell the presenter.
  exit /b 1
)
popd
echo.
echo Ready. Open the product folder in VS Code.
endlocal
