# Use the .NET SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy Program.cs to the container
COPY Program.cs ./

# Build and publish the application
RUN dotnet new console -n HelloWorldApp
RUN dotnet publish -c Release -o /app/out

# Use the .NET runtime image to run the application
FROM mcr.microsoft.com/dotnet/runtime:6.0

# Set working directory
WORKDIR /app

# Copy the published application from the build stage
COPY --from=build /app/out ./

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
