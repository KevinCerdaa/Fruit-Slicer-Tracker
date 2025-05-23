@echo off
echo =========================================================
echo SLICER FOR FRUIT NINJA - BY KEVIN CERDA AND JONATHAN RUAN
echo =========================================================
echo.

REM === Verificar que Python esté instalado ===
echo Checking if Python is installed...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed.
    echo Please install Python from: https://python.org
    pause
    exit /b 1
)

REM === Mostrar versión de Python instalada ===
python --version
echo.

REM === Preguntar si se desea instalar dependencias ===
echo Do you want to install the dependencies? (y/n)
set /p install=

if /i "%install%"=="y" (
    echo.
    echo Installing dependencies...
    echo The following will be installed:
    echo - opencv-python
    echo - pyautogui
    echo - numpy
    echo.

    REM === Verificar si el entorno virtual existe y eliminarlo si hay problemas ===
    if exist "env" (
        echo Previous virtual environment found.
        echo Removing old environment...
        rmdir /s /q env
        if errorlevel 1 (
            echo ERROR: Could not remove old virtual environment.
            echo Please delete the 'env' folder manually and try again.
            pause
            exit /b 1
        )
    )

    REM === Crear nuevo entorno virtual ===
    echo Creating new virtual environment...
    python -m venv env
    if errorlevel 1 (
        echo ERROR: Could not create virtual environment.
        echo Please make sure you have venv installed:
        echo python -m pip install --user virtualenv
        pause
        exit /b 1
    )

    REM === Activar entorno virtual ===
    echo Activating virtual environment...
    call env\Scripts\activate.bat
    if errorlevel 1 (
        echo ERROR: Could not activate virtual environment.
        pause
        exit /b 1
    )

    REM === Actualizar pip y setuptools ===
    echo Updating pip and setuptools...
    python -m pip install --upgrade pip setuptools
    if errorlevel 1 (
        echo ERROR: Could not update pip and setuptools.
        pause
        exit /b 1
    )

    REM === Instalar requerimientos ===
    echo Installing requirements...
    pip install -r requirements.txt
    if errorlevel 1 (
        echo.
        echo ERROR: Could not install dependencies.
        echo Trying to install packages one by one...
        
        pip install opencv-python
        pip install numpy
        pip install pyautogui
        
        if errorlevel 1 (
            echo ERROR: Installation failed.
            echo Please try installing manually using:
            echo pip install opencv-python pyautogui numpy
            pause
            exit /b 1
        )
    )

    echo.
    echo ================================================
    echo   INSTALLATION COMPLETED SUCCESSFULLY!
    echo ================================================
    echo.
    echo USAGE INSTRUCTIONS:
    echo 1. Make sure you have good lighting
    echo 2. Show a yellow object to the camera
    echo 3. The mouse will follow the largest detected object
    echo 4. Press 'q' to exit
    echo 5. Move the physical mouse to the upper-left corner to exit immediately
    echo.
    echo To run the program, use: python slicer.py
    echo.
    pause
    echo Thanks for using Slicer for Fruit Ninja!
    exit /b 0
)

if /i "%install%"=="n" (
    echo.
    echo Skipping dependency installation.
    echo Thanks for using Slicer for Fruit Ninja!
    exit /b 0
)

echo Invalid option. Please enter 'y' or 'n'.
pause
exit /b 1
