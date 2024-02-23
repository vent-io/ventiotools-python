# Use the official Node.js image as the base image; pin to a specific-as-possible
# version for high stability, security, and reproducibility
FROM node:20.5.0-bookworm AS base

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and package-lock.json (if available) into the container
COPY package*.json ./

# Install the dependencies inside the container
RUN npm install --ignore-scripts

# Copy the rest of the application into the container; if possible, in addition to using
# a `.dockerignore`, only copy what's needed explicitly. A simple `COPY src/ src/` is
# useful, for example, and excludes test code, docs, assets, secrets (hopefully), ...
COPY index.js ./

# https://docs.docker.com/build/building/multi-stage/
FROM base AS runtime

# Document the port your application listens on; doesn't actually do publish anything
EXPOSE 3000

# Actually switch over to user, everything before was done as root
USER node

# Define the command to run the application
ENTRYPOINT [ "npm" ]
CMD [ "start" ]

FROM base AS test

# This operation does NOT DO ANYTHING, we already have all these files; it demonstrates
# how to copy files from other stages. Extremely powerful to separate build artifacts
# from runtime (not possible for interpreted languages like JavaScript)
COPY --from=base /app/index.js ./

COPY index.test.js ./

USER node

# Run the tests
ENTRYPOINT [ "npx" ]
CMD [ "jest" ]
