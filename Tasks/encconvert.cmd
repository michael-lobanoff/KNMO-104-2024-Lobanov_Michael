@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM �������� �� ������� ����������
if "%~1"=="" (
    echo Usage: encconvert.cmd directory
    exit /b 1
)

REM ��������, ���������� �� ����������
if not exist "%~1" (
    echo Directory not found: %~1
    exit /b 1
)

REM �������� �� ���� .txt ������ � ��������� ���������� � �� ��������������
FOR /R "%~1" %%f IN (*.txt) DO (
    echo Processing: %%f
    SET TEMPFILE=%%~dpnf.tmp

    REM ������������ ���� �� CP866 � UTF-8
    iconv -f cp866 -t utf-8 "%%f" > "!TEMPFILE!"
    
    REM �������� �� ������ ��� �����������
    if errorlevel 1 (
        echo Error converting file: %%f
        del "!TEMPFILE!" > nul 2>&1
        exit /b 1
    )

    REM �������� �������� ���� �����
    move /Y "!TEMPFILE!" "%%f" > nul
)

echo All files processed successfully.
exit /b 0
