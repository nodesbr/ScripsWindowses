@echo off
title Nodes Users e Passwords
SETLOCAL EnableDelayedExpansion

REM Define o esquema de cores padrão global: 0B = Fundo Preto, Texto Ciano/Azul Claro
COLOR 0B

:: =============================================================================
:admincheck
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
goto acesss
::==================================================================================

:acesss
cls
echo.
echo.
echo    VC PRECISA DE UMA SENHA PARA ACESSAR.
echo.
set /p pass="nodes, Digite a senha: "
if "%pass%" NEQ "nodes" (
    REM Define cor vermelha para o erro
    COLOR 0C 
    echo Senha incorreta!
    pause
    COLOR 0B
    exit /b 1
)
goto menu1

:menu1
mode 80,30
cls
SET "input="
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo.
echo   ***************************************
echo                   MENU
echo   ***************************************
echo.
echo.
echo   1) Lista de Usuarios deste PC;
echo   2) Criar um novo Usuario;
echo   3) Alterar a senha de um Usuario;
echo   4) Remocao Completa de uma Conta de Usuario;
echo   5) Alterar os Previlegios de um Usuario.
echo.
echo      0) Sair agora?

echo  _________________________________
set /p input=". O que vc quer fazer: "
	if "%input%"=="1" goto listaru
	if "%input%"=="2" goto criaru
	if "%input%"=="3" goto altsenha
	if "%input%"=="4" goto rmcontau
	if "%input%"=="5" goto admgrup
if "%input%"=="0" goto sair
	
:teclaerrada
echo.
REM Define cor vermelha para o erro
COLOR 0C
echo Ops, tecla errada...
pause
REM Reseta para a cor padrao (Ciano)
COLOR 0B
goto menu1
	

:listaru
cls
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo = LISTA DE USUARIOS DESTE PC.
echo.
	net user
echo.
	pause
	goto menu1
	

:criaru
cls
SET "cusername="
SET "cpassword="
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo = CRIAR UM NOVO USUARIO PARA ESTE PC.
	set /p cusername="Nome de Usuario: "
	set /p cpassword="Senha: "
	net user %cusername% %cpassword% /add
	echo.
    REM Define cor verde para sucesso
    COLOR 0A 
    echo Informacoes do Novo usuario cadastrado:
    REM Reseta para a cor padrao (Ciano)
    COLOR 0B
    echo Usuario: %cusername%
    echo Senha:   %cpassword%
	echo.
	pause
	goto menu1


:altsenha
cls
SET "ausername="
SET "apassword="
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo = ALTERAR A SENHA DE UM USUARIO.
	set /p ausername="Qual Usuario: "

    net user %ausername% >nul 2>&1
    IF ERRORLEVEL 1 (
        echo.
        REM Define cor vermelha para o erro
        COLOR 0C 
        echo ERRO: O usuario "%ausername%" nao existe.
        echo.
        pause
        REM Reseta para a cor padrao (Ciano)
        COLOR 0B
        goto menu1
    )

	set /p apassword="Nova Senha: "
	net user %ausername% %apassword%
cls
REM Define cor verde para sucesso
COLOR 0A
echo   A senha foi alterada para:
echo.
echo   Usuario: %ausername%
echo   Nova Senha: %apassword%
echo.
	pause
    REM Reseta para a cor padrao (Ciano)
    COLOR 0B
	goto menu1
	

:rmcontau
cls
SET "rmusername="
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo = REMOVER UMA CONTA DE USUARIO.
echo  .....................................
	echo - Atencao: esta acao removera todos os dados do usuario, 
	echo   os quais nao poderao ser mais recuperados.
	echo   Um comando extra foi adicionado para remover residuos da Pasta Users.
echo  .....................................
echo.
pause
	set /p rmusername="Qual Usuario: "

    net user %rmusername% >nul 2>&1
    IF ERRORLEVEL 1 (
        echo.
        REM Define cor vermelha para o erro
        COLOR 0C 
        echo ERRO: O usuario "%rmusername%" nao existe.
        echo.
        pause
        REM Reseta para a cor padrao (Ciano)
        COLOR 0B
        goto menu1
    )

	net user %rmusername% /delete
	rd /s /q "C:\Users\%rmusername%"
	echo.
    REM Define cor verde para sucesso
    COLOR 0A 
    echo Usuario e pasta de perfil removidos.
    echo.
	pause
    REM Reseta para a cor padrao (Ciano)
    COLOR 0B
	goto menu1
	

:admgrup
cls
SET "admmusername="
SET "nivelprevilg="
SET "GrupoFinal="
REM Reseta para a cor padrao (Ciano)
COLOR 0B

echo =   MUDAR O NIVEL ACESSO DE UMA CONTA.
echo.
echo  .....................................

REM Define a variável para o nome de usuario
set /p admmusername="Para qual Usuario: "

net user %admmusername% >nul 2>&1
IF ERRORLEVEL 1 (
    echo.
    REM Define cor vermelha para o erro
    COLOR 0C 
    echo ERRO: O usuario "%admmusername%" nao existe.
    echo.
    pause
    REM Reseta para a cor padrao (Ciano)
    COLOR 0B
    goto menu1
)

echo.
echo   Para: Administradores, Usuarios ou Convidados? 
echo.
echo   1- Administradores;
echo   2- Usuarios;
echo   3- Convidados.
echo.
echo  ........................................

REM Solicita a escolha do numero
set /p nivelprevilg=". O que vc quer fazer: "

IF "%nivelprevilg%"=="1" SET GrupoFinal=Administradores
IF "%nivelprevilg%"=="2" SET GrupoFinal=Usuarios
IF "%nivelprevilg%"=="3" SET GrupoFinal=Convidados

IF "%GrupoFinal%"=="" (
echo.
    REM Define cor vermelha para o erro
    COLOR 0C 
    echo Erro: Selecao invalida. Por favor, digite 1, 2 ou 3.
echo.
    pause
    REM Reseta para a cor padrao (Ciano)
    COLOR 0B
    goto admgrup
)

REM Define cor amarela para aviso/progresso
COLOR 0E
echo Removendo o usuario dos grupos anteriores...
net localgroup Administradores %admmusername% /delete >nul 2>&1
net localgroup Usuarios %admmusername% /delete >nul 2>&1
net localgroup Convidados %admmusername% /delete >nul 2>&1
echo Limpeza de grupos concluida.

net localgroup %GrupoFinal% %admmusername% /add

echo.
REM Define cor verde para sucesso
COLOR 0A 
echo Comando executado. O usuario %admmusername% agora pertence apenas ao grupo %GrupoFinal%.
pause
REM Reseta para a cor padrao (Ciano)
COLOR 0B
goto menu1


:sair
cls
REM Reseta para a cor padrao (Ciano)
COLOR 0B
echo.
echo.
echo TCHAU, MEU AMIGO, ESPERO QUE VOLTE LOGO.
echo.
pause
REM Reseta a cor do console para o padrao do Windows antes de sair (Branco sobre Preto)
COLOR 07
exit /b 0
