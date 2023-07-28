import cv2 
import mediapipe as mp

mp_pose = mp.solutions.mediapipe.python.solutions.holistic

pose = mp_pose.Holistic(
    static_image_mode=True,
    model_complexity=2,
    enable_segmentation=True,
    min_detection_confidence=0.5)


file = 'MicrosoftTeams-image.png'
image = cv2.imread(file)
# Convert the BGR image to RGB before processing.
results = pose.process(cv2.cvtColor(image, cv2.COLOR_BGR2RGB))

print('Initialization finished')
