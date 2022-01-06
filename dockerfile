# escape=`
# The default escape character '\' can cause problems when working with windows containers

# Using windows server core 2019 LTSC with .net 4.8 pre-installed and IIS configured
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

# Use powershell instead of the default command prompt
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Fetch additional software dependencies (for example Url Rewrite)
# For MSI installers you should use curl or invoke-webrequest. 
# The ADD directive will interpret the MSI as an archive and automatically extract it to the local file system.
RUN Invoke-Webrequest -OutFile rewrite.msi -Uri https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi

# Install dependencies, in some (many) cases you will need to explicitly wait for the installer to complete
RUN Start-Process -FilePath 'C:\\windows\\system32\\msiexec' -ArgumentList '/i','rewrite.msi','/qn','/norestart' -Wait 

# Copy our legacy webapp into the container
COPY .\\app\\LegacyWebApp\\bin\\app.publish C:\\inetpub\\wwwroot\\

# Expose your web ports (HTTP/HTTPS)
EXPOSE 80