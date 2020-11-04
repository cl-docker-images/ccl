# escape=`

FROM mcr.microsoft.com/windows/servercore:ltsc2016

# Switch to powershell and make sure it exits on error
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV CCL_VERSION=1.12

RUN $srcurl = ('https://github.com/Clozure/ccl/releases/download/v{0}/ccl-{0}-windowsx86.zip' -f $env:CCL_VERSION); `
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Write-Host ('Downloading {0}' -f $srcurl); `
    Invoke-WebRequest -Uri $srcurl -OutFile ccl.zip -UserAgent "NativeHost"; `
    Write-Host 'Done downloading'; `
    $expectedsha256 = 'F1BA6CFF353F6E6E13828F41DC92A723C01766AE38DCFF774905C9E02D59ED04'; `
    $actualsha256 = (Get-FileHash ccl.zip -Algorithm sha256).Hash; `
    Write-Host ('Verifying sha256 {0} (expected: {1})' -f $actualsha256, $expectedsha256); `
    if ($actualsha256 -ne $expectedsha256) { `
        Write-Host 'SHA256 check FAILED!'; `
        exit 1; `
    }; `
    Expand-Archive -Force C:\ccl.zip 'C:\Program Files\'; `
    rm C:\ccl.zip; `
    Add-Content -Path 'C:\Program Files\ccl\ccl.cmd' -Value '@echo off'; `
    Add-Content -Path 'C:\Program Files\ccl\ccl.cmd' '\"C:\Program Files\ccl\wx86cl64.exe\"'; `
    type 'C:\Program Files\ccl\ccl.cmd'

RUN $machineKey = [Microsoft.Win32.Registry]::LocalMachine.OpenSubKey('SYSTEM\ControlSet001\Control\Session Manager\Environment\', $true); `
    $machinePath = $machineKey.GetValue('PATH', [string]::Empty, 'DoNotExpandEnvironmentNames').ToString(); `
    $newPath = ('C:\Program Files\ccl;{0}' -f $machinePath); `
    $machineKey.SetValue('PATH', $newPath, 'ExpandString'); `
    $machineKey.Close();

CMD ["ccl"]
