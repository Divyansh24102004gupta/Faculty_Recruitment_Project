# Use Node 16 alpine as parent image
FROM node:16-alpine
# FROM node:19.5.0-alpine

# Change the working directory on the Docker image to /app
WORKDIR /app

# Copy package.json and package-lock.json to the /app directory
COPY package.json package-lock.json ./

# Install dependencies
RUN apk add --no-cache python3 make g++
RUN npm install

# Copy the rest of project files into this image
COPY . .

# Expose application port
EXPOSE 3000

# Rebuild bcrypt and start the application
CMD npm rebuild bcrypt --build-from-source && npm run dev