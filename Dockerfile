FROM node:16

# Create non-root app user
RUN useradd -m medusauser

# Set working directory
WORKDIR /usr/src/app

# Install Medusa CLI globally
RUN npm install -g @medusajs/medusa

# Copy and fix permissions on package files
COPY package*.json ./
RUN npm install

# Copy app files and fix permissions
COPY . .

# Set proper permissions
RUN chown -R medusauser:medusauser /usr/src/app

# Copy .env template as .env
RUN cp .env.template .env

# Switch to non-root user
USER medusauser

# Expose port
EXPOSE 9000

# Start Medusa
CMD ["medusa", "start"]
