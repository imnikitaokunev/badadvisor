#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["BadAdvisor.Mvc/BadAdvisor.Mvc.csproj", "BadAdvisor.Mvc/"]
RUN dotnet restore "BadAdvisor.Mvc/BadAdvisor.Mvc.csproj"
COPY . .
WORKDIR "/src/BadAdvisor.Mvc"
RUN dotnet build "BadAdvisor.Mvc.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BadAdvisor.Mvc.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "BadAdvisor.Mvc.dll"]