# Use a specific Python version for stability
FROM python:3.10

# Install necessary system-level dependencies
RUN apt-get update && apt-get install -y python3-distutils python3-apt && apt-get clean

# Set the working directory inside the container
WORKDIR /source

# Copy application files into the container
COPY .

# Install Django and dependencies
RUN pip install --upgrade pip
RUN pip install django==3.2
RUN pip install -r requirements.txt || true
RUN pip install -r requirements-dev.txt || true

# Run database migrations
RUN python /source/manage.py migrate

# Expose the application port
EXPOSE 8000

# Start the Django development server
CMD ["python", "/source/manage.py", "runserver", "0.0.0.0:8000"]
