# Stage 1: Build the application
FROM node:20-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the project
COPY . .

# Fix Medusa CLI permission and build
RUN chmod +x ./node_modules/.bin/medusa && \
    npx medusa build

# Stage 2: Run the app
FROM node:20-alpine

WORKDIR /app

# Copy from builder
COPY --from=builder /app /app

EXPOSE 9000

CMD ["npx", "medusa", "start"]
