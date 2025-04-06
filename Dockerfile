FROM node:16

# Set the working directory
WORKDIR /usr/src/app

# Copy package manifests and install dependencies
COPY package*.json ./
RUN npm install -g @medusajs/medusa && npm install

# Copy all application files (including src, .env.template, etc.)
COPY . .

# Copy the .env.template as .env (adjust if you want to supply your own .env)
RUN cp .env.template .env

# Ensure medusa is executable
RUN chmod +x $(which medusa)

# Expose the port that Medusa uses
EXPOSE 9000

# Command to run the application (production mode) using npx to avoid permission issues
CMD ["npx", "medusa", "start"]
