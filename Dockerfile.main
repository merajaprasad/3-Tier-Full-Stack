# Use Node 18 as Base image
FROM node:18-alpine

# set working directory inside the Docker image to /app
WORKDIR /app

# Copy package.json and package-lock.json files to /app directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the project files
COPY . .

# Expose Application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
