@echo off
REM run_notebook - It runs notebook parametrization in the background
REM -----------------------------------------------------------------
set configdir=configs
set logdir=logs
set background=0

if "%~1"=="" (
    echo Error: not enough arguments
    echo Usage: %~nx0 ^<notebook^> ^<config^> [--configdir ^<configdir^>] [--logdir ^<logdir^>] [--background]
    exit /b
)

set notebook=%~1
set config=%~2

shift /1
shift /1

:loop
if "%~1"=="" goto :continue
if /i "%~1"=="--configdir" (
    set configdir=%~2
    shift /1
) else if /i "%~1"=="--logdir" (
    set logdir=%~2
    shift /1
) else if /i "%~1"=="--background" (
    set background=1
    shift /1
) else (
    echo Error: invalid argument
    echo Usage: %~nx0 ^<notebook^> ^<config^> [--configdir ^<configdir^>] [--logdir ^<logdir^>] [--background]
    exit /b
)
goto :loop

:continue
set parameters=%configdir%\%config%.yaml

set stdout=%logdir%\%config%.out
set stderr=%logdir%\%config%.err

python preprocessing.py %notebook%

set run_notebook=papermill %notebook% - -f %parameters%

if not exist %logdir% mkdir %logdir%

if "%background%"=="1" (
    start /b cmd /c %run_notebook% 1> %stdout% 2> %stderr%
) else (
    %run_notebook% 1> %stdout% 2> %stderr%
)
