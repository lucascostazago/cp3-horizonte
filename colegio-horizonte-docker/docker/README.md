# Colégio Horizonte – Docker (CP3)

Pré-requisito: Docker Desktop aberto (Windows/Mac) ou Docker Engine (Linux).

## 1. Subir os containers
Abra o terminal nesta pasta (onde está o `docker-compose.yml`) e rode:

```bash
docker compose up -d
```

## 2. Evidências para tirar print

**a) Containers em execução**
```bash
docker ps
```
Devem aparecer `horizonte-nginx` (0.0.0.0:8080->80/tcp) e `horizonte-mysql` (0.0.0.0:3307->3306/tcp).

**b) Página no navegador**
Abra http://localhost:8080 e tire print da página do Colégio Horizonte.

**c) Conexão ao MySQL** (aguarde ~20 s após subir, o MySQL demora para iniciar)
```bash
docker exec -it horizonte-mysql mysql -u horizonte -pHorizonte@2026 colegio_horizonte -e "SHOW TABLES; SELECT codigo, tipo, vlan, ip FROM equipamentos;"
```

**d) IPs internos dos containers**
```bash
docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" horizonte-nginx horizonte-mysql
```
Esperado: nginx 172.20.0.10 e mysql 172.20.0.20.

**e) (Opcional) Conectar pelo MySQL Workbench/DBeaver**
Host `127.0.0.1`, porta `3307`, usuário `horizonte`, senha `Horizonte@2026`.

## Alternativa sem compose (docker run)
```bash
docker network create --subnet 172.20.0.0/24 horizonte-net
docker run -d --name horizonte-mysql --network horizonte-net --ip 172.20.0.20 -p 3307:3306 -e MYSQL_ROOT_PASSWORD=Root@Horizonte2026 -e MYSQL_DATABASE=colegio_horizonte -e MYSQL_USER=horizonte -e MYSQL_PASSWORD=Horizonte@2026 -v "$(pwd)/mysql/init.sql:/docker-entrypoint-initdb.d/init.sql:ro" mysql:8.0
docker run -d --name horizonte-nginx --network horizonte-net --ip 172.20.0.10 -p 8080:80 -v "$(pwd)/nginx/html:/usr/share/nginx/html:ro" nginx:alpine
```
(No PowerShell troque `$(pwd)` por `${PWD}`.)

## Problemas comuns
- **Porta em uso**: troque `8080` ou `3307` no `docker-compose.yml` (lado esquerdo do `:`).
- **Subnet em conflito**: troque `172.20.0.0/24` por `172.28.0.0/24` e ajuste os IPs.
- **Banco sem tabelas**: o `init.sql` só roda na primeira subida. Use `docker compose down -v` e suba de novo.

## Parar
```bash
docker compose down        # para e remove os containers
docker compose down -v     # também apaga o banco
```
