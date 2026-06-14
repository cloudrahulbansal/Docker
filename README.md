# Flask App — AWS ECS Deployment

A minimal Flask web application built for learning containerization and deployment to **AWS EC2 using Docker**.


![Python](https://img.shields.io/badge/Python-3.14-blue)
![Flask](https://img.shields.io/badge/Flask-3.1.1-green)
![Docker](https://img.shields.io/badge/Docker-Ready-2496ED)
![AWS ECS](https://img.shields.io/badge/AWS-ECS-FF9900)

## Features

- Responsive landing page with modern glassmorphism UI
- `/health` endpoint for ECS load balancer health checks
- Two Dockerfiles — simple and multistage (distroless)

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flask 3.1.1 |
| Runtime   | Python 3.14 |
| Container | Docker (python / distroless) |
| Deploy    | AWS ECS |

## Project Structure

```
flask-app-ecs/
├── app.py                 # Flask app with routes
├── run.py                 # Entry point (host 0.0.0.0, port 80)
├── requirements.txt       # Python dependencies
├── templates/
│   └── index.html         # Landing page
├── Dockerfile             # Simple single-stage build
└── Dockerfile-multi       # Multistage build with distroless
```

## Quick Start

### Run locally

```bash
pip install -r requirements.txt
python run.py
```

App runs at **http://localhost:80**.

### Run with Docker

**Simple build:**

```bash
docker build -t flask-app .
docker run -p 80:80 flask-app
```

**Multistage build (smaller, production-grade):**

```bash
docker build -f Dockerfile-multi -t flask-app .
docker run -p 80:80 flask-app
```

## Dockerfiles Explained

### Simple (`Dockerfile`)

Single-stage build using `python:3.14`. Straightforward — copies everything, installs dependencies, runs the app. Good for development and learning.

### Multistage (`Dockerfile-multi`)

Two-stage build:
1. **Builder stage** — installs dependencies into a separate directory using `python:3.14-slim`
2. **Final stage** — copies only the app and deps into a `distroless` image

Benefits:
- Smaller final image (no pip, no shell, no OS utilities)
- Reduced attack surface — distroless images contain only the app and its runtime
- Better layer caching — dependencies are copied before source code

## Endpoints

| Route     | Method | Description                     |
|-----------|--------|---------------------------------|
| `/`       | GET    | Landing page                    |
| `/health` | GET    | Health check (returns `Server is up and running`) |

