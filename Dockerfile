# Estágio de build
FROM golang:1.24-alpine AS builder

WORKDIR /app

# Copia os arquivos de dependências
COPY go.mod go.sum ./
RUN go mod download

# Copia o código-fonte
COPY . .

# Compila o projeto
RUN CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build -o app ./cmd/ordersystem/main.go ./cmd/ordersystem/wire_gen.go

# Estágio final
FROM alpine:latest

WORKDIR /app

# Instala dependências necessárias no Alpine (libc6-compat para compatibilidade, ca-certificates para SSL se necessário)
RUN apk add --no-cache ca-certificates tzdata make git curl

# Copia o binário do app e o migrate do estágio de build
COPY --from=builder /app/app .

# Copia o arquivo .env (se necessário para o app)
COPY cmd/ordersystem/.env .

# Torna os binários executáveis
RUN chmod +x /app/app 

# Expõe as portas necessárias
EXPOSE 8000 8080 50051

# Comando para executar o entrypoint (que roda migração + app)
CMD ["./app"]