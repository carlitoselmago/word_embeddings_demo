@echo off
rem Creates a local virtualenv (first run only), installs the dependencies and
rem opens the notebook in Jupyter.
setlocal
cd /d "%~dp0"

set "VENV=.venv"
set "NOTEBOOK=Word_Embeddings.ipynb"

if exist "%VENV%\Scripts\python.exe" goto :install

set "PY=python"
where py >nul 2>nul
if not errorlevel 1 set "PY=py -3"

echo Creating %VENV%...
%PY% -m venv "%VENV%"
if errorlevel 1 goto :fail

:install
set "PATH=%CD%\%VENV%\Scripts;%PATH%"

echo Installing dependencies...
python -m pip install -q numpy notebook
if errorlevel 1 goto :fail

jupyter notebook "%NOTEBOOK%"
goto :eof

:fail
echo Setup failed. Python 3 is required: https://www.python.org/downloads/
pause
exit /b 1
