# --- Base Stage ---
    FROM node:18-alpine AS base

    WORKDIR /app
    COPY package*.json ./
    RUN npm install
    
    # --- Build Stage ---
    FROM base AS build
    COPY . .
    RUN npm run build
    
    # --- Production Stage ---
    FROM node:18-alpine AS prod
    
    WORKDIR /app
    
    # Copy only built output and dependencies
    COPY --from=build /app/node_modules ./node_modules
    COPY --from=build /app/dist ./dist
    COPY package*.json ./
    
    EXPOSE 3001
    
    CMD ["node", "dist/main"]
    
