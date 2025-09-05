# Instruções de Configuração do Projeto

Este documento descreve os passos necessários para configurar e executar o projeto, que utiliza Docker, Make e suporta três tipos de servidores: Web, gRPC e GraphQL.

## Pré-requisitos
- Docker e Docker Compose instalados.
- Make instalado.
- Banco de dados configurado (verifique as configurações no arquivo `docker-compose.yml`).
- [Evans](https://github.com/ktr0731/evans) instalado para chamadas gRPC (instruções de instalação disponíveis no link).
- Variáveis de ambiente configuradas no arquivo `.env`.

## Passos para Configuração

1. **Configurar o arquivo de ambiente**  
   Copie o arquivo `.env_default` e renomeie-o para `.env`. Adicione os valores necessários para as configurações do projeto:
   ```
   cp .env_default .env
   ```
   Edite o arquivo `.env` com um editor de texto para incluir as configurações específicas, como portas e credenciais do banco de dados.

2. **Iniciar os serviços com Docker Compose**  
   Execute o seguinte comando para iniciar os contêineres (Web, gRPC e GraphQL) em modo detached:
   ```
   docker-compose up -d
   ```

3. **Executar as migrações do banco de dados**  
   Para criar as tabelas no banco de dados, execute:
   ```
   make migrate
   ```
   Caso precise deletar as tabelas criadas, execute:
   ```
   make migrate-down
   ```

## Executando o Projeto

O projeto inicializa três tipos de servidores: Web, gRPC e GraphQL. Abaixo estão as instruções para interagir com cada um.

### Chamadas Web
- As chamadas Web estão disponíveis nos arquivos localizados na pasta `API`.
- Acesse as rotas na porta **8000** (por exemplo, `http://localhost:8000`).
- Consulte a documentação ou os arquivos na pasta `API` para obter detalhes sobre as rotas disponíveis.

### Chamadas gRPC
- Utilize o [Evans](https://github.com/ktr0731/evans) para realizar chamadas gRPC.
- Certifique-se de que o servidor gRPC está rodando na porta **50051** (padrão).
- Exemplo de comando para iniciar o Evans em modo REPL:
  ```
  evans  -r repl
  ```
- Consulte a documentação do Evans para mais detalhes sobre como realizar chamadas gRPC.

### Chamadas GraphQL
- Acesse o endpoint GraphQL na porta configurada no arquivo `.env` (verifique a variável correspondente, por exemplo, `GRAPHQL_PORT`).
- Utilize um cliente GraphQL (como o GraphiQL ou Insomnia) para executar queries no endereço, por exemplo, `http://localhost:<porta_configurada>`.
- Consulte a documentação do schema GraphQL para detalhes sobre as queries disponíveis.

## Notas
- Certifique-se de que todas as variáveis de ambiente no arquivo `.env` estão corretamente configuradas antes de iniciar o projeto.
- Para verificar os logs dos contêineres, use:
  ```
  docker-compose logs
  ```
