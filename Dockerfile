# Etapa 1: dependencias
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm install

# Etapa 2: producción
FROM node:18-alpine

WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

COPY --from=builder /app/node_modules ./node_modules
COPY . .

ENV NODE_ENV=production
ENV PORT=3000

USER appuser

EXPOSE 3000

CMD ["node", "server.js"]
