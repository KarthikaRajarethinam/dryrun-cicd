# ☁️ Cloud Dry Run

A full-stack, containerized microservices demo featuring:

- 🟢 **NestJS**-powered microservices (`MS-A`, `MS-B`)
- ⚛️ **Next.js 15** frontend with Tailwind CSS
- 🐳 Orchestrated using **Docker Compose**

This project demonstrates frontend-to-microservices interaction, proper CORS handling, and Docker-based workflows — ideal for testing service integrations, CI pipelines, or learning scalable architecture patterns.

## 📁 Project Structure

```
cloud-dry-run/
├── backend/
│   ├── microservice-a/
│   │   ├── src/
│   │   ├── Dockerfile
│   │   └── tsconfig.json
│   └── microservice-b/
│       ├── src/
│       ├── Dockerfile
│       └── tsconfig.json
├── frontend/
│   ├── app/
│   ├── public/
│   ├── Dockerfile
│   └── tsconfig.json
├── docker-compose.yml
└── README.md
```

## ⚙️ Prerequisites

- [Node.js](https://nodejs.org/) (v18+)
- [npm](https://www.npmjs.com/)
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Git](https://git-scm.com/)

## 📦 Installation

```bash
git clone https://github.com/your-username/cloud-dry-run.git
cd cloud-dry-run
```

Install dependencies:

```bash
# Microservice A
cd backend/microservice-a
npm install

# Microservice B
cd ../microservice-b
npm install

# Frontend
cd ../../../frontend
npm install
```

## 🧪 Running Locally

```bash
# Microservice A
cd backend/microservice-a
npm run start:dev
```

```bash
# Microservice B
cd backend/microservice-b
npm run start:dev
```

```bash
# Frontend
cd frontend
npm run dev
```

## 🌐 Default Endpoints

- Frontend: http://localhost:3000
- Microservice A: http://localhost:3001/hello
- Microservice B: http://localhost:3002/hello

## 🐳 Running with Docker Compose

Build and start all containers:

```bash
docker compose up --build
```

To stop the services:

```bash
docker compose down
```

## ⚙️ Docker Best Practices

Each service should include a `.dockerignore` file with:

```
node_modules
dist
.git
Dockerfile
*.log
```

## 🌱 Environment Variables

Use `.env` files inside each service directory as needed.

Example `.env` for frontend:

```
NEXT_PUBLIC_API_A=http://localhost:3001/hello
NEXT_PUBLIC_API_B=http://localhost:3002/hello
```

## 🔁 Scripts

### Microservices

```bash
npm run start         # Production
npm run start:dev     # Development with hot-reload
npm run build         # Compile project
```

### Frontend

```bash
npm run dev           # Dev server
npm run build         # Production build
npm start             # Start prod server
```

## 🧰 Troubleshooting

| Issue                  | Solution                                          |
|------------------------|---------------------------------------------------|
| Ports in use           | Free up ports 3000, 3001, 3002                    |
| Build errors           | Delete `node_modules` and lock file, reinstall   |
| CORS errors            | Ensure `enableCors` is correctly configured      |
| Docker doesn’t rebuild | Use `--build` flag when running compose          |

## 🚀 Deployment

### Frontend

- Deploy on [Vercel](https://vercel.com/) or any Next.js compatible host

### Backend

- Containerized NestJS apps can be deployed to services like:
  - Google Cloud Run

## 📜 License

MIT

## 🙋‍♂️ Contact

Raise an issue or pull request in the repository.  
Maintained by [vivek-shreyas](https://github.com/vivek-shreyas) 
