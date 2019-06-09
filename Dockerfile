# Tag the phase with a name
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# App static files inside /app/build

FROM nginx
# EBS will look for the EXPOSE command and use it as the port for incoming traffic
EXPOSE 80
# Copy the result from the builder stage
COPY --from=builder /app/build /usr/share/nginx/html
