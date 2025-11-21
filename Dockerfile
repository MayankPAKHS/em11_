# Start with a minimal Debian-based image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=8000

WORKDIR /app

# Install PHP and essential dependencies using generic package names
RUN apt-get update && apt-get install -y --no-install-recommends \
    php-cli \
    php-common
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get install -y --no-install-recommends unzip
RUN unzip em11.zip

# Copy your PHP application code into the container
COPY . /app/

# Expose the port (Render will use this)
EXPOSE ${PORT}

# Start the PHP development server, listening on all interfaces (0.0.0.0)
# and using the PORT environment variable set by Render.
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT} -t /app"]
