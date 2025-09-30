FROM node:lts-alpine

RUN apk add --no-cache bash libc6-compat openssl

WORKDIR /home/node/app

# copiar package e instalar
COPY package*.json ./
RUN npm ci

COPY . .

# gerar prisma para o target musl (garante binários compatíveis)
RUN npx prisma generate

USER node
EXPOSE 3000
CMD ["npm","run","start:prod"]
