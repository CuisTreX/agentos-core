@echo off
REM AgentOS Project Creator for Windows
REM Usage: create_project.bat "project-name"
REM Creates a numbered AgentOS project directory from the project template.

setlocal enabledelayedexpansion

set SCRIPT_DIR=%~dp0
set WORKSPACE_ROOT=%SCRIPT_DIR%..
set TEMPLATE_DIR=%WORKSPACE_ROOT%\templates\project_template

if "%~1"=="" (
    echo Error: Project name is required.
    echo Usage: create_project.bat "project-name"
    echo Example: create_project.bat "user-service"
    exit /b 1
)

set PROJECT_NAME=%~1

REM Find the next project number
set NEXT_NUM=1
set INDEX=0
for /d %%d in ("%WORKSPACE_ROOT%\Project_*_*") do (
    set "DIRNAME=%%~nxd"
    set "NUM=!DIRNAME:~8,2!"
    REM Remove leading zero
    set /a NUMVAL=!NUM!
    if !NUMVAL! geq !NEXT_NUM! (
        set /a NEXT_NUM=!NUMVAL!+1
    )
)

REM Format project number
set PADDED_NUM=0!NEXT_NUM!
set PADDED_NUM=!PADDED_NUM:~-2!

set PROJECT_DIR=%WORKSPACE_ROOT%\Project_%PADDED_NUM%_%PROJECT_NAME%

if exist "%PROJECT_DIR%" (
    echo Error: Project directory already exists: %PROJECT_DIR%
    exit /b 1
)

if not exist "%TEMPLATE_DIR%" (
    echo Error: Template directory not found: %TEMPLATE_DIR%
    echo Make sure this script is in the AgentOS\scripts\ directory.
    exit /b 1
)

REM Create project directory and copy template
mkdir "%PROJECT_DIR%"
xcopy /E /I /Q "%TEMPLATE_DIR%\*" "%PROJECT_DIR%\"

echo.
echo Project created: %PROJECT_DIR%
echo.
echo Next steps:
echo   1. Edit PROJECT_MANIFEST.md - fill in project name, description, tech stack
echo   2. Edit PROJECT_MEMORY.md - document initial architecture and constraints
echo   3. Add project to 00_WORKSPACE_MANIFEST.md under Projects
echo   4. Create initial DECISION_LOG.md entry
echo   5. Start your first AI session
