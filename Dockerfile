# Start with the official Node.js image version 19, based on Alpine Linux version 3.16
FROM node:19-alpine3.16 as development

# Set the working directory within the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if present) to the working directory
COPY package*.json .

# Run npm install to install project dependencies
RUN npm install

# Copy all files from the host machine to the working directory in the container
COPY . .

# Build the project
RUN npm run build

# Start with the official Node.js image version 19, based on Alpine Linux version 3.16
FROM node:19-alpine3.16 as production

# Set the environment variable NODE_ENV to production, with a default value of "production"
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Set the working directory within the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if present) to the working directory
COPY package*.json .

# Run npm ci with the --only=production flag to install only the production dependencies
RUN npm ci --only=production

# Copy the build artifact from the development stage to the working directory
COPY --from=development /usr/src/app/dist ./dist

# Run the command "node dist/index.js" when the container starts
CMD ["node", "dist/index.js"]

