# 🍌 Fruit Slicer Tracker - Control Fruit Ninja with a Yellow Object  
**Created by Kevin Cerda and Jonathan Ruan**

Control your mouse using your webcam and a yellow-colored object with OpenCV. Perfect for games like *Fruit Ninja* or any application that benefits from hands-free interaction.

---

## ✨ Features

- 🎮 **Live cursor control**: Move your mouse in real-time using a yellow object.
- 🎯 **Smart detection**: Automatically tracks the largest yellow object in the camera view.
- 🖱️ **Auto left-clicking**: Simulates left-clicks while the object is being detected.
- ⚡ **Smooth movement**: Reduces jitter for more accurate tracking.
- 🛡️ **Safety mode**: Instantly stops the script when the cursor is moved to the top-left corner of the screen.

---

## 💻 Requirements

- Python 3.7+
- OpenCV
- PyAutoGUI
- Numpy

> All dependencies are installed automatically using the setup script.

---

## 🚀 Quick Installation (Windows)

```bash
git clone https://github.com/KevinCerdaa/Fruit-Slicer-Tracker
cd Fruit-Slicer-Tracker
install.bat
