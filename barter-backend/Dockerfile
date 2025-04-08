# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory in the container
WORKDIR /app

RUN npm install -g pnpm@latest-10

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN pnpm install

# Copy the rest of the application code to the working directory
COPY . .

# Build the AdonisJS application
RUN npm run build

# Expose the port that AdonisJS will listen on
EXPOSE 3333

RUN chmod +x deployment/run.sh
