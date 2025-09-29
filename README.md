# 🎓 Lesson Hub API

> Modern educational platform API built with Symfony 7.3 and Docker

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/your-username/lesson-hub.git
cd lesson-hub

# Start the application
make deploy

# Access the API
curl http://localhost/api
```

## 🛠 Tech Stack

- **Framework:** Symfony 7.3
- **Language:** PHP 8.2+
- **Database:** PostgreSQL 16
- **Cache:** Redis
- **Web Server:** Nginx
- **Containerization:** Docker & Docker Compose

## 📦 Included Packages

- **Doctrine ORM** - Database abstraction layer
- **Serializer** - JSON API responses
- **Validator** - Request validation
- **CORS Bundle** - Cross-origin resource sharing
- **Maker Bundle** - Code generators (dev only)

## 🐳 Docker Setup

The application runs entirely in Docker containers:

- **app** - PHP 8.2-FPM with application code
- **webserver** - Nginx proxy
- **database** - PostgreSQL 16
- **redis** - Redis cache

## 🔧 Available Commands

```bash
make help           # Show all available commands
make up             # Start services
make down           # Stop services
make build          # Build containers
make shell          # Access app container
make logs           # View logs
make db-migrate     # Run database migrations
```

## 🏗 Development

### Prerequisites

- Docker Desktop
- Make (optional, for convenience)

### Setup

1. Copy environment file:
```bash
cp .env .env.local
```

2. Configure your local settings in `.env.local`

3. Start the application:
```bash
make deploy
```

### Database

```bash
# Create migration
make shell
php bin/console make:migration

# Run migrations
make db-migrate

# Reset database
make db-reset
```

### API Development

```bash
# Create entity
php bin/console make:entity

# Create controller
php bin/console make:controller ApiController

# Create repository
php bin/console make:repository
```

## 📁 Project Structure

```
├── config/          # Application configuration
├── docker/          # Docker configuration files
├── public/          # Web root (index.php)
├── src/            # Application source code
│   ├── Controller/  # API controllers
│   ├── Entity/      # Doctrine entities
│   └── Repository/  # Database repositories
├── var/            # Logs and cache
├── compose.yaml    # Docker services
├── Dockerfile      # PHP container configuration
└── Makefile        # Convenience commands
```

## 🔒 Security

This is an open-source project, but configured for production use. The `.gitignore` file excludes:

- Environment files with secrets
- SSL certificates and keys
- Database credentials
- Third-party service keys
- Deployment scripts

## 📝 License

This project is proprietary. See LICENSE file for details.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

---

Built with ❤️ using Symfony and Docker