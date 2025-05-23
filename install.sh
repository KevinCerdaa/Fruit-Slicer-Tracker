#!/bin/bash

echo "========================================================="
echo "SLICER FOR FRUIT NINJA - BY KEVIN CERDA AND JONATHAN RUAN"
echo "========================================================="
echo ""

# Verificar que Python esté instalado
echo "Checking if Python is installed..."

if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
    echo "ERROR: Python is not installed."
    echo "Please install Python from: https://python.org"
    read -p "Press Enter to exit..."
    exit 1
fi

# Determinar qué comando de Python usar
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
    PIP_CMD="pip3"
else
    PYTHON_CMD="python"
    PIP_CMD="pip"
fi

# Mostrar versión de Python instalada
$PYTHON_CMD --version
echo ""

# Preguntar si se desea instalar dependencias
echo "Do you want to install the dependencies? (y/n)"
read -p "Enter your choice: " install

if [[ "$install" == "y" || "$install" == "Y" ]]; then
    echo ""
    echo "Installing dependencies..."
    echo "The following will be installed:"
    echo "- opencv-python"
    echo "- pyautogui"
    echo "- numpy"
    echo ""

    # Verificar si el entorno virtual existe y eliminarlo si hay problemas
    if [ -d "env" ]; then
        echo "Previous virtual environment found."
        echo "Removing old environment..."
        rm -rf env
        if [ $? -ne 0 ]; then
            echo "ERROR: Could not remove old virtual environment."
            echo "Please delete the 'env' folder manually and try again."
            read -p "Press Enter to exit..."
            exit 1
        fi
    fi

    # Crear nuevo entorno virtual
    echo "Creating new virtual environment..."
    $PYTHON_CMD -m venv env
    if [ $? -ne 0 ]; then
        echo "ERROR: Could not create virtual environment."
        echo "Please make sure you have venv installed:"
        echo "$PYTHON_CMD -m pip install --user virtualenv"
        read -p "Press Enter to exit..."
        exit 1
    fi

    # Activar entorno virtual
    echo "Activating virtual environment..."
    source env/bin/activate
    if [ $? -ne 0 ]; then
        echo "ERROR: Could not activate virtual environment."
        read -p "Press Enter to exit..."
        exit 1
    fi

    # Actualizar pip y setuptools
    echo "Updating pip and setuptools..."
    $PYTHON_CMD -m pip install --upgrade pip setuptools
    if [ $? -ne 0 ]; then
        echo "ERROR: Could not update pip and setuptools."
        read -p "Press Enter to exit..."
        exit 1
    fi

    # Instalar requerimientos
    echo "Installing requirements..."
    pip install -r requirements.txt
    if [ $? -ne 0 ]; then
        echo ""
        echo "ERROR: Could not install dependencies."
        echo "Trying to install packages one by one..."
        
        pip install opencv-python && \
        pip install numpy && \
        pip install pyautogui
        
        if [ $? -ne 0 ]; then
            echo "ERROR: Installation failed."
            echo "Please try installing manually using:"
            echo "pip install opencv-python pyautogui numpy"
            read -p "Press Enter to exit..."
            exit 1
        fi
    fi

    echo ""
    echo "================================================"
    echo "   INSTALLATION COMPLETED SUCCESSFULLY!"
    echo "================================================"
    echo ""
    echo "USAGE INSTRUCTIONS:"
    echo "1. Make sure you have good lighting"
    echo "2. Show a yellow object to the camera"
    echo "3. The mouse will follow the largest detected object"
    echo "4. Press 'q' to exit"
    echo "5. Move the physical mouse to the upper-left corner to exit immediately"
    echo ""
    echo "To run the program, use: python slicer.py"
    echo ""
    read -p "Press Enter to continue..."
    echo "Thanks for using Slicer for Fruit Ninja!"
    exit 0

elif [[ "$install" == "n" || "$install" == "N" ]]; then
    echo ""
    echo "Skipping dependency installation."
    echo "Thanks for using Slicer for Fruit Ninja!"
    exit 0
else
    echo "Invalid option. Please enter 'y' or 'n'."
    read -p "Press Enter to exit..."
    exit 1
fi