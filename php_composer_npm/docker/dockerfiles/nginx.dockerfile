FROM nginx:stable-alpine
 
WORKDIR /etc/nginx/conf.d
 
COPY docker/conf/nginx/default.conf .
 
# RUN mv default.conf default.conf

# Expose port 80
EXPOSE 80