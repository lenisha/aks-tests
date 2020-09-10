FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019 AS runtime
WORKDIR /inetpub/wwwroot

COPY ./*.cer ./


USER ContainerUser

#RUN powershell $securepwd = 'test1234' | ConvertTo-SecureString; Import-PfxCertificate -CertStoreLocation 'Cert:\LocalUser\My' -Password  $securepwd -FilePath "./localhost.pfx"  -Verbose
RUN powershell Import-Certificate -FilePath "./docs.cer" -CertStoreLocation 'Cert:\CurrentUser\My' -Verbose

USER ContainerAdministrator
RUN powershell Import-Certificate -FilePath "./fiddlerroot.cer" -CertStoreLocation 'Cert:\LocalMachine\Root' -Verbose

