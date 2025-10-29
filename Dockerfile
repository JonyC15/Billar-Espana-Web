# Use a lightweight official Nginx image (Alpine is often smaller)
FROM nginx:stable-alpine

# Define the build path for your website files (e.g., the 'dist' folder)
# This is typically provided as a build argument
ARG BUILD_PATH=dist

# Copy the static website files from the local 'dist' folder 
# into the default Nginx web root directory.
COPY $BUILD_PATH /usr/share/nginx/html

# --- Cloud Run Specific Configuration ---

# 1. Override the default Nginx configuration file
#    This step is required because Cloud Run mandates that your container
#    listens on the port defined by the $PORT environment variable,
#    which Nginx won't do by default.
COPY nginx-cloudrun.conf /etc/nginx/conf.d/default.conf

# 2. Command to run Nginx
#    We use 'nginx -g "daemon off;"' to run Nginx in the foreground,
#    which is necessary for the container to stay alive in Cloud Run.
CMD ["nginx", "-g", "daemon off;"]