#importing libraries
import socket
import cv2
import pickle
import struct
import imutils
import time

# Create a socket object
server_socket = socket.socket(socket.AF_INET,socket.SOCK_STREAM)

# Get the hostname and IP address of the host
host_name  = socket.gethostname()

# A helyi IP-cím megszerzéséhez próbáljuk megszerezni a kapcsolatot egy nem létező címre.
# Ebben az esetben a cél csak annyi, hogy megtudjuk a 'kifelé vezető' interfész IP-címét.
s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
try:
    # Ez nem fogja valóban csatlakozni, de megadja a helyes interfész IP-címét.
    s.connect(('10.255.255.255', 1))
    local_ip = s.getsockname()[0]
except Exception:
    local_ip = '127.0.0.1'
finally:
    s.close()

print('Local IP:', local_ip)
#host_ip = '164.8.233.100'
#host_ip = '176.63.17.240'
print('HOST IP:', local_ip)

# Set the port number
port = 10050
socket_address = (local_ip, port)

print('Socket created')

# Bind the socket to the specified IP address and port
server_socket.bind(socket_address)
print('Socket bind complete')

# Listen for incoming connections
server_socket.listen(5)
print('Socket now listening')

while True:
    # Accept a client connection
    client_socket, addr = server_socket.accept()
    print('Connection from:', addr)
    
    if client_socket:
        # Create a VideoCapture object to capture video from the default camera (index 0)
        #vid = cv2.VideoCapture(0)
        #vid = cv2.VideoCapture('/Users/etlinger/Downloads/probavidi2.mp4')
        #vid = cv2.VideoCapture('/Users/etlinger/Downloads/probavidi6.mp4')
        vid = cv2.VideoCapture('/Users/etlinger/Downloads/szuperproba3.mp4')

        while vid.isOpened():
            start = time.time()
            
            # Read a frame from the video capture
            img, frame = vid.read()
            
            # Serialize the frame using pickle
            a = pickle.dumps(frame)
            
            # Pack the serialized frame and its length into a struct
            message = struct.pack("Q", len(a)) + a
            
            # Send the packed message to the client socket
            client_socket.sendall(message)
            
            end = time.time()
            # Print the time taken to send the frame (optional)
            # print(end - start)
            
            # Check for the Enter key press to close the connection
            key = cv2.waitKey(10)
            if key == 13:
                client_socket.close()