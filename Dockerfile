# Use Node 18 as Base image
FROM node:18-alpine

RUN apt update
RUN apt-get install -y bash curl && curl -1sLf \
    'https://dl.cloudsmith.io/public/infisical/infisical-cli/setup.deb.sh' | bash \
    && apt-get update && apt-get install -y infisical

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

ARG INFISICAL_TOKEN
ENV INFISICAL_TOKEN $INFISICAL_TOKEN
ARG INFISICAL_API_URL
ENV INFISICAL_API_URL $INFISICAL_API_URL
ARG INFISICAL_ENV
ENV INFISICAL_ENV $INFISICAL_ENV
ARG INFISICAL_PROJECT_ID
ENV INFISICAL_PROJECT_ID $INFISICAL_PROJECT_ID

# Start the application
CMD infisical run --projectId=$INFISICAL_PROJECT_ID --env $INFISICAL_ENV --token $INFISICAL_TOKEN --domain $INFISICAL_API_URL --command "npm start"