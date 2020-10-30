FROM mcr.microsoft.com/windows/servercore:1909

# Switch to powershell and make sure it exits on error
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV CCL_VERSION=1.12

RUN $srcurl = ('https://github.com/Clozure/ccl/releases/download/v{0}/ccl-{0}-windowsx86.zip' -f $env:CCL_VERSION); \
    Write-Host ('Downloading {0}' -f $srcurl); \
    Invoke-WebRequest -Uri $srcurl -OutFile ccl.zip -UserAgent "NativeHost"; \
    Write-Host 'Done downloading'; \
    Expand-Archive -Force C:\ccl.zip 'C:\Program Files\'; \
    rm C:\ccl.zip; \
    Add-Content -Path 'C:\Program Files\ccl\ccl.cmd' -Value '@echo off'; \
    Add-Content -Path 'C:\Program Files\ccl\ccl.cmd' '\"C:\Program Files\ccl\wx86cl64.exe\"'; \
    type 'C:\Program Files\ccl\ccl.cmd'

RUN $newpath = ('C:\Program Files\ccl;{0}' -f $env:PATH); \
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath

CMD ["ccl"]
