# Start with a minimal Debian-based image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DEBIAN_FRONTEND=noninteractive
ENV PORT=8000

WORKDIR /app

# Install unzip and other system dependencies using generic package names
RUN apt-get update && apt-get install -y --no-install-recommends \
    unzip \
    php-cli \
    php-common \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the zip archive that contains the full project
COPY em11.zip /app/em11.zip

# Unzip into the current directory (/app) and remove the zip file afterward
RUN unzip -q em11.zip -d /app && rm em11.zip

# Expose the port (Render will use this)
EXPOSE ${PORT}

# Start the PHP development server
CMD ["sh", "-c", "php -S 0.0.0.0:${PORT} -t /app"]
