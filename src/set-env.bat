@echo off

:: ########################################################
:: # Setting up Environment...
:: ########################################################

set SCRIPT_DIR=%~dp0

:: for these we need the bin dirs in PATH
set VAGRANTDIR=%SCRIPT_DIR%tools\vagrant\vagrant\vagrant
set RUBYDIR=%VAGRANTDIR%\embedded
:: set P4MERGEDIR=%SCRIPT_DIR%tools\p4merge
:: set OPENSSHDIR=%SCRIPT_DIR%tools\sshwindows
set CONSOLE2DIR=%SCRIPT_DIR%tools\console2\Console2
set SUBLIMEDIR=%SCRIPT_DIR%tools\sublimetext2

:: set devkit vars
cmd /C %RUBYDIR%\devkitvars.bat

:: use portable git, looks for %HOME%\.gitconfig 
set GITDIR=%SCRIPT_DIR%tools\portablegit-1.7.10-preview
set HOME=%SCRIPT_DIR%home
:: set username/email
cmd /C %GITDIR%\cmd\git config --global --replace user.name %USERNAME%
cmd /C %GITDIR%\cmd\git config --global --replace user.email %USERNAME%@zuehlke.com

:: don't let VirtualBox use %HOME% instead of %USERPROFILE%, 
:: otherwise it would become confused when W:\ is unmounted 
set VBOX_USER_HOME=%USERPROFILE%

:: show the environment
echo VAGRANTDIR=%VAGRANTDIR%
echo RUBYDIR=%RUBYDIR%
echo VBOX_USER_HOME=%VBOX_USER_HOME%
echo VBOX_INSTALL_PATH=%VBOX_INSTALL_PATH%
:: echo P4MERGEDIR=%P4MERGEDIR%
:: echo OPENSSHDIR=%OPENSSHDIR%
echo CONSOLE2DIR=%CONSOLE2DIR%
echo SUBLIMEDIR=%SUBLIMEDIR%
echo GITDIR=%GITDIR%

:: command aliases
@doskey vi=sublime_text $*

set PATH=%VAGRANTDIR%\bin;%RUBYDIR%\bin;%GITDIR%\cmd;%P4MERGEDIR%;%OPENSSHDIR%;%CONSOLE2DIR%;%SUBLIMEDIR%;%VBOX_INSTALL_PATH%;%PATH%