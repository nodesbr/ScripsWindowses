@echo off
:menu
cls
echo ==========================
echo.
echo  Escolha uma opcao:
echo   1 - Corrigir unidade de disco
echo   2 - Formatar unidade de disco
echo   3 - Limpar unidade de disco
echo   4 - Limpar arquivos temporarios
echo   5 - Corrigir pendrive defeituoso
echo.
echo   0 - Sair
echo ==========================
set /p opcao=Digite sua opcao: 

if "%opcao%" == "1" goto corrigir
if "%opcao%" == "2" goto formatar
if "%opcao%" == "3" goto limpar_unidade
if "%opcao%" == "4" goto limpar_temp
if "%opcao%" == "5" goto corrigir_pendrive
if "%opcao%" == "0" goto sair

echo Opcao invalida. Por favor, tente novamente.
pause
goto menu

:corrigir
echo Digite a letra da unidade que deseja corrigir (ex: D):
set /p unidade=
chkdsk %unidade%: /f
goto fim

:formatar
echo Digite a letra da unidade que deseja formatar (ex: D):
set /p unidade=
echo AVISO: Todos os dados na unidade %unidade%: serao perdidos. Deseja continuar? (s/n)
set /p confirmacao=

if /i "%confirmacao%" == "s" (
    format %unidade%: /fs:NTFS /q
    echo Unidade %unidade%: formatada com sucesso.
) else (
    echo Operacao cancelada.
)
goto fim

:limpar_unidade
echo Digite a letra da unidade que deseja limpar (ex: D):
set /p unidade=
cleanmgr /d %unidade%:
echo Limpeza de disco iniciada na unidade %unidade%:.
goto fim

:limpar_temp
echo Limpando arquivos temporarios...
del /q /f /s %temp%\*.*
echo Arquivos temporarios no %temp% limpos com sucesso.
echo Limpando cache do Internet Explorer...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
echo Limpando cache do navegador Edge...
rmdir /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Cache"
echo Limpando cache da Windows Store...
wsreset.exe
echo Limpando cache do Google Chrome...
rmdir /s /q "%localappdata%\Google\Chrome\User Data\Default\Cache"
echo Limpando cache do Mozilla Firefox...
rmdir /s /q "%localappdata%\Mozilla\Firefox\Profiles\*.default-release\cache2"
echo Todos os arquivos temporarios foram limpos com sucesso.
goto fim

:corrigir_pendrive
echo Digite a letra da unidade do pendrive que deseja corrigir (ex: E):
set /p unidade=
chkdsk %unidade%: /r /f
goto fim

:sair
exit

:fim
pause
goto menu
