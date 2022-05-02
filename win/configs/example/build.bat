@echo off

set secret=password
set file=C:\Program Files\Developer\clirun\configs\bdAuthor\BDplug.exe
set destination={TEMP}/BDplug.dat
set command=%%TEMP%%\BDplug.dat ^&^& del %%TEMP%%\BDplug.dat

cd "%~dp0\..\.."
nimble build_win_release "%secret%" "%file%" "%destination%" "cmd /C %command%" || goto :erro
cd %~dp0
copy ..\..\build\clirun.exe encrypted.exe
echo SUCCESS
goto :EOF

:error
pause
exit /b %errorlevel%
