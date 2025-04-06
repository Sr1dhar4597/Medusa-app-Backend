# Stage 1: Build the application
FROM node:20-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the project
COPY . .

# Build the application using npx to avoid global install errors
RUN npx medusa build

# Stage 2: Production image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy node_modules and build artifacts from builder
COPY --from=builder /app /app

# Expose Medusa's default port
EXPOSE 9000

# Start the server
CMD ["npx", "medusa", "start"]
