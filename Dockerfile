# Use an official Python image as the base
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies (if any)
# (Optional: e.g., if you need specific system libs, you can install them here)
RUN apt-get update && apt-get install -y unzip curl

# Copy dependency list and install them
COPY requirements.txt .
RUN pip install -r requirements.txt

# Copy the application code
COPY . .

# (Optional) Build the frontend assets for production in advance
# This will compile the static files (JS/CSS) without zipping them.
RUN reflex export --frontend-only --no-zip

# Expose ports for frontend (3000) and backend (8000)
EXPOSE 3000 8000

# Set an environment variable for API URL if needed (replace with your domain or IP in prod)
# This ensures the frontend knows where to reach the backend.
# For local testing (no domain), we can default to localhost.
ENV API_URL=http://localhost:8000

# Launch the app in production mode
CMD ["reflex", "run", "--env", "prod"]
