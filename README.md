# UserCrudApp

This project is a basic MVC CRUD application using **ASP.NET Core 3.1**, **Entity Framework Core**, **SQL Server**, **Razor Views**, and **Bootstrap 4**  — fully containerized with Docker Compose.

## 🚀 Getting Started

### Requirements
- [.NET Core SDK 3.1](https://dotnet.microsoft.com/download/dotnet-core/3.1)
- [Docker](https://www.docker.com/products/docker-desktop)

### 🐳 Run with Docker Compose

1. Clone the repository:
   ```bash
   git clone https://github.com/your-user/UserCrudApp.git
   cd UserCrudApp
   ```

2. Run everything:
   ```bash
   docker-compose up --build
   ```

3. Open your browser:
   - Application: [http://localhost:5000](http://localhost:5000)
   - Users CRUD: [http://localhost:5000/Users](http://localhost:5000/Users)

### ⚙️ How It Works

- The app waits until SQL Server is ready before applying Entity Framework Core migrations via a custom entrypoint.sh script.

- If migrations are not applied, the application will not start properly, so do not skip this step if running manually.

### 📁 Project Structure

```text
UserCrudApp/
├── docker-compose.yml        # Orchestrates app + DB
├── entrypoint.sh          # Migration + startup script
├── WebApp/                   # ASP.NET Core MVC App
│   ├── Dockerfile            # Docker config for WebApp
│   ├── Controllers/          # MVC Controllers
│   ├── Models/               # EF Entities
│   ├── Views/                # Razor Views
│   ├── Data/                 # DbContext
│   └── WebApp.csproj         # Project file
├── UserCrudApp.sln           # Solution containing WebApp
```

### 🧪 Features
- Full user CRUD (Create, Read, Update, Delete)
- Responsive Bootstrap UI
- Form validation
- SQL Server with Docker
- Razor Views and layout with navigation

### ⚠️ Important: entrypoint.sh line endings
If you're cloning this project on Windows, ensure the entrypoint.sh script uses LF (Unix-style) line endings:
- Open the file entrypoint.sh in VSCode
- In the bottom-right corner, click CRLF and change it to LF
- Save the file
If you don't do this, you might get the following error when running the container:
   
   ```bash
   exec ./entrypoint.sh: no such file or directory
   ```
   
This happens because Linux cannot parse scripts saved with Windows-style line endings.

### 🛠️ Troubleshooting
- Make sure ports 1433 (SQL Server) and 5000 (WebApp) are not in use.
- If you change the database name or user/password, also update:
  - docker-compose.yml
  - WebApp/appsettings.json
- If you want to run the app locally (without Docker), you need:
  - dotnet ef database update
  - dotnet run --project WebApp

But make sure a local SQL Server instance is running and reachable.


### ⚠️ Notes
- Default connection string is configured in `appsettings.json`
- Make sure port `1433` (SQL Server) and `5000` (App) are free
- You can change exposed ports in `docker-compose.yml`

---

Enjoy hacking 👨‍💻! This project is made for educational purposes and to kickstart .NET Core development with Docker.