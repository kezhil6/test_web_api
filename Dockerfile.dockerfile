# Use official .NET runtime image for building
FROM mcr.microsoft.com/dotnet/sdk:10.0.100 AS build
WORKDIR /app

# Copy csproj and restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Copy the rest of the code and build
COPY . ./
RUN dotnet publish -c Release -o out

# Use runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS runtime
WORKDIR /app
COPY --from=build /app/out ./

# Expose the port
EXPOSE 5000

# Start the application
ENTRYPOINT ["dotnet", "test.dll"]

