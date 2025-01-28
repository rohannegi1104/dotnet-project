# Use the official .NET SDK image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the .csproj file and restore any dependencies (via dotnet restore)
COPY HelloWorldApp.csproj ./
RUN dotnet restore

# Copy the rest of the code
COPY . ./

# Build the project
RUN dotnet publish -c Release -o out

# Final stage: Setup the runtime environment
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "HelloWorldApp.dll"]
