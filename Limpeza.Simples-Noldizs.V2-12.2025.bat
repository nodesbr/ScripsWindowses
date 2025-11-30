@echo off
setlocal enabledelayedexpansion
cls
echo.
echo VERIFICANDO SE VOCE ESTA COMO ADMINISTRADOR.
echo AGUARDE UM POUCO.
echo.

::Batch como Admin, Partially created by Ankh Tech==================================
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Elevando privilegios de administrador...
    powershell start -verb runas '%0' am_admin
    exit /b
)
::==================================================================================

color 9
title NtotalClean2025
mode 96,21

:: Configuracoes de cores otimizadas
for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
    set "DEL=%%a"
)

set "g=[92m"
set "r=[91m"
set "red=[04m"
set "l=[1m"
set "w=[0m"
set "b=[94m"
set "m=[95m"
set "c=[35m"
set "d=[96m"
set "u=[0m"
set "z=[91m"
set "n=[96m"
set "y=[40;33m"
set "g2=[102m"
set "r2=[101m"
set "t=[40m"
set "gg=[93m"
set "q=[90m"
set "gr=[32m"
set "o=[38;5;202m"
set "bb=[38;5;74m"
set "nn=[38;5;82m"
set "rr=[1;91m"
set "blb=[1;94m"
set "neon_vp=[1;38;5;129m"
set "ha=[38;5;203m"

:limpbav
mode 105,30
cls
echo.
echo.
echo.
echo   %BLUE%====================================================================================================%RESET%
echo.
echo    %y%LIMPEZA BASICA E AVANCADA DO WINDOWS%w%
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
echo.
echo.
echo 		%o%[1]%gg% Limpeza Basica%w%
echo.
echo 		%o%[2]%gg% Limpeza Avancada%w%
echo.
echo 		%o%[3]%gg% Corrigir Windows%w%
echo.
echo 		%o%[4]%gg% Limpeza de RAMs%w%
echo.
echo 		%o%[5]%gg% Limpeza de Discos%w%
echo.
echo 		%o%[6]%gg% Manutencao em DISCOS%w%
echo.
echo.
echo.
echo.
echo               %w%0 - Sair%gg%
echo.
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
set /p "escolha=. Digite sua escolha:%bb% "

if "%escolha%"=="1" goto limpeza1
if "%escolha%"=="2" goto limpeza2
if "%escolha%"=="3" goto otmz
if "%escolha%"=="4" goto rams
if "%escolha%"=="5" goto disckss
if "%escolha%"=="6" goto menunidades
   if "%escolha%"=="0" goto sair
goto limpbav

:limpeza1
cls
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
echo.
echo.
echo         %y%MUITO CUIDADO,HEIN, SERA FEITA UMA LIMPEZA GERAL DE TEMPORARIOS%w%
echo         %y%REMOVENDO APENAS LIXO DO SISTEMA, FIQUE TRANQUILO%w%
echo.
echo              Para continuar tecle: s / sim
echo              Para cancelar digite: n / nao
echo.
echo.
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
set /p "escolha=. Escolha uma opcao:%bb% "

:: Converte para minúsculas e remove espaços extras
set "escolha=%escolha:"=%"
set "escolha=%escolha: =%"
set "escolha=%escolha:~0,3%"

if /i "%escolha%"=="sim" goto Slimpeza1
if /i "%escolha%"=="Sim" goto Slimpeza1
if /i "%escolha%"=="SIM" goto Slimpeza1
if /i "%escolha%"=="s" goto Slimpeza1
if /i "%escolha%"=="nao" goto limpbav
if /i "%escolha%"=="NAO" goto limpbav
if /i "%escolha%"=="não" goto limpbav
if /i "%escolha%"=="Nao" goto limpbav
if /i "%escolha%"=="Não" goto limpbav
if /i "%escolha%"=="n" goto limpbav
if /i "%escolha%"=="N" goto limpbav

echo.
echo        %r%Eita, meu amigo, opcao invalida! Digite "sim" ou "nao".%w%
timeout /t 2 >nul
goto limpeza1

:Slimpeza1
cls
echo %g%Limpando arquivos temporarios...%w%

:: Definicao de variaveis de caminho
set "windows=%windir%"
set "systemdrive=%systemdrive%"
set "userprofile=%userprofile%"
set "temp=%temp%"
set "localappdata=%localappdata%"
set "appdata=%appdata%"

echo.
echo %g%Limpando arquivos temporarios do sistema...%w%
call :CleanPath "%windows%\temp\*.*"
call :CleanPath "%windows%\Prefetch\*.*"
call :CleanPath "%systemdrive%\Temp\*.*"
call :CleanPath "%temp%\*.*"
call :CleanPath "%userprofile%\AppData\Local\Temp\*.*"

echo.
echo %g%Limpando historico e cookies...%w%
call :CleanPath "%userprofile%\AppData\Local\Microsoft\Windows\History\*.*"
call :CleanPath "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
call :CleanPath "%userprofile%\AppData\Local\Microsoft\Windows\Recent\*.*"
call :CleanPath "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*"
call :CleanPath "%userprofile%\AppData\Local\Microsoft\Windows\Cookies\*.*"

echo.
echo %g%Limpando logs do sistema...%w%
call :ClearEventLogs

echo.
echo %g%Removendo arquivos temporarios diversos...%w%
for %%E in (etl log tmp old bak bac bup chk dmp temp) do (
    if exist "%systemdrive%\*.%%E" (
        echo Removendo .%%E
        del /f /s /q "%systemdrive%\*.%%E" >nul 2>&1
    )
)

echo.
echo %g%Limpando cache do Windows Defender...%w%
call :CleanPath "%ProgramData%\Microsoft\Windows Defender\Scans\History\*.*"

echo %g%Limpando logs de atualizacoes...%w%
call :CleanPath "%windir%\SoftwareDistribution\DataStore\Logs\*.*"
call :CleanPath "%windir%\Logs\CBS\*.*"

echo.
echo %g%Limpeza basica concluida com sucesso!%w%
timeout /t 3 >nul
goto limpbav

::==================================================================================
::==================================================================================

:disckss
cls
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
echo.
echo.
echo     %y%MUITO CUIDADO, USUARIO, SERA FEITA UMA LIMPEZA DO SSD PROFUNDA%w%
echo     %y%ESTA ACAO PODERA DEMORAR BASTANTE PARA SER CONCLUIDA...%w%
echo.
echo              Para continuar tecle: sim
echo              Para cancelar digite: nao
echo.
echo.
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
set /p "escolha=. Escolha uma opcao:%bb% "

:: Converte para minúsculas e remove espaços extras
set "escolha=%escolha:"=%"
set "escolha=%escolha: =%"
set "escolha=%escolha:~0,3%"

if /i "%escolha%"=="sim" goto Sdisckss
if /i "%escolha%"=="SIM" goto Sdisckss
if /i "%escolha%"=="Sim" goto Sdisckss
if /i "%escolha%"=="s" goto Sdisckss
if /i "%escolha%"=="S" goto Sdisckss
if /i "%escolha%"=="nao" goto limpbav
if /i "%escolha%"=="não" goto limpbav
if /i "%escolha%"=="Nao" goto limpbav
if /i "%escolha%"=="Não" goto limpbav
if /i "%escolha%"=="n" goto limpbav
if /i "%escolha%"=="N" goto limpbav

echo.
echo         %r%Eita, opcao invalida! Digite "sim" ou "nao".%w%
timeout /t 2 >nul
goto disckss

:Sdisckss
cls
echo.
echo.
echo    %g%Executando uma limpeza de Disco...%w%
echo       Isto vai demorar um pouco, mas valera a pena
echo       apenas tenha paciencia.
echo.
echo.
cleanmgr /sageset:1
cleanmgr /sagerun
cls
echo.
echo            LIMPEZA CONCLUIDA.
pause
goto limpbav

::==================================================================================
::==================================================================================

:limpeza2
cls
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
echo.
echo.
echo     %y%MUITO CUIDADO, USUARIO, SERA FEITA UMA LIMPEZA COMPLEMENTAR MAIS PROFUNDA%w%
echo     %y%ESTA ACAO PODERA REMOVER ALGUNS DADOS TEMPORARIOS UTEIS...%w%
echo.
echo              Para continuar tecle: sim
echo              Para cancelar digite: nao
echo.
echo.
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
set /p "escolha=. Escolha uma opcao:%bb% "

:: Converte para minúsculas e remove espaços extras
set "escolha=%escolha:"=%"
set "escolha=%escolha: =%"
set "escolha=%escolha:~0,3%"

if /i "%escolha%"=="sim" goto Slimpeza2
if /i "%escolha%"=="SIM" goto Slimpeza2
if /i "%escolha%"=="Sim" goto Slimpeza2
if /i "%escolha%"=="s" goto Slimpeza2
if /i "%escolha%"=="S" goto Slimpeza2
if /i "%escolha%"=="nao" goto limpbav
if /i "%escolha%"=="NÃO" goto limpbav
if /i "%escolha%"=="não" goto limpbav
if /i "%escolha%"=="Não" goto limpbav
if /i "%escolha%"=="n" goto limpbav
if /i "%escolha%"=="N" goto limpbav

echo.
echo         %r%Eita, opcao invalida! Digite "sim" ou "nao".%w%
timeout /t 2 >nul
goto limpeza2

:Slimpeza2
cls
echo %g%Limpando cache de atualizacoes do Windows...%w%
call :ManageService "wuauserv" "stop"
call :ManageService "bits" "stop"
if exist "%windir%\SoftwareDistribution" (
    rd /s /q "%windir%\SoftwareDistribution" >nul 2>&1
)
call :ManageService "wuauserv" "start" 
call :ManageService "bits" "start"
echo %g%Cache de atualizacoes limpo!%w%

echo.
echo %g%Limpando cache de impressoras...%w%
call :ManageService "spooler" "stop"
call :CleanPath "%windir%\System32\spool\PRINTERS\*.*"
call :ManageService "spooler" "start"
echo %g%Cache de impressoras limpo!%w%

echo.
echo %g%Limpando cache do explorador de arquivos...%w%
call :CleanPath "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db"
call :CleanPath "%appdata%\Microsoft\Windows\Recent\*.*"
echo %g%Cache do explorador limpo!%w%

echo.
echo   %g%Limpando Prefetch...%w%
call :ManageService "sysmain" "stop"
call :CleanPath "%systemroot%\Prefetch\*.*"
call :ManageService "sysmain" "start"
echo %g%Prefetch limpo!%w%
echo.

echo %g%Limpeza avancada concluida com sucesso!%w%
timeout /t 3 >nul
goto limpbav

::==================================================================================
::==================================================================================

:otmz
cls
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
echo.
echo     %y%ESSA ACAO VAI VERIFICAR E CORRIGIR SEU SISTEMA COMPLETAMENTE%w%
echo     %y%MAS ESTA ACAO VAI DEMORAR BASTANTE SER CONCLUIDA...%w%
echo.
echo              Para continuar tecle: sim
echo              Para cancelar digite: nao
echo.
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
set /p "escolha=. Escolha uma opcao:%bb% "

:: Converte para minúsculas e remove espaços extras
set "escolha=%escolha:"=%"
set "escolha=%escolha: =%"
set "escolha=%escolha:~0,3%"

if /i "%escolha%"=="sim" goto Sotmz
if /i "%escolha%"=="s" goto Sotmz
 if /i "%escolha%"=="nao" goto limpbav
 if /i "%escolha%"=="n" goto limpbav

echo.
echo         %r%Eita, opcao invalida! Digite "sim" ou "nao".%w%
timeout /t 2 >nul
goto otmz

:Sotmz
cls
echo.
echo.
echo      %y%Verificando arquivos corrompidos no Windows...%w%
sfc /scannow
chkdsk /f /r /b
chkdsk /f /r /x /b
echo.
echo      %y%Iniciando reparo da imagem do Windows...%w%

REM --- EXECUTA CHECKHEALTH ---
echo    Executando: DISM /CheckHealth
DISM /Online /Cleanup-Image /CheckHealth

REM Verifica se houve erro no CheckHealth
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo    Erro encontrado no CheckHealth. Executando RestoreHealth...
    DISM /Online /Cleanup-Image /RestoreHealth
    goto limpbav
)
echo.
echo    Nao foram encontrados problemas no CheckHealth. Executando ScanHealth por garantia...
echo.

REM --- EXECUTA SCANHEALTH ---
DISM /Online /Cleanup-Image /ScanHealth

REM Verifica se houve erro no ScanHealth
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo Problemas foram detectados no ScanHealth. Executando RestoreHealth...
    DISM /Online /Cleanup-Image /RestoreHealth
    goto limpbav
)
echo.
echo Nenhum problema encontrado. Nenhuma acao e necessaria.

timeout /t 3 >nul
goto limpbav

::==================================================================================
::==================================================================================

:rams
cls
echo %y%As memorias rams serao otimizadas...%w%
echo.
set "emptyStandbyList=%~dp0EmptyStandbyList.exe"
if not exist "%emptyStandbyList%" (
    echo.
    echo    %r%[ERRO] O arquivo EmptyStandbyList.exe nao foi encontrado.%w%
    echo    %y%Certifique-se de que ele estaja na mesma pasta deste script.%w%
	echo.
	echo.
	echo    Vc sera redirecionado para site oficial para baixar o arquivo.
	echo    Baixe-o e o salve na mesma pasta deste Script com o seguinte nome: "EmptyStandbyList".
	echo.
    start https://github.com/stefanpejcic/EmptyStandbyList/blob/master/EmptyStandbyList.exe
    pause
    goto limpbav
)
echo %g%Limpando o cache de memoria RAM...%w%
"%emptyStandbyList%" workingsets
"%emptyStandbyList%" modifiedpagelist
"%emptyStandbyList%" standbylist
echo.
echo %g%Memoria RAM otimizada com sucesso!%w%
echo.
goto limpbav

:: =============================================================================
:: CORRECAO DE UNIDADES --------------------------------------------------------
:: =============================================================================
:menunidades
cls
echo.
echo.
echo.
echo   %BLUE%====================================================================================================%RESET%
echo.
echo               %y%MANUTENCAO EM DISCOS HD e SSD%w%
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%RESET%
echo.
echo.
echo.
echo   %o%[1]%gg% - Corrigir unidade de disco
echo.
echo   %o%[2]%gg% - Formatar unidade de disco
echo.
echo   %o%[3]%gg% - Corrigir PenDrive defeituoso
echo.
echo.
echo   %g%0 - Menu Anterior
echo.
echo   %BLUE%----------------------------------------------------------------------------------------------------%gg%
set /p opcao=". Digite o numero:%bb% "

if "%opcao%" == "1" goto corrigiru
if "%opcao%" == "2" goto formataru
if "%opcao%" == "3" goto corrigir_pendriveu
if "%opcao%" == "0" goto limpbav

echo.
echo.
echo      Opcao invalida. Por favor, tente novamente.
pause
goto menunidades

:corrigiru
echo.
echo.
echo      Digite a letra da unidade que deseja corrigir (ex: D):
echo   _______________________________________________________
set /p unidade=
chkdsk %unidade%: /r /f
goto menunidades

:formataru
cls
echo.
echo      Digite a letra da unidade que deseja formatar (ex: D):
   set /p unidade=
echo.
echo      Digite o novo formato da Unidade (ex: exFAT, FAT32, NTFS):
   set /p fomatos=
echo.
echo AVISO: Todos os dados na unidade %unidade%: serao perdidos. Deseja mesmo continuar, (s/n)?
set /p confirmacao=

if /i "%confirmacao%" == "s" (
    format %unidade%: /fs:%fomatos% /q
echo.
echo.
    echo    A Unidade %unidade%: foi formatada para %fomatos% com sucesso.
) else (
    echo   Operacao cancelada.
)
goto menunidades

:corrigir_pendriveu
cls
echo.
echo.
echo      Digite a letra da unidade do pendrive que deseja corrigir (ex: E):
echo.
set /p unidade=
chkdsk %unidade%: /r /f
goto menunidades

::==================================================================================
:: SAIR 
::==================================================================================
:sair
cls
echo.
echo.
echo.
echo.
echo.
echo                         %b%BYE, meu amigo. E ate logo!%w%
echo.
timeout /t 3 >nul
exit /b