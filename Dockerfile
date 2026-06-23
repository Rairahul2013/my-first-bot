# Base image
FROM node:20-buster

# Install system dependencies
RUN apt-get update && apt-get install -y \
  ffmpeg \
  imagemagick \
  libwebp-dev \
  curl \
  git \
  ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

# Install Node dependencies
RUN npm install && npm install qrcode-terminal

# Copy full project
COPY . .

# Create temp folder (many bots need it)
RUN mkdir -p /tmp

# Expose port
EXPOSE 5000

# Start bot
CMD ["node", "index.js"]
