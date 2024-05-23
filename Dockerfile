
# Create and set the working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker's caching mechanism
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Run tests
RUN npm test

# Expose the application port
EXPOSE 8000

# Start the application
CMD ["node", "app.js"]
