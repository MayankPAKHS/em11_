# Start with a minimal Debian-based image (like python:3.11-slim which is debian based)
FROM python:3.11-slim

# Prevent Python from writing .pyc files and buffer stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
# Set environment variable to avoid interactive prompts during apt install
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# Install system dependencies: Apache, PHP, and the Apache PHP module
RUN apt-get update && apt-get install -y --no-install-recommends \
    apache2 \
    php8.2 \
    libapache2-mod-php8.2 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure Apache:
# 1. Enable the rewrite module (common for PHP apps)
# 2. Ensure Apache runs in the foreground (necessary for Docker to keep the container alive)
RUN a2enmod rewrite

# Set the Apache document root to our working directory
# This assumes your index.php file is in the root of your project
RUN sed -i 's!/var/www/html!/app!g' /etc/apache2/sites-available/000-default.conf

# Copy your PHP application code into the container
COPY . /app/

# Expose port 80 (Render maps this to $PORT automatically)
EXPOSE 80

# Command to run the Apache server in the foreground
CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
