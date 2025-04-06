FROM node:16

# Set working directory
WORKDIR /usr/src/app

# Install Medusa CLI globally
RUN npm install -g @medusajs/medusa

# Copy application dependencies and install
COPY package*.json ./
RUN npm install

# Copy rest of the project files
COPY . .

# Copy environment file
RUN cp .env.template .env

# Expose port
EXPOSE 9000

# Start Medusa server
CMD ["medusa", "start"]
