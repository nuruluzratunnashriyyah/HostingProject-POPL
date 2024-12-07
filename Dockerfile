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

# Install Node.js runtime untuk script tambahan
RUN apk add --no-cache nodejs npm

# Copy file hasil build ke direktori Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Copy script Node.js (jika perlu dijalankan dalam container ini)
COPY --from=build /app/enableVersioning.js /app/

# Jalankan script Google Cloud Storage sebelum Nginx
RUN node /app/enableVersioning.js

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
