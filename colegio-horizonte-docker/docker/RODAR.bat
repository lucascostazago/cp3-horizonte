@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ============================================
echo  Colegio Horizonte - subindo os containers
echo ============================================
docker compose up -d
if errorlevel 1 (
  echo.
  echo ERRO: abra o Docker Desktop, espere ficar "Engine running" e rode de novo.
  pause
  exit /b
)
echo.
echo Aguardando o MySQL iniciar (30 segundos)...
timeout /t 30 /nobreak >nul
cls
echo ===== PRINT 1: containers em execucao =====
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
echo.
echo ===== PRINT 3: conexao ao MySQL =====
docker exec horizonte-mysql mysql -u horizonte -pHorizonte@2026 colegio_horizonte -e "SHOW TABLES; SELECT codigo, tipo, vlan, ip FROM equipamentos;"
echo.
echo ===== PRINT 4: IPs internos dos containers =====
docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" horizonte-nginx horizonte-mysql
echo.
start http://localhost:8080
echo O navegador abriu a pagina (PRINT 2).
echo Tire print desta janela e da pagina no navegador.
pause
