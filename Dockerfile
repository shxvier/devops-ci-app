FROM python:3.12-slim

LABEL org.opencontainers.image.source="https://github.com/shxvier/devops-ci-app"
LABEL org.opencontainers.image.description="DevOps CI sample application"

RUN useradd --system --no-create-home app
WORKDIR /app
COPY app/requirements.txt ./requirements.txt
RUN python -m pip install --no-cache-dir -r requirements.txt
COPY app/ ./app/
USER app
EXPOSE 5000

# Load the Flask object from the app.app module.
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--access-logfile", "-", "app:app"]
