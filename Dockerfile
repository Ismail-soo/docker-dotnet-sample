FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /img
COPY /src/"myWebApp.csproj" .
RUN dotnet restore "myWebApp.csproj"
COPY . .
RUN dotnet publish "myWebApp.csproj" -c Release -o /app/publish --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:8.0 as final
EXPOSE 8080
WORKDIR /app
COPY --from=build /app/publish/ ./
ENTRYPOINT ["dotnet", "myWebApp.dll"]
