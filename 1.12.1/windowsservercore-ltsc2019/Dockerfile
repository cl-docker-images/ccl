#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Switch to powershell and make sure it exits on error
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV MSYS2_VERSION 20210725

# Install msys and update it.
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Invoke-WebRequest -UseBasicParsing -uri "https://github.com/msys2/msys2-installer/releases/download/2021-07-25/msys2-base-x86_64-$env:MSYS2_VERSION.sfx.exe" -OutFile msys2.exe; \
    .\msys2.exe -y -oC:\; \
    Remove-Item msys2.exe ; \
    function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } \
    msys ' '; \
    msys 'pacman --noconfirm -Syuu'; \
    msys 'pacman --noconfirm -Syuu'; \
    msys 'pacman --noconfirm -Scc'; \
    \
    echo 'Killing msys2 subprocesses'; \
    taskkill /F /FI 'MODULES eq msys-2.0.dll'; \
    \
    echo 'Clearing Recycle Bin (see https://github.com/docker/for-win/issues/8910)'; \
    If (Test-Path 'C:\$Recycle.Bin') { Remove-Item -Force -Recurse -Path 'C:\$Recycle.Bin'; };

# Install common tools. Eventually make this equivalent to buildpack-deps.
RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    function msys() { C:\msys64\usr\bin\bash.exe @('-lc') + @Args; } \
    $env:CHERE_INVOKING = 'yes'; \
    $env:MSYSTEM = 'MINGW64'; \
    msys 'pacman -S --noconfirm --needed mingw-w64-x86_64-gcc make diffutils tar unzip mingw-w64-x86_64-zlib git' \
    \
    echo 'Installing WIX.'; \
    Invoke-WebRequest -Uri 'https://github.com/wixtoolset/wix3/releases/download/wix3112rtm/wix311-binaries.zip' -OutFile wix311-binaries.zip; \
    mkdir wix/bin; \
    cd wix/bin; \
    msys 'unzip ../../wix311-binaries.zip'; \
    cd ../../; \
    rm wix311-binaries.zip; \
    \
    echo 'Killing msys2 subprocesses'; \
    taskkill /F /FI 'MODULES eq msys-2.0.dll'; \
    \
    echo 'Clearing Recycle Bin (see https://github.com/docker/for-win/issues/8910)'; \
    If (Test-Path 'C:\$Recycle.Bin') { Remove-Item -Force -Recurse -Path 'C:\$Recycle.Bin'; };


ENV CCL_VERSION=1.12.1

RUN $srcurl = ('https://github.com/Clozure/ccl/releases/download/v{0}/ccl-{0}-windowsx86.zip' -f $env:CCL_VERSION); \
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
    Write-Host ('Downloading {0}' -f $srcurl); \
    Invoke-WebRequest -Uri $srcurl -OutFile ccl.zip -UserAgent "NativeHost"; \
    Write-Host 'Done downloading'; \
    $expectedsha256 = 'F1BA6CFF353F6E6E13828F41DC92A723C01766AE38DCFF774905C9E02D59ED04'; \
    $actualsha256 = (Get-FileHash ccl.zip -Algorithm sha256).Hash; \
    Write-Host ('Verifying sha256 {0} (expected: {1})' -f $actualsha256, $expectedsha256); \
    if ($actualsha256 -ne $expectedsha256) { \
        Write-Host 'SHA256 check FAILED!'; \
        exit 1; \
    }; \
    Expand-Archive -Force C:\ccl.zip 'C:\Program Files\'; \
    rm C:\ccl.zip; \
    Add-Content -Path 'C:\Program Files\ccl\ccl.cmd' -Value '@echo off'; \
    Add-Content -Path 'C:\Program Files\ccl\ccl.cmd' '\"C:\Program Files\ccl\wx86cl64.exe\"'; \
    type 'C:\Program Files\ccl\ccl.cmd'

RUN $machineKey = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\ControlSet001\Control\Session Manager\Environment\', $true); \
    $machinePath = $machineKey.GetValue('PATH', [string]::Empty, 'DoNotExpandEnvironmentNames').ToString(); \
    $newPath = ('C:\Program Files\ccl;{0}' -f $machinePath); \
    $machineKey.SetValue('PATH', $newPath, 'ExpandString'); \
    $machineKey.Close();

CMD ["ccl"]
