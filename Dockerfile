
# Use the official Nginx base image - Alpine version is smaller
FROM nginx:stable-alpine

# Define arguments for user/group IDs (optional, good practice for permissions)
ARG PUID=101
ARG PGID=101

# Optional: Add user and group for nginx if they don't exist (alpine image does this usually)
# RUN addgroup -g ${PGID} -S nginx && adduser -u ${PUID} -D -S -h /var/cache/nginx -s /sbin/nologin -G nginx nginx

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom Nginx configuration file
# Assumes nginx.conf is in the same directory as the Dockerfile
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Remove default Nginx static assets (welcome page, etc.)
RUN rm -rf /usr/share/nginx/html/*

# Copy your website's static files from the 'src' directory
# Assumes your website files are in a 'src' directory next to the Dockerfile
COPY src/ /usr/share/nginx/html/

# Optional: Set correct permissions for the web root - ensure nginx user can read files
# Replace 'nginx' with the user Nginx runs as if different ('www-data' on Debian/Ubuntu based images)
# The alpine image uses 'nginx' user (UID 101 by default)
RUN chown -R ${PUID}:${PGID} /usr/share/nginx/html && chmod -R 755 /usr/share/nginx/html

# Expose port 8080 (the default HTTP port Nginx listens on)
EXPOSE 8080

# The base Nginx image already has a sensible CMD ["nginx", "-g", "daemon off;"]
# This runs Nginx in the foreground, which is correct for Docker.
# You don't usually need to override it unless you have specific startup scripts.