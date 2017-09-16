@echo off
echo.
Setlocal EnableDelayedExpansion
echo.Enter the path of the file and its extension
echo.
echo.Eg: Enter path: D:\forms\abc\*.fmb 
echo.
echo.Eg: Enter login/password: scott/tiger@ibm
echo.
pause
c:\Windows\System32\timeout.exe /t 3
echo.
set /p x="Enter path: "
echo.
set /p y="Enter login/password: "
echo.


for /f %%f in ('dir /s /b %x%') do (
rem this was create full file path without extension %%~df%%~pf%%~nf

rem start migration
 PATH=C:\Oracle\Middleware\Oracle_Home\bin;"%PATH%"
 set CLASSPATH=C:\Oracle\Middleware\Oracle_Home\jlib\frmupgrade.jar;C:\Oracle\Middleware\Oracle_Home\jlib\frmjdapi.jar;C:\Oracle\Middleware\Oracle_Home\oracle_common\modules\oracle.bali.jewt\jewt4.jar;C:\Oracle\Middleware\Oracle_Home\oracle_common\modules\oracle.bali.share\share.jar;%CLASSPATH%
 set FORMS_PATH=%FORMS_PATH%;C:\Oracle\Middleware\Oracle_Home\forms
 if not defined TNS_ADMIN set TNS_ADMIN=C:\Oracle\Middleware\Oracle_Home\Form_1

 set formDetails=module="%%f" userid=%y% log=D:\Result.log
 
 C:\Oracle\Middleware\Oracle_Home\oracle_common\jdk\bin\java -Dsun.java2d.noddraw=true -DCONVERTER_DEFAULTS=C:\Oracle\Middleware\Oracle_Home\Form_1\converter.properties -DSEARCH_REPLACE_FILE=C:\Oracle\Middleware\Oracle_Home\Form_1\search_replace.properties oracle.forms.util.wizard.Converter !formDetails!
rem migration finish here

rem create fmx
 set path=C:\Oracle\Middleware\Oracle_Home\bin\

rem batch=Yes skips fmb with errors.
 start frmcmp module="%%~df%%~pf%%~nf.fmb" userid=%y% module_type=form batch=No compile_all=special window_state=minimize
 rem fmx creating finish here

  c:\Windows\System32\timeout.exe /t 5
)
endlocal
