FROM node:16

# Set the working directory
WORKDIR /usr/src/app

# Copy package manifests and install dependencies
COPY package*.json ./
RUN npm install

# Copy all application files (including src, .env.template, etc.)
COPY . .

# Copy the .env.template as .env (adjust if you want to supply your own .env)
RUN cp .env.template .env

# Expose the port that Medusa uses
EXPOSE 9000

# Run the Medusa server using npx to avoid permission issues
CMD ["npx", "medusa", "start"]
