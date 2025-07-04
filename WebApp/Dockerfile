# Etapa de compilación
FROM mcr.microsoft.com/dotnet/core/sdk:3.1 AS build
WORKDIR /src

COPY . .
WORKDIR /src/WebApp

RUN dotnet tool install --global dotnet-ef --version 3.1.32
ENV PATH="$PATH:/root/.dotnet/tools"

RUN dotnet restore
RUN dotnet publish -c Release -o /app/out

# Etapa de runtime
FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /app

# Copiamos la app publicada
COPY --from=build /app/out ./            
COPY --from=build /src/WebApp ./src/WebApp   
COPY --from=build /root/.dotnet /root/.dotnet
COPY --from=build /root/.nuget /root/.nuget

# Copiamos el script desde la raíz del contexto
COPY ../entrypoint.sh ./entrypoint.sh

# Instalamos herramientas necesarias
RUN apt-get update && \
    ACCEPT_EULA=Y apt-get install -y curl gnupg apt-transport-https && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

# Damos permisos de ejecución
RUN chmod +x entrypoint.sh

# Variables de entorno necesarias
ENV PATH="$PATH:/root/.dotnet/tools"
ENV PATH="$PATH:/opt/mssql-tools/bin"

# Entrypoint
ENTRYPOINT ["./entrypoint.sh"]
