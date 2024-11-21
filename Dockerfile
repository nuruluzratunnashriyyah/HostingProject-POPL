# Gunakan image Node.js versi LTS
FROM node:16

# Set working directory
WORKDIR /app

# Salin package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Salin semua file proyek ke dalam container
COPY . .

# Expose port Vite (default: 5173)
EXPOSE 5173

# Jalankan server development
CMD ["npm", "run", "dev", "--", "--host"]
