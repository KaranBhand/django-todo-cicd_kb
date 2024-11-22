# Use a specific Python version for stability
FROM python:3.10

# Set the working directory inside the container
WORKDIR /data

# Install necessary system-level dependencies
RUN apt-get update && apt-get install -y python3-distutils python3-apt && apt-get clean

# Install Django
RUN pip install django==3.2

# Copy application files into the container
COPY . .

# Ensure the Django application has all dependencies installed (e.g., for migrations)
RUN pip install -r requirements.txt || true

# Run database migrations
RUN python manage.py migrate

# Expose the application port
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
