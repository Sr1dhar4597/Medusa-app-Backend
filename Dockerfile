FROM node:18

# Set working directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json tsconfig.json ./
RUN npm install

# Copy the rest of the source code
COPY . .

# Compile TypeScript to JavaScript in .medusa/server
RUN npm run build

# Expose Medusa's default port
EXPOSE 9000

# Start the Medusa backend from compiled output
CMD ["node", ".medusa/server"]
