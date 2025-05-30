import cv2
import numpy as np
import pyautogui
import time  # Añadimos import de time

# Código hecho por Kevin Cerda y Jonathan Ruan

# Configuración de pyautogui para mayor seguridad
pyautogui.FAILSAFE = True  # Mover mouse a esquina superior izquierda para detener
pyautogui.PAUSE = 0.01     # Pequeña pausa entre comandos

webCam = cv2.VideoCapture(0)

# Obtener dimensiones de la pantalla
screenWidth, screenHeight = pyautogui.size()

# Variables para control del mouse
isLeftClickPressed = False
lastCenterX, lastCenterY = 0, 0

# Tiempo de inicio del programa
startTime = time.time()
clickDelay = 10  # Segundos de espera antes de activar clicks

fristLowerColor = np.array([25, 100, 20])
fristUpperColor = np.array([35, 255, 255])

#secondLowerColor = np.array([170, 100, 20]) #Buscar segundo color
#secondUpperColor = np.array([179, 255, 255]) #Buscar segundo color

while True:
    ret, frame = webCam.read()
    if not ret:
        break
        
    # Obtener dimensiones del frame
    frameHeight, frameWidth = frame.shape[:2]
    
    webCamInHSV = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    mask = cv2.inRange(webCamInHSV, fristLowerColor, fristUpperColor)
    #secondMask = cv2.inRange(webCamInHSV, secondLowerColor, secondUpperColor)
    #mask = fristMask + secondMask

    maskColor = cv2.bitwise_and(frame, frame, mask=mask)
    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
   # cv2.drawContours(frame, contours, -1, (255, 0, 0), 4) #Descomentar para ver contornos

    # Filtrar contornos que cumplan con el área mínima
    validContours = []
    for contour in contours:
        if cv2.contourArea(contour) > 1000:
            validContours.append(contour)
    
    # Si hay contornos válidos, encontrar el más grande
    if validContours:
        largestContour = max(validContours, key=cv2.contourArea)
        
        # Procesar solo el contorno más grande
        centerContour = cv2.moments(largestContour)
        if centerContour["m00"] == 0: 
            centerContour["m00"] = 1
        centerX = int(centerContour["m10"] / centerContour["m00"])
        centerY = int(centerContour["m01"] / centerContour["m00"])
        
        # Mapear coordenadas de la cámara a coordenadas de pantalla
        # Invertir coordenada X para efecto espejo (izquierda cámara = derecha pantalla)
        mouseX = int(((frameWidth - centerX) / frameWidth) * screenWidth)
        mouseY = int((centerY / frameHeight) * screenHeight)
        
        # Suavizado del movimiento (opcional)
        smoothFactor = 0.2
        if lastCenterX != 0 and lastCenterY != 0:
            mouseX = int(lastCenterX + (mouseX - lastCenterX) * smoothFactor)
            mouseY = int(lastCenterY + (mouseY - lastCenterY) * smoothFactor)
        
        # Actualizar posición anterior
        lastCenterX, lastCenterY = mouseX, mouseY
        
        # Control del mouse
        try:
            pyautogui.moveTo(mouseX, mouseY)
            
            # Verificar si ya pasaron los 10 segundos antes de permitir clicks
            if time.time() - startTime >= clickDelay:
                # Mantener click izquierdo presionado si no estaba ya presionado
                if not isLeftClickPressed:
                    pyautogui.mouseDown(button='left')
                    isLeftClickPressed = True
            
        except pyautogui.FailSafeException:
            print("Movimiento del mouse detenido por seguridad")
            break
        
        cv2.circle(frame, (centerX, centerY), 5, (238, 64, 255), -1)
        font = cv2.FONT_HERSHEY_SIMPLEX
        
        # Mostrar mensaje de espera o "Sword is ready!" según el tiempo transcurrido
        if time.time() - startTime < clickDelay:
            timeLeft = int(clickDelay - (time.time() - startTime))
            cv2.putText(frame, f"Espera {timeLeft} segundos...", (centerX, centerY), font, 1, (247, 80, 47), 2)
        else:
            cv2.putText(frame, "Sword is ready!", (centerX, centerY), font, 1, (247, 80, 47), 2)
        
        # Mostrar coordenadas del mouse en la imagen
        cv2.putText(frame, f"Mouse: ({mouseX}, {mouseY})", (10, 30), font, 0.7, (0, 255, 0), 2)
        
        softContour = cv2.convexHull(largestContour)
        drawContour = cv2.drawContours(frame, [softContour], 0, (238, 64, 255), 4)
    
    else:
        # Si no hay contornos válidos, soltar el click izquierdo
        if isLeftClickPressed:
            pyautogui.mouseUp(button='left')
            isLeftClickPressed = False

    cv2.putText(frame, "Presiona 'q' para salir", (10, frameHeight - 20), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 1)
    
    # Redimensionar el frame para la visualización
    displayWidth = 300  # Volvemos a 300 para un tamaño más manejable
    displayHeight = int(frame.shape[0] * displayWidth / frame.shape[1])
    displayFrame = cv2.resize(frame, (displayWidth, displayHeight))
    
    # Asegurar que la ventana se mantenga en el monitor principal
    safeX = max(0, min(screenWidth - displayWidth - 10, screenWidth - displayWidth - 30))
    safeY = 0
    
    # Crear y posicionar la ventana en la esquina superior derecha
    cv2.namedWindow("Normal WebCam", cv2.WINDOW_GUI_EXPANDED | cv2.WINDOW_KEEPRATIO | cv2.WINDOW_AUTOSIZE)
    cv2.setWindowProperty("Normal WebCam", cv2.WND_PROP_TOPMOST, 1)
    cv2.moveWindow("Normal WebCam", safeX, safeY)
    cv2.imshow("Normal WebCam", displayFrame) # Camara normal
    # cv2.imshow("Mask Color", maskColor) Descomentar para ver máscara
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Asegurarse de soltar el click izquierdo antes de cerrar
if isLeftClickPressed:
    pyautogui.mouseUp(button='left')

webCam.release()
cv2.destroyAllWindows()
