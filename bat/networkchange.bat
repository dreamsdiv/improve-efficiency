rem 管理者権限のポップアップ
whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)

cls.
@echo off
echo ------------------------------------------------------
echo.
echo 1.【コマンド設定】ネットワーク手動設定
echo 2.【〇〇社専用】社内有線LAN接続
echo 3.【DCHP自動接続許可】有線LAN接続
echo 4.【GUI】ネットワーク接続
echo.
echo ------------------------------------------------------

set answer=
set /p answer=番号入力：

goto %answer%


:1
@echo off
rem ------------------------------------------------------
rem IPアドレスの設定BAT
rem ------------------------------------------------------
rem ------------------------------------------------------
rem ■変更箇所■rem ネットワーク名set Ntname="イーサネット"
rem 固定で割当てるIPアドレス
rem set Ipadd=Ipadd_1.Ipadd_2.Ipadd_3.Ipadd_4
rem サブネットset Subnet=255.255.255.0
rem デフォルトゲートウェイ
rem ------------------------------------------------------
echo イーサネットに設定するIPアドレスの
echo 値を入力してください
echo.
echo.
set /p Ipadd_1=第1オクテットの値：
set /p Ipadd_2=第2オクテットの値：
set /p Ipadd_3=第3オクテットの値：
set /p Ipadd_4=第4オクテットの値：
set /p Dfgy=【第4オクテットの値】デフォルトゲートウェイ値：


rem 入力値の確認
echo ------------------------------------------------------
echo ■IPアドレスの確認■
echo.
echo 　IPアドレスは[ %Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Ipadd_4% ]に設定します
echo 　サブネットアドレスは[ %Subnet% ]に設定します
echo 　ゲートウェイ[ %Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Dfgy%]に設定します
echo.
echo ------------------------------------------------------
echo [y]:設定値で設定開始
echo [e]:設定を中止して終了
echo 上記以外:設定値修正
echo ------------------------------------------------------
rem 判定キーの初期化
set Slt=nul
set /p Slt=確認入力：
if %Slt% == e goto exitto
if %Slt% == y goto setupto
goto Loop


:setupto
cls
echo 固定IPアドレスを設定します。しばらくお待ちください。
pause
netsh interface ip set add name=%Ntname% source=static addr=%Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Ipadd_4% mask=%Subnet% gateway=%Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Dfgy% gwmetric=1
echo.
echo.
echo 固定IPアドレスを設定しました。
rem IPアドレスを表示させる
echo 設定値を確認してください。
ipconfig
pause

cls
echo -------------------------------
echo DNS設定の必要がありますか？　
echo [n]:DNS設定
echo [e]:設定完了
echo -------------------------------
set Slt=nulset /p Slt=確認入力：

if %Slt% == e goto exitto
if %Slt% == n goto dnssetuppause

:dnssetup
echo -------------------------------
echo DNSに設定するIPアドレスの
echo 値を入力してください
echo -------------------------------
set /p dns_1=第1オクテットの値：
set /p dns_2=第2オクテットの値：
set /p dns_3=第3オクテットの値：
set /p dns_4=第4オクテットの値：

cls
echo ■IPアドレスの確認■
echo.
echo 　IPアドレスは[ %dns_1%.%dns_2%.%dns_3%.%dns_4% ]に設定します
echo.
echo ------------------------------------------------------
echo [y]:設定値で設定開始
echo [e]:設定を中止して終了
echo ------------------------------------------------------
set Slt=nulset /p Slt=確認入力：
if %Slt% == e goto exitto
if %Slt% == y goto dnssetup

:dnssetup
cls
echo 固定IPアドレスを設定します。しばらくお待ちください。
pause
netsh interface ipv4 set dns %Ntname% %dns_1%.%dns_2%.%dns_3%.%dns_4%
echo.
echo.
echo 固定IPアドレスを設定しました。
ipconfig
pause
echo.

goto display
echo.

:exitto
pause
exit

:2
netsh interface ipv4 set address "イーサネット" static 192.168.219.69 255.255.255.0 192.168.219.224
netsh interface ipv4 set dns "イーサネット" static 192.168.102.33 primary
ipconfig
pause
exit

:3netsh interface ipv4 set address name="イーサネット" source=dhcp
netsh interface ipv4 set dns name="イーサネット" source=dhcp
ipconfig
pause
exit

:4
ncpa.cpl
pause
exit