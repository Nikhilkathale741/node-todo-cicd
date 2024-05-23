# Use the latest Node.js LTS version
FROM node:latest

# Create and set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker's caching mechanism
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Run tests (assuming your tests are set up correctly)
RUN npm test

# Expose the application port
EXPOSE 8000

# Start the application
CMD ["node", "app.js"]


