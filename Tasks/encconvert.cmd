@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM Проверка на наличие параметров
if "%~1"=="" (
    echo Usage: encconvert.cmd directory
    exit /b 1
)

REM Проверим, существует ли директория
if not exist "%~1" (
    echo Directory not found: %~1
    exit /b 1
)

REM Проходим по всем .txt файлам в указанной директории и ее поддиректориях
FOR /R "%~1" %%f IN (*.txt) DO (
    echo Processing: %%f
    SET TEMPFILE=%%~dpnf.tmp

    REM Конвертируем файл из CP866 в UTF-8
    iconv -f cp866 -t utf-8 "%%f" > "!TEMPFILE!"
    
    REM Проверка на ошибки при конвертации
    if errorlevel 1 (
        echo Error converting file: %%f
        del "!TEMPFILE!" > nul 2>&1
        exit /b 1
    )

    REM Заменяем исходный файл новым
    move /Y "!TEMPFILE!" "%%f" > nul
)

echo All files processed successfully.
exit /b 0
