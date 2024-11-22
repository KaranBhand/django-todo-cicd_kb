# Use a specific Python version for stability
FROM python:3.10

# Install necessary system-level dependencies
RUN apt-get update && apt-get install -y python3-distutils python3-apt && apt-get clean

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements files first (this will benefit from Docker cache)


COPY requirements.txt /app/

# Install pip and dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Now copy the rest of the application files into the container
COPY . .

# Run database migrations
RUN python manage.py migrate

# Expose the application port
EXPOSE 8000

# Start the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
