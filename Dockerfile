# Use the .NET SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set working directory
WORKDIR /app

# Copy the .csproj file and restore dependencies
COPY HelloWorldApp.csproj ./HelloWorldApp/
WORKDIR /app/HelloWorldApp
RUN dotnet restore

# Copy Program.cs and the .csproj file to the container
COPY Program.cs ./HelloWorldApp/

# Build and publish the application
RUN dotnet publish -c Release -o /app/out

# Use the .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/runtime:8.0

# Set working directory
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/out ./

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
