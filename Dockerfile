##############################################################################
# Dockerfile
# WHY THIS FILE EXISTS:
#   A Dockerfile is a blueprint that tells Docker how to package your
#   application into a portable, self-contained image. The same image
#   runs identically on your laptop, a teammate's machine, or a cloud
#   server — this is the core value of containerization.
##############################################################################

# Step 1 — Base Image
# WHY: We start from an official Python image instead of bare Linux.
#      The "slim" variant is a minimal version — smaller image size,
#      smaller attack surface. Never use "latest" in production —
#      always pin a specific version for reproducibility.
FROM python:3.12-slim

# Step 2 — Set Working Directory
# WHY: All subsequent commands run from this directory inside the
#      container. Using /app is the professional standard — it keeps
#      your application code isolated from system files.
WORKDIR /app

# Step 3 — Copy and Install Dependencies FIRST
# WHY: Docker builds in layers. By copying requirements.txt and
#      installing dependencies BEFORE copying your app code, Docker
#      caches this layer. If only your app code changes, Docker reuses
#      the cached dependency layer — making rebuilds dramatically faster.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Step 4 — Copy Application Code
# WHY: Copied after dependencies intentionally — see layer caching
#      explanation above. The dot means "copy into current WORKDIR."
COPY app.py .

# Step 5 — Expose Port
# WHY: Documents which port the container listens on. This does not
#      actually publish the port — that happens at runtime with -p.
#      It is documentation for anyone reading the Dockerfile and
#      required for container orchestration tools like Kubernetes.
EXPOSE 5000

# Step 6 — Run Command
# WHY: CMD defines what runs when the container starts. We use the
#      JSON array format ["python", "app.py"] instead of a shell
#      string "python app.py" because it runs the process directly
#      without a shell wrapper — cleaner signal handling and faster
#      container startup.
CMD ["python", "app.py"]