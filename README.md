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
- Webcam 📸

> All dependencies are installed automatically using the setup script.

---

## 🚀 Quick Installation

### Windows
```bash
git clone https://github.com/KevinCerdaa/FruitNinja_Tracker
cd FruitNinja_Tracker
install.bat
```

### Linux/Mac
```bash
git clone https://github.com/KevinCerdaa/FruitNinja_Tracker
cd FruitNinja_Tracker
chmod +x install.sh
./install.sh
```

---

## 🎮 Usage

1. 🔆 Ensure good lighting in your environment
2. 🟡 Hold a yellow object in front of your camera
3. 🎯 Move the object to control the mouse cursor
4. ⌨️ Press 'q' to exit normally
5. 🛑 Move physical mouse to top-left corner for emergency stop

---

## 🔧 Troubleshooting

### Common Issues

1. **Camera not detected**
   - Ensure your webcam is properly connected
   - Check if other applications are using the camera
   - Try running the script with administrator/sudo privileges

2. **Yellow object not tracking well**
   - Improve lighting conditions
   - Use a more vibrant yellow object
   - Avoid yellow objects in the background

3. **Dependencies installation fails**
   - Try installing dependencies manually:
     ```bash
     pip install opencv-python numpy pyautogui
     ```
   - Make sure you have Python and pip properly installed

---

## 🤝 Contributing

Feel free to:
- 🐛 Report bugs
- 💡 Suggest new features
- 🔧 Submit pull requests

---

## 📜 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 🙏 Acknowledgments

- Thanks to the OpenCV community
- Inspired by Fruit Ninja game
- Special thanks to all contributors
