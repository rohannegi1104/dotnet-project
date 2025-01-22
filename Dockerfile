# Use .NET SDK image for both building and running
FROM mcr.microsoft.com/dotnet/sdk:6.0

# Set working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY dotnet-core-hello-world.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY . ./

# Publish the application
RUN dotnet publish -c Release -o out

# Set the entry point to run the application
ENTRYPOINT ["dotnet", "out/dotnet-core-hello-world.dll"]
