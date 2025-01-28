# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the project files into the container
COPY . .

# Restore dependencies (if any)
RUN dotnet restore

# Publish the application (output will be in the /out directory)
RUN dotnet publish -c Release -o /out

# Use the official .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime

# Set the working directory in the runtime container
WORKDIR /app

# Copy the published output from the build stage
COPY --from=build /out .

# Set the entry point to run the app
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
