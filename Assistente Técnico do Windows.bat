@echo off
:menu
cls
echo ==========================
echo   Escolha uma opcao:
echo ==========================
echo.
echo  1. Adaptadores de Rede 
echo  2. Ferramenta de Remocao de Malware 
echo  3. Editor de Diretiva de Grupo
echo  4. Abre o Services do Windows
echo  5. Painel de Controle do Windows
echo  6. Opcoes de desempenho do Windows
echo  7. Abre o msconfig
echo  8. Limpeza de Disco
echo  9. Gerenciamento Avançado
echo  10. UAC - Controle de Contas
echo  11. Contas de Usuarios (ou use Netplwiz)
echo  12. Configuracoes Avancadas do Windows
echo  13. Ferramenta de Backup
echo  14. Agendador de Tarefas
echo.
echo 0. Sair
echo ==========================
set /p choice=Digite sua escolha (de 1 a 14 ou 0 para sair): 

if /I "%choice%"=="1" (
    start ncpa.cpl
) else if /I "%choice%"=="2" (
    start mrt.exe
) else if /I "%choice%"=="3" (
    start gpedit.msc
) else if /I "%choice%"=="4" (
    start services.msc
) else if /I "%choice%"=="5" (
    start control.exe
) else if /I "%choice%"=="6" (
    start SystemPropertiesPerformance.exe
) else if /I "%choice%"=="7" (
    start msconfig
) else if /I "%choice%"=="8" (
    start cleanmgr.exe
) else if /I "%choice%"=="9" (
    start compmgmt.msc
) else if /I "%choice%"=="10" (
    start UserAccountControlSettings.exe
) else if /I "%choice%"=="11" (
    start control userpasswords2
) else if /I "%choice%"=="12" (
    start SystemPropertiesAdvanced.exe
) else if /I "%choice%"=="13" (
    start SystemPropertiesProtection.exe
) else if /I "%choice%"=="14" (
    start taskschd.msc
) else if "%choice%"=="0" (
    exit
) else (
    echo Opcao invalida! Tente novamente.
    pause
)

goto menu
