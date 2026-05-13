# flask-docker-cicd

![Python](https://img.shields.io/badge/Python-3.12-3776AB?logo=python)
![Flask](https://img.shields.io/badge/Flask-3.0.3-000000?logo=flask)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker)
![CI/CD](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?logo=githubactions)
![License](https://img.shields.io/badge/License-MIT-blue)
![Status](https://img.shields.io/badge/Status-Active-success)

> A containerized Python Flask application with a fully automated GitHub Actions 
> CI/CD pipeline that builds and pushes a Docker image to Docker Hub on every commit.

---

## Overview
This project containerizes a Python Flask web application using Docker and automates
the build and deployment process using GitHub Actions — pushing a new image to
Docker Hub on every commit to main with zero manual steps.

## Skills Demonstrated
1. Containerization — packaging a Python application into a portable Docker image
2. CI/CD Pipeline Design — automating build and push workflows using GitHub Actions
3. Security-Based Design — scoped Docker Hub access tokens, GitHub Secrets
   management, and sensitive file exclusion via `.dockerignore`

## Main Objective
Containerize a Python Flask application using Docker and implement a fully
automated CI/CD pipeline that builds, tags, and pushes the Docker image to
Docker Hub on every commit — provisionable and tearable with a single command.

---

## Architecture
Code Change in VS Code
│
▼
Push to GitHub (main branch)
│
▼
GitHub Actions triggers ci.yml
│
▼
┌─────────────────────────┐
│  Ubuntu Runner           │
│  ├── Checkout code       │
│  ├── Login to Docker Hub │
│  ├── Generate image tags │
│  └── Build & push image  │
└─────────────────────────┘
│
▼
Docker Hub — powershellwarrior/flask-docker-cicd
│
▼
┌─────────────────────┐
│ Tags                │
│ ├── latest          │
│ └── sha-xxxxxxx     │
└─────────────────────┘

### File Summary

| File | Purpose |
|---|---|
| `app.py` | Flask web application with `/` and `/health` endpoints |
| `requirements.txt` | Pinned Python dependencies |
| `Dockerfile` | Container build instructions using `python:3.12-slim` |
| `.dockerignore` | Excludes unnecessary files from the Docker image |
| `.github/workflows/ci.yml` | GitHub Actions CI/CD pipeline definition |
| `.gitignore` | Protects sensitive and auto-generated files |

---

## Prerequisites

| Tool | Version | Purpose |
|---|---|---|
| [Python](https://python.org) | >= 3.12 | Run app locally |
| [Docker Desktop](https://docker.com/products/docker-desktop) | Latest | Build and run containers |
| [Git](https://git-scm.com) | Any | Clone this repository |

**Account Requirements:**
- A GitHub account with repository secrets configured
- A Docker Hub account with an access token

> ⚠️ **Security Warning:** Never use your Docker Hub password directly in
> GitHub Actions. Always create a scoped access token with Read and Write
> permissions only.

---

## Usage

All configurable values are managed through GitHub Secrets — no credentials
are ever hardcoded in any file. Follow the sub-sections below in order.

### Installation

1. Clone the repository:
```bash
   git clone https://github.com/YOUR_USERNAME/flask-docker-cicd.git
   cd flask-docker-cicd
```

2. Add GitHub repository secrets:
DOCKERHUB_USERNAME — your Docker Hub username
DOCKERHUB_TOKEN    — your Docker Hub access token

3. Install dependencies locally for development:
```bash
   pip install -r requirements.txt
```

### Running Locally

**Run with Python directly:**
```bash
python app.py
```

**Build and run with Docker:**
```bash
# Build the image
docker build -t flask-docker-cicd .

# Run the container
docker run -p 5000:5000 flask-docker-cicd
```

**Visit in your browser:**
http://localhost:5000         — Hello World endpoint
http://localhost:5000/health  — Health check endpoint

**Pull directly from Docker Hub:**
```bash
docker pull powershellwarrior/flask-docker-cicd:latest
docker run -p 5000:5000 powershellwarrior/flask-docker-cicd:latest
```

### CI/CD Pipeline

Every push to `main` automatically triggers the pipeline:
Push to main → Build image → Push to Docker Hub → Live in ~2 minutes

| Trigger | Builds | Pushes to Docker Hub |
|---|---|---|
| Push to `main` | ✅ Yes | ✅ Yes |
| Pull request to `main` | ✅ Yes | ❌ No |
| Push to other branches | ❌ No | ❌ No |

---

## Security Design Decisions

- **GitHub Secrets for credentials** — Docker Hub username and token are
  stored as encrypted GitHub Secrets — never hardcoded in `ci.yml`

- **Scoped access token** — A Docker Hub access token with Read and Write
  permissions only is used instead of the master account password —
  revokable instantly if compromised

- **`.dockerignore` protects image contents** — Excludes `.env`, `.git/`,
  `__pycache__/`, and virtual environments — preventing secrets from being
  baked into a public Docker image

- **`python:3.12-slim` base image** — Minimal base image reduces attack
  surface and image size compared to the full Python image

- **`debug=False` in production** — Flask debug mode is explicitly disabled
  — running debug mode in a container exposes an interactive debugger to
  the network

- **Push only on real commits** — The pipeline only pushes to Docker Hub
  on actual pushes to main — not on pull request builds

---

## Future Improvements

- [ ] Add automated testing step to pipeline before building the image
- [ ] Migrate to a private container registry such as AWS ECR for
      production use
- [ ] Add multi-stage Docker build to further reduce final image size
- [ ] Deploy container to AWS ECS using the Terraform project as the
      infrastructure foundation
- [ ] Add Docker Compose for local multi-container development
- [ ] Implement health check inside Dockerfile using `HEALTHCHECK` instruction

---

## License

This project is licensed under the MIT License — see the
[LICENSE](LICENSE) file for details.
