# Estágio de build
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Copia os arquivos de dependências
COPY go.mod go.sum ./
RUN go mod download

# Copia o código-fonte
COPY . .

# Compila o projeto
RUN go build -o app ./cmd/ordersystem/main.go ./cmd/ordersystem/wire_gen.go

# Estágio final
FROM alpine:latest

WORKDIR /app

# Instala dependências necessárias no Alpine
RUN apk add --no-cache libc6-compat

# Copia o binário do estágio de build
COPY --from=builder /app/app .

# Copia o arquivo .env (se necessário)
COPY cmd/ordersystem/.env .

# Torna o binário executável
RUN chmod +x /app/app

# Expõe as portas necessárias
EXPOSE 8000 8080 50051

# Comando para executar o aplicativo
CMD ["./app"]
