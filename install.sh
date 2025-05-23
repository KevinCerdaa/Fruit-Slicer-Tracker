#!/bin/bash

echo "========================================================="
echo "SLICER FOR FRUIT NINJA - BY KEVIN CERDA AND JONATHAN RUAN"
echo "========================================================="
echo ""
echo "Checking if Python is installed..."

if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "ERROR: Python is not installed."
    echo "Please install Python from: https://python.org"
    read -p "Press Enter to exit..."
    exit 1
fi

# Check which python command is available
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    PIP_CMD="pip3"
else
    PYTHON_CMD="python"
    PIP_CMD="pip"
fi

$PYTHON_CMD --version
echo ""
echo "Do you want to install the dependencies? (y/n)"
read -p "Enter your choice: " install

if [[ "$install" == "y" || "$install" == "Y" ]]; then
    echo "Installing dependencies..."
    echo "The following will be installed:"
    echo "- OpenCV"
    echo "- pyautogui"
    echo "- numpy"
    echo ""
    
    if $PIP_CMD install -r requirements.txt; then
        echo "================================================"
        echo "   INSTALLATION COMPLETED SUCCESSFULLY!"
        echo "================================================"
        echo ""
        echo "USAGE INSTRUCTIONS:"
        echo "1. Make sure you have good lighting"
        echo "2. Show a green object to the camera"
        echo "3. The mouse will follow the largest detected object"
        echo "4. Press 'q' to exit"
        echo "5. Move the physical mouse to the upper left corner for emergency exit"
        echo ""
        
        read -p "Press Enter to finish..."
        echo "Thanks for using Slicer for Fruit Ninja!"
    else
        echo "ERROR: Could not install dependencies."
        echo "Please install the dependencies manually."
        read -p "Press Enter to exit..."
        exit 1
    fi
elif [[ "$install" == "n" || "$install" == "N" ]]; then
    echo "Thanks for using Slicer for Fruit Ninja!"
else
    echo "Invalid input. Please run the script again and enter 'y' or 'n'."
fi