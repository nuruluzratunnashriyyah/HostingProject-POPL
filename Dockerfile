# Base image untuk Node.js
FROM node:18 AS build

# Set working directory
WORKDIR /app

# Copy file package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy seluruh kode
COPY . .

# Build aplikasi menggunakan Vite
RUN npm run build

# Gunakan Nginx untuk menyajikan file hasil build
FROM nginx:stable-alpine

# Copy file hasil build ke direktori Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 5173

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
