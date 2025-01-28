# Use the official .NET SDK image for building the app (with version 7)
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the .csproj file and restore any dependencies
COPY HelloWorld.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY . ./

# Build and publish the application in release mode
RUN dotnet publish -c Release -o /out

# Use the official .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# Set the working directory for the runtime container
WORKDIR /app

# Copy the published output from the build container
COPY --from=build /out .

# Set the entry point to run the app
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
