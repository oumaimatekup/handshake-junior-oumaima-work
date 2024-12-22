# Use an official Python base image
FROM python:3.9-slim
# Set the working directory
WORKDIR /app
# Copy required files
COPY requirements.txt ./
COPY app.py ./
# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install pytest
# Add a health check for the service
HEALTHCHECK CMD curl --fail http://localhost:5000/student || exit 1
# Create a non-root user
RUN useradd -m nonrootuser
USER nonrootuser
# Run the application
CMD ["waitress-serve", "--host=0.0.0.0", "--port=5000", "app:app"]
