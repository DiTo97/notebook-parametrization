@echo off
set notebook=%1
set config=%2

set parameters=configs\%config%.yaml

set stdout=logs\%config%.out
set stderr=logs\%config%.err

python preprocessing.py %notebook%

set run_notebook=papermill %notebook% - -f %parameters%

if not exist logs mkdir logs

if "%3"=="--background" (
    start /b cmd /c %run_notebook% 1> %stdout% 2> %stderr%
) else (
    %run_notebook% 1> %stdout% 2> %stderr%
)
