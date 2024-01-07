import multiprocessing
import threading
import traceback
from flask import Flask, render_template, Response
import socket
import cv2
import pickle
import struct
import time
import numpy as np
import subprocess
import ssocr
import pytesseract
from PIL import Image
from collections import deque, Counter
from flask import request, jsonify
import os
from roboflow import Roboflow
from keras.models import load_model
from keras.preprocessing.image import load_img, img_to_array
from keras.models import Sequential
from keras.layers import Input
from keras.layers import Conv2D, MaxPooling2D, Flatten, Dense
import numpy as np
from keras.preprocessing import image
import matplotlib.pyplot as plt
import time
from flask_cors import CORS, cross_origin
from flask import Flask, Response, render_template, jsonify




model = load_model('/Users/.../my_model_6.h5')

# Létrehozunk egy könyvtárat a képeknek
IMAGE_SAVE_DIR = "saved_2_6"
if not os.path.exists(IMAGE_SAVE_DIR):
    os.makedirs(IMAGE_SAVE_DIR)

app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


host_ip = 'host_ip'
port = 10050

# Globális változóként tároljuk a ROI-t, hogy könnyen elérhető legyen.
current_roi = {
    "x": 0,
    "y": 0,
    "width": 0,
    "height": 0
}

# Inicializáld a rois változót mint egy üres listát
rois = []

last_valid_digit = 0
previous_common_number = None

# Eddigi ismert számjegyek tárolása
known_digits = set()


@app.route('/set_roi', methods=['POST'])
def set_roi():
    global current_roi
    global rois  # Hozzáférünk a globális rois változóhoz
    data = request.json
    new_roi = {
        "x": data.get('x', 0),
        "y": data.get('y', 0),
        "width": data.get('width', 0),
        "height": data.get('height', 0)
    }
    rois.append((new_roi['x'], new_roi['y'], new_roi['width'], new_roi['height']))  # Hozzáadjuk az új ROI-t a listához
    return jsonify({"message": "ROI set and added successfully!"})


class RollingWindow:
    def __init__(self, size):
        self.data = deque(maxlen=size)

    def add(self, item):
        self.data.append(item)

    def most_common(self):
        counter = Counter(self.data)
        if not counter:  # Ha az összesítő üres
            return "0"
        return counter.most_common(1)[0][0]  # Visszaadja a leggyakoribb elemet

    def display(self):
        return ', '.join(map(str, list(self.data)))


# Létrehoz egy RollingWindow példányt 15 mérettel
window = RollingWindow(15)

known_digits_per_index = {}  # a szótár inicializálása

def save_unseen_digit(img_array, digit, index):
    # Ha az index nem szerepel még a szótárban, hozz létre egy üres halmazt neki
    if index not in known_digits_per_index:
        known_digits_per_index[index] = set()
    
    # Ellenőrizd, hogy az adott számjegy ismert-e már az adott indexnél
    if digit not in known_digits_per_index[index]:
        known_digits_per_index[index].add(digit)
        
        # Mentsd el a képet az előre definiált könyvtárban
        save_path = os.path.join(IMAGE_SAVE_DIR, f'unseen_digit_{digit}_index_{index}.png')
        #cv2.imwrite(save_path, img_array.squeeze() * 255)  


def is_mostly_black(img_array, threshold=2.5):
    mean_value = np.mean(img_array)
    #print(f"Average pixel value for {img_array.shape}: {mean_value}")  # Hozzáadtam egy kinyomtatást a könnyebb hibakeresés érdekében
    return mean_value < threshold


def prepare_image(image_path):
    # Load the image with a target size of 64x64
    img = load_img(image_path, target_size=(64, 64))
    # Convert the image to an array
    img_array = img_to_array(img)
    # Normalize the image
    img_array = img_array / 255.0
    # Expand the dimensions of the image for the model
    img_array = np.expand_dims(img_array, axis=0)
    
    return img_array


def recognize_digit_with_Cnn(img_array, model):
    # Make sure the image is resized to 64x64
    img_resized = cv2.resize(img_array, (64, 64))
    
    # Convert grayscale to RGB
    img_rgb = cv2.cvtColor(img_resized, cv2.COLOR_GRAY2RGB)

    # Convert to proper shape and datatype
    img_array_expanded = np.expand_dims(img_rgb, axis=0)
    
    # If the image is not normalized to 0-1 range, do it here
    img_preprocessed = img_array_expanded / 255.0

    # Predict using the model
    predictions = model.predict(img_preprocessed, verbose = 0)

    # Extract the predicted class
    predicted_class = np.argmax(predictions[0])
    return predicted_class




# Zaj szűrése
def is_valid_number(s):
    # Eltávolítja a pontokat és vesszőket
    s = s.replace(".", "").replace(",", "")
    return s.isdigit()

def validate_value(value_str, max_value):
    if not value_str:  # Ha az érték üres karakterlánc
        return '0'
    value = int(value_str)
    return str(value) if value <= max_value else str(max_value)




# Pályák inicializálása
palyak = [[0, 1, 2, 3],
 [1, 0, 3, 2],
 [3, 2, 1, 0],
 [2, 3, 0, 1]]

# Változók definiálása
GURITASOK_MAX = 30
round_counter = 0
sor_counter= 0


end_results = []
temp_results = []


billeno = False
billeno2 = False

egyes_palya_30 = False
kettes_palya_30 = False
harmas_palya_30 = False
negyes_palya_30 = False


players = [0,0,0,0]


def recognize_digits(image):

    global players
    global temp_results
    global end_results
    global previous_common_number
    global current_roi
    global round_counter
    global billeno
    global billeno2
    global egyes_palya_30
    global kettes_palya_30
    global harmas_palya_30
    global negyes_palya_30

    egyes_palya_30_eredmeny = ""
    kettes_palya_30_eredmeny = ""
    harmas_palya_30_eredmeny = ""
    negyes_palya_30_eredmeny = ""

    # A jelenlegi ROI koordinátáit használjuk
    x, y, w, h = current_roi['x'], current_roi['y'], current_roi['width'], current_roi['height']


    # Több ROI definiálása
    rois = [
        #KARAKTEREK
        # I-es pálya
        (230, 138, 12, 14),   # I-es pálya guritasszam (1.KARAKTER)
        (240, 136, 12, 14),   # I-es pálya guritasszam (2.KARAKTER)
        (305, 131, 12, 14),   # I-es pálya eredmény (1.KARAKTER)
        (316, 130, 10, 14),   # I-es pálya eredmény (2.KARAKTER)
        (325, 131, 12, 14),   # I-es pálya eredmény (3.KARAKTER)
        (302, 37, 12, 14),   # I-es pálya össz eredmény (1.KARAKTER)
        (314, 36, 10, 14),   # I-es pálya össz eredmény (2.KARAKTER)
        (323, 35, 12, 14),   # I-es pálya össz eredmény (3.KARAKTER)

        # II-es pálya
        (451, 124, 14, 14),   # II-es pálya guritasszam (1.KARAKTER)
        (464, 124, 14, 14),   # II-es pálya guritasszam (2.KARAKTER)
        (535, 124, 12, 14),   # II-es pálya eredmény (1.KARAKTER)
        (546, 124, 12, 14),   # II-es pálya eredmény (2.KARAKTER)
        (557, 124, 12, 14),   # II-es pálya eredmény (3.KARAKTER)
        (535, 25, 12, 14),   # II-es pálya össz eredmény (1.KARAKTER)
        (547, 25, 11, 14),   # II-es pálya össz eredmény (2.KARAKTER)
        (557, 25, 12, 14),   # II-es pálya össz eredmény (3.KARAKTER)

        # III-es pálya
        (675, 124, 12, 15),   # III-as pálya guritasszam (1.KARAKTER)
        (687, 124, 12, 15),   # III-as pálya guritasszam (2.KARAKTER)
        (759, 128, 11, 15),   # III-as pálya eredmény (1.KARAKTER)
        (769, 128, 11, 15),   # III-as pálya eredmény (2.KARAKTER)
        (779, 129, 12, 15),   # III-as pálya eredmény (3.KARAKTER)
        (762, 32, 11, 15),   # III-as pálya össz eredmény (1.KARAKTER)
        (773, 32, 10, 15),   # III-as pálya össz eredmény (2.KARAKTER)
        (783, 32, 12, 15),   # III-as pálya össz eredmény (3.KARAKTER)

        # IV-es pálya
        (896, 138, 14, 16),   # IV-as pálya guritasszam (1.KARAKTER)
        (906, 138, 12, 16),   # IV-as pálya guritasszam (2.KARAKTER)
        (918, 138, 12, 16),   # IV-as pálya guritasszam (3.KARAKTER)
        (983, 145, 11, 16),   # IV-es pálya eredmény (1.KARAKTER)
        (993, 145, 10, 16),   # IV-es pálya eredmény (2.KARAKTER)
        (1002, 145, 12, 16),   # IV-es pálya eredmény (3.KARAKTER)
        (987, 53, 10, 16),    # IV-es pálya össz eredmény (1.KARAKTER)
        (997, 53, 10, 16),    # IV-es pálya össz eredmény (2.KARAKTER)
        (1007, 54, 10, 16),    # IV-es pálya össz eredmény (3.KARAKTER)
    ]

    # A csoportok definíciója
    csoportok = [
        (0, 2, 'egyes_palya_guritasszam'),
        (2, 5, 'egyes_palya_eredmeny'),
        (5, 8, 'egyes_palya_osszeredmeny'),
        (8, 10, 'kettes_palya_guritasszam'),
        (10, 13, 'kettes_palya_eredmeny'),
        (13, 16, 'kettes_palya_osszeredmeny'),
        (16, 18, 'harmas_palya_guritasszam'),
        (18, 21, 'harmas_palya_eredmeny'),
        (21, 24, 'harmas_palya_osszeredmeny'),
        (24, 27, 'negyes_palya_guritasszam'),
        (27, 30, 'negyes_palya_eredmeny'),
        (30, 33, 'negyes_palya_osszeredmeny')
    ]

    eredmenyek = {}

    for start, end, group_name in csoportok:
            result = ""
            for index in range(start, end):
                x, y, w, h = rois[index]
                roi = image[y:y+h, x:x+w]
                if roi.dtype != 'uint8':
                    roi = cv2.convertScaleAbs(roi)
                roi_gray = cv2.cvtColor(roi, cv2.COLOR_BGR2GRAY)
                _, binary_image = cv2.threshold(roi_gray, 150, 255, cv2.THRESH_BINARY)

                img_array = binary_image.copy()
                if not is_mostly_black(img_array):
                    recognized_digit_cnn = recognize_digit_with_Cnn(img_array, model)
                    if recognized_digit_cnn is not None:
                        result += str(recognized_digit_cnn)

            if result:
                eredmenyek[group_name] = int(result)

    # Validálás és eredmények kiíratása
    validacio_map = {
        'egyes_palya_guritasszam': 31,
        'egyes_palya_eredmeny': 210,
        'egyes_palya_osszeredmeny': 680,
        'kettes_palya_guritasszam': 31,
        'kettes_palya_eredmeny': 210,
        'kettes_palya_osszeredmeny': 680,
        'harmas_palya_guritasszam': 31,
        'harmas_palya_eredmeny': 210,
        'harmas_palya_osszeredmeny': 680,
        'negyes_palya_guritasszam': 31,
        'negyes_palya_eredmeny': 210,
        'negyes_palya_osszeredmeny': 680
    }


    
    
    
    for key, max_val in validacio_map.items():
            eredmenyek[key] = str(validate_value(eredmenyek.get(key, ''), max_val))
        
    # Logikai változók létrehozása


    try:
        temp_results = []
        
        # Extract guritasszam and check if they are "30"
        palya_keys = ['egyes_palya', 'kettes_palya', 'harmas_palya', 'negyes_palya']
        
        guritasszam_strs = {key: str(eredmenyek[f'{key}_guritasszam']) for key in palya_keys}
        is_30 = {key: guritasszam_strs[key] == "30" for key in palya_keys}
        eredmeny_if_30 = {key: str(eredmenyek[f'{key}_eredmeny']) if is_30[key] else None for key in palya_keys}

        for idx, key in enumerate(palya_keys):
            print(f"{idx + 1} palya guritasszam:", guritasszam_strs[key])
            print(f"{idx + 1} palya true:", is_30[key])
            if is_30[key]:
                print(f"{idx + 1} palya eredm:", eredmeny_if_30[key])
        print("Billeno:", billeno)
        
        all_30 = all(is_30.values())
        
        if all_30:
            if not billeno:
                billeno = True
                for index, elem in enumerate(palyak[round_counter]):
                    players[elem] = eredmeny_if_30[palya_keys[index]]
                round_counter += 1
                end_results.append(players.copy())
                
                if round_counter == 4:
                    round_counter = 0
        else:
            print("Else")
            for index, elem in enumerate(palyak[round_counter]):
                players[elem] = eredmenyek[f'{palya_keys[index]}_eredmeny']
            temp_results.append(players.copy())
            billeno = False
        
        print(temp_results)
        print(end_results)

    except KeyError:
        print("Értelmezhetetlen adattag.")


def other_thread():
    global shared_list
    
    last_called = 0  # az utolsó hívás időpontja

    while True:
        try:
            client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            client_socket.connect((host_ip, port))
            data = b""
            payload_size = struct.calcsize("Q")
            while True:
                while len(data) < payload_size:
                    packet = client_socket.recv(4 * 1024)
                    if not packet:
                        break
                    data += packet

                packed_msg_size = data[:payload_size]
                data = data[payload_size:]
                msg_size = struct.unpack("Q", packed_msg_size)[0]

                while len(data) < msg_size:
                    data += client_socket.recv(4 * 1024)
                frame_data = data[:msg_size]
                data = data[msg_size:]

                frame = pickle.loads(frame_data)
                if frame is not None:
                    current_time = time.time()  # aktuális idő
                    if current_time - last_called >= 2:  # ha eltelt 5 másodperc az utolsó hívás óta
                        recognize_digits(frame)
                        last_called = current_time
                shared_list[:] = [frame]
                time.sleep(0.01)
        except:
            print("Connection failed")
            traceback.print_exc()
            client_socket.close()
            time.sleep(5)


def gen_frames():
    global shared_list
    while True:
        if shared_list[0] is not None:
            obj = shared_list[0]
            ret, buffer = cv2.imencode('.jpg', obj)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'
                   b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')
        time.sleep(0.01)


@app.route('/results', methods=['GET'])
@cross_origin()
def get_results():
    global temp_results, end_results
    return jsonify({
        "temp_results": temp_results.copy(),
        "end_results": end_results.copy()
    })



@app.route('/video_feed')
def video_feed():
    return Response(gen_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

@app.route('/')
def index():
    return render_template('index.html')

def recognize_with_ssocr(roi_gray):
    # Mentsd el a képet memóriában PNG formátumban
    _, img_encoded = cv2.imencode('.png', roi_gray)
    image_data = img_encoded.tobytes()

    # Futtasd az ssocr-t a memóriában tárolt képen
    result = subprocess.run(['ssocr', '-d', '-1', '-'], input=image_data, stdout=subprocess.PIPE)
    return result.stdout.decode('utf-8').strip()



if __name__ == '__main__':
    manager = multiprocessing.Manager()
    shared_list = manager.list([None])

    x = threading.Thread(target=other_thread, args=())
    x.start()

    # Flask szerver indítása több szálon
    x2 = threading.Thread(target=lambda: app.run(host='0.0.0.0', port=5002, threaded=True, debug=False, use_reloader=False))
    x2.start()

    x.join()
    x2.join()
