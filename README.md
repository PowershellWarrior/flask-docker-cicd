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
