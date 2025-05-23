@echo off
echo =========================================================
echo SLICER FOR FRUIT NINJA - BY KEVIN CERDA AND JONATHAN RUAN
echo =========================================================
echo .
echo Checking if Python is installed...
python --version
if errorlevel 1 (
    echo ERROR: Python is not installed.
    echo Please install Python from: https://python.org
    pause
    exit
)
echo .
echo Do you want to install the dependencies? (y/n)
set /p "install= "
if /i "%install%"=="y" (
    echo Installing dependencies...
    echo The following will be installed:
    echo - OpenCV
    echo - pyautogui
    echo - numpy
    echo .
    pip install -r requirements.txt
    echo .
    if errorlevel 1 (
        echo ERROR: Could not install dependencies.
        echo Please install the dependencies manually.
        pause
        exit
    )
    else (
        echo ================================================
        echo   INSTALLATION COMPLETED SUCCESSFULLY!
        echo ================================================
        echo.
        echo USAGE INSTRUCTIONS:
        echo 1. Make sure you have good lighting
        echo 2. Show a green object to the camera
        echo 3. The mouse will follow the largest detected object
        echo 4. Press 'q' to exit
        echo 5. Move the physical mouse to the upper left corner for emergency exit
        echo.

        echo Press any key to finish...
        pause
        echo Thanks for using Slicer for Fruit Ninja!
        exit
    )
)
else if /i "%install%"=="n" (
    echo Thanks for using Slicer for Fruit Ninja!
    exit
)