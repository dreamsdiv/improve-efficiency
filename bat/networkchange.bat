rem �Ǘ��Ҍ����̃|�b�v�A�b�v
whoami /priv | find "SeDebugPrivilege" > nul
if %errorlevel% neq 0 (
@powershell start-process %~0 -verb runas
exit
)

cls.
@echo off
echo ------------------------------------------------------
echo.
echo 1.�y�R�}���h�ݒ�z�l�b�g���[�N�蓮�ݒ�
echo 2.�y�Z�Z�А�p�z�Г��L��LAN�ڑ�
echo 3.�yDCHP�����ڑ����z�L��LAN�ڑ�
echo 4.�yGUI�z�l�b�g���[�N�ڑ�
echo.
echo ------------------------------------------------------

set answer=
set /p answer=�ԍ����́F

goto %answer%


:1
@echo off
rem ------------------------------------------------------
rem IP�A�h���X�̐ݒ�BAT
rem ------------------------------------------------------
rem ------------------------------------------------------
rem ���ύX�ӏ���rem �l�b�g���[�N��set Ntname="�C�[�T�l�b�g"
rem �Œ�Ŋ����Ă�IP�A�h���X
rem set Ipadd=Ipadd_1.Ipadd_2.Ipadd_3.Ipadd_4
rem �T�u�l�b�gset Subnet=255.255.255.0
rem �f�t�H���g�Q�[�g�E�F�C
rem ------------------------------------------------------
echo �C�[�T�l�b�g�ɐݒ肷��IP�A�h���X��
echo �l����͂��Ă�������
echo.
echo.
set /p Ipadd_1=��1�I�N�e�b�g�̒l�F
set /p Ipadd_2=��2�I�N�e�b�g�̒l�F
set /p Ipadd_3=��3�I�N�e�b�g�̒l�F
set /p Ipadd_4=��4�I�N�e�b�g�̒l�F
set /p Dfgy=�y��4�I�N�e�b�g�̒l�z�f�t�H���g�Q�[�g�E�F�C�l�F


rem ���͒l�̊m�F
echo ------------------------------------------------------
echo ��IP�A�h���X�̊m�F��
echo.
echo �@IP�A�h���X��[ %Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Ipadd_4% ]�ɐݒ肵�܂�
echo �@�T�u�l�b�g�A�h���X��[ %Subnet% ]�ɐݒ肵�܂�
echo �@�Q�[�g�E�F�C[ %Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Dfgy%]�ɐݒ肵�܂�
echo.
echo ------------------------------------------------------
echo [y]:�ݒ�l�Őݒ�J�n
echo [e]:�ݒ�𒆎~���ďI��
echo ��L�ȊO:�ݒ�l�C��
echo ------------------------------------------------------
rem ����L�[�̏�����
set Slt=nul
set /p Slt=�m�F���́F
if %Slt% == e goto exitto
if %Slt% == y goto setupto
goto Loop


:setupto
cls
echo �Œ�IP�A�h���X��ݒ肵�܂��B���΂炭���҂����������B
pause
netsh interface ip set add name=%Ntname% source=static addr=%Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Ipadd_4% mask=%Subnet% gateway=%Ipadd_1%.%Ipadd_2%.%Ipadd_3%.%Dfgy% gwmetric=1
echo.
echo.
echo �Œ�IP�A�h���X��ݒ肵�܂����B
rem IP�A�h���X��\��������
echo �ݒ�l���m�F���Ă��������B
ipconfig
pause

cls
echo -------------------------------
echo DNS�ݒ�̕K�v������܂����H�@
echo [n]:DNS�ݒ�
echo [e]:�ݒ芮��
echo -------------------------------
set Slt=nulset /p Slt=�m�F���́F

if %Slt% == e goto exitto
if %Slt% == n goto dnssetuppause

:dnssetup
echo -------------------------------
echo DNS�ɐݒ肷��IP�A�h���X��
echo �l����͂��Ă�������
echo -------------------------------
set /p dns_1=��1�I�N�e�b�g�̒l�F
set /p dns_2=��2�I�N�e�b�g�̒l�F
set /p dns_3=��3�I�N�e�b�g�̒l�F
set /p dns_4=��4�I�N�e�b�g�̒l�F

cls
echo ��IP�A�h���X�̊m�F��
echo.
echo �@IP�A�h���X��[ %dns_1%.%dns_2%.%dns_3%.%dns_4% ]�ɐݒ肵�܂�
echo.
echo ------------------------------------------------------
echo [y]:�ݒ�l�Őݒ�J�n
echo [e]:�ݒ�𒆎~���ďI��
echo ------------------------------------------------------
set Slt=nulset /p Slt=�m�F���́F
if %Slt% == e goto exitto
if %Slt% == y goto dnssetup

:dnssetup
cls
echo �Œ�IP�A�h���X��ݒ肵�܂��B���΂炭���҂����������B
pause
netsh interface ipv4 set dns %Ntname% %dns_1%.%dns_2%.%dns_3%.%dns_4%
echo.
echo.
echo �Œ�IP�A�h���X��ݒ肵�܂����B
ipconfig
pause
echo.

goto display
echo.

:exitto
pause
exit

:2
netsh interface ipv4 set address "�C�[�T�l�b�g" static 192.168.219.69 255.255.255.0 192.168.219.224
netsh interface ipv4 set dns "�C�[�T�l�b�g" static 192.168.102.33 primary
ipconfig
pause
exit

:3netsh interface ipv4 set address name="�C�[�T�l�b�g" source=dhcp
netsh interface ipv4 set dns name="�C�[�T�l�b�g" source=dhcp
ipconfig
pause
exit

:4
ncpa.cpl
pause
exit