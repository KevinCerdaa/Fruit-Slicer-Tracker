@echo off
echo =========================================================
echo SLICER FOR FRUIT NINJA - BY KEVIN CERDA AND JONATHAN RUAN
echo =========================================================
echo.

echo Checking if Python is installed...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed.
    echo Please install Python from: https://python.org
    pause
    exit /b
)

echo.
echo Do you want to install the dependencies? (y/n)
set /p install= 

if /i "%install%"=="y" (
    echo.
    echo Installing dependencies...
    echo The following will be installed:
    echo - OpenCV
    echo - pyautogui
    echo - numpy
    echo.
    pip install -r requirements.txt
    if errorlevel 1 (
        echo.
        echo ERROR: Could not install dependencies.
        echo Please install them manually using:
        echo pip install opencv-python pyautogui numpy
        pause
        exit /b
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
    pause
    echo Thanks for using Slicer for Fruit Ninja!
    exit /b
)

if /i "%install%"=="n" (
    echo.
    echo Skipping dependency installation.
    echo Thanks for using Slicer for Fruit Ninja!
    exit /b
)

echo Invalid option. Please enter 'y' or 'n'.
pause
exit /b
