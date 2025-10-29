# Use the official Nginx image from Docker Hub as the base image
FROM nginx:latest

# Define the directory where your static files are located on your local machine
# Assuming your website files (index.html, CSS, JS, etc.) are in a 'dist' folder 
# relative to where you build the Docker image.
ARG BUILD_PATH=dist

# Copy the static website files from the 'BUILD_PATH' directory 
# into the default Nginx web root directory.
COPY $BUILD_PATH /usr/share/nginx/html

# Expose port 80 (the default Nginx port)
EXPOSE 80

# The default command of the Nginx image starts the server, so we don't need a CMD
# The image will run Nginx when a container is started.