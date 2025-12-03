@echo off
title Recuperar Senhas WiFi

:: =============================================================================
color 4
cls
echo.
echo      VERIFICANDO SE VOCE ESTA COMO ADMINISTRADOR.
echo      AGUARDE UM POUCO.
echo.
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Executando como administrador...
    powershell start -verb runas '%0' am_admin
    exit /b 1
)
cd  %userprofile%\Desktop
::==================================================================================

SETLOCAL EnableDelayedExpansion
REM Define o esquema de cores padrão global: 0B = Fundo Preto, Texto Ciano/Azul Claro
COLOR 0B

:menu1
cls
mode 80,30
SET "input="
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo   ***********************************
echo                 MENU
echo   ***********************************
echo.
echo.
echo   1) Ver senha Wifis salvas no PC;
echo.
echo   2) Somente salvar as Senhas.
echo.
echo.
echo       0) Sair agora?
echo   _________________________________
set /p input=". O que vc quer fazer: "
	if "%input%"=="1" goto versenhas
	if "%input%"=="2" goto salvarsenhas	
if "%input%"=="0" goto sair

:teclaerrada
echo      OPS, TECLA ERRADA. TENTE NOVAMENTE.
pause
goto menu1

:versenhas
color 70
cls
echo.
echo ===============================================
echo   LISTANDO REDES WiFi E SUAS SENHAS...
echo ===============================================
echo.

set count=0
set "output_file=senhas_wifi.txt"

echo Lista de Redes WiFi e Senhas > "%output_file%"
echo ============================ >> "%output_file%"
echo Data: %date% %time% >> "%output_file%"
echo. >> "%output_file%"

echo Perfis WiFi encontrados:
echo ------------------------

rem Processa a saída do netsh wlan show profile
for /F "tokens=1,* delims=:" %%a in ('netsh wlan show profile 2^>nul') do (
    set "line=%%a"
    
    rem Procura por linhas que contêm "Todos os Perfis de Usuários:"
    if "!line:Usuários=!" NEQ "!line!" (
        set "wifi_name=%%b"
        set "wifi_name=!wifi_name:~1!"
        
        if not "!wifi_name!"=="" (
            set /a count+=1
            echo !count!. !wifi_name!
            
            rem Busca a senha para esta rede
            call :get_password "!wifi_name!"
            
            echo    Senha Localizada: !password!
            echo.
            
            rem Salva no arquivo
            echo !count!. Rede: !wifi_name! >> "%output_file%"
            echo    Senha: !password! >> "%output_file%"
            echo. >> "%output_file%"
        )
    )
)

if %count% equ 0 (
    echo Nenhum perfil WiFi encontrado!
    echo Verifique se o computador tem redes WiFi salvas.
)

rem Resumo final
echo =============================
echo RESULTADO:
echo Redes encontradas: !count!
echo Arquivo salvo como: !output_file!
echo =============================

if %count% equ 0 (
    echo Nenhuma rede WiFi foi encontrada.
    echo Verifique se ha redes salvas no computador.
)
pause
goto menu1

::==================================================================================
:salvarsenhas
cls
echo.
echo.
echo   SALVAR AS SENHAS LOCALIZADAS EM UM ARQUIVO.TXT.
for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile') do @netsh wlan show profile name=%%a key=clear | findstr /n "^" | findstr /b "1: 21: 35:" >> %userprofile%\Desktop\senhas.txt
echo.
echo      AS SENHAS FORAM SALVAS NA SUA AREA DE TRABALHO.
echo.
pause
goto menu1

::=================================OLDS-COMANDS
:versenhas-002(FUNCIONA, MAS DESATIVEI, POR CAUSA DA VERSAO MELHOR ACIMA)
::cls
::echo.
::echo VER AS SENHAS WIFI DA MAQUINA.
::for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile') do @netsh wlan show profile name=%%a key=clear | findstr /n "^" | findstr /b "1: 21: 35:"
::pause
::goto menu1

::============================codigo novo
:get_password
set "password=Nao encontrada"
set "wifi_name=%~1"

rem Remove aspas se houver
set "wifi_name=!wifi_name:"=!"

if "!wifi_name!"=="" goto :eof

echo    Nome da Rede: "!wifi_name!"...

rem Executa o comando para obter informações detalhadas
set "temp_file=%temp%\wifi_temp.txt"
netsh wlan show profile name="!wifi_name!" key=clear > "%temp_file%" 2>&1

rem Procura pela senha em diferentes formatos
for /F "tokens=2 delims=:" %%p in ('type "%temp_file%" ^| findstr /i /C:"Conteudo da Chave" /C:"Key Content" /C:"Conte"') do (
    set "temp_pwd=%%p"
    call :clean_value temp_pwd
    if not "!temp_pwd!"=="" set "password=!temp_pwd!"
)

rem Se não encontrou, tenta outro formato
if "!password!"=="Nao encontrada" (
    for /F "tokens=*" %%p in ('type "%temp_file%" ^| findstr /i "Key"') do (
        set "line=%%p"
        for /F "tokens=2 delims=:" %%q in ("!line!") do (
            set "temp_pwd=%%q"
            call :clean_value temp_pwd
            if not "!temp_pwd!"=="" set "password=!temp_pwd!"
        )
    )
)

del "%temp_file%" >nul 2>&1
goto :eof

:clean_value
set "%~1=!%~1: =!"
set "%~1=!%~1:~1!"
goto :eof
::====================================fim

:Sair
exit