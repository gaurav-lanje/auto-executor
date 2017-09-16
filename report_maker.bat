@echo off
echo.
echo.Eg: Enter login/password: scott/tiger@ibm
set /p y="Enter login/password: "
echo.
echo.Eg: Enter path: c:\reports\*.rdf
set /p x="Enter path: "


for /f %%f in ('dir /s /b %x%\*.rdf') do (
rem creates REP file
H:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain\reports\bin\rwconverter userid=%y% stype=RDFFILE DTYPE=REPFILE batch=yes OVERWRITE=YES "source=%%f"
c:\Windows\System32\timeout.exe /t 1
rem creates JSP file
H:\Oracle\Middleware\Oracle_Home\user_projects\domains\base_domain\reports\bin\rwconverter userid=%y% stype=RDFFILE DTYPE=JSPFILE batch=yes OVERWRITE=YES "source=%%f"
c:\Windows\System32\timeout.exe /t 1
)
