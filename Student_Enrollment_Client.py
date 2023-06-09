#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import socket


# In[ ]:


host = socket.gethostname()
port = 5000

client_socket = socket.socket()
client_socket.connect((host, port))

query = input("Enter query or enter 'done': ")
print("")
while query.lower().strip() != 'done':
    client_socket.send(query.encode())
    data = client_socket.recv(4096).decode()
    print('Received from server:\n\n' + data)
    query = input("Enter query or enter 'done': ")
    print("")
client_socket.close()

