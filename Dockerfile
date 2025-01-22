# Build stage
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

# Set working directory inside the container
WORKDIR /app

# Copy the project file and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the application files
COPY . ./
RUN dotnet publish -c Release -o out

# Final stage: use the runtime image to reduce size
FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /app

# Copy the published app from the build stage
COPY --from=build /app/out .

EXPOSE 80
