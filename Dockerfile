# Base image. Defines the starting point of your image.
# Docker will download a Python image and build on top of it.
FROM python:3.14

# Sets the default directory inside the container.
WORKDIR /app

# Copies all files from the current host directory into the container's working directory (/app).
COPY . .

# Installs all Python packages listed in requirements.txt
RUN pip install -r requirements.txt

# Documents that the application listens on port 80.
EXPOSE 80

# Defines what starts when the container runs.
CMD ["python","run.py"]
