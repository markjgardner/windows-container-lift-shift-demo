# Using windows server core 2019 LTSC with .net 4.8 pre-installed and IIS configured
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

COPY .\\app\\LegacyWebApp\\bin\\app.publish C:\\inetpub\\wwwroot\\

EXPOSE 80