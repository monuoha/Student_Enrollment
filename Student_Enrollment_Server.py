#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import sqlite3
import pandas as pd
import socket


# In[ ]:


host = socket.gethostname()
port = 5000
server_socket = socket.socket()
server_socket.bind((host, port))
server_socket.listen(1)
conn, address = server_socket.accept()
print('Connection from: ' + str(address))
print("")
sqlite_conn = sqlite3.connect('/Users/michaelonuoha/Downloads/StudentEnrollment.db')
c = sqlite_conn.cursor()
while True:
    data = conn.recv(4096).decode()
    if not data:
        break
    print('From Connected User: ' + str(data))
    print("")
    c.execute(str(data))
    column_names = [desc[0] for desc in c.description]
    df = pd.DataFrame(c.fetchall(), columns = column_names)
    conn.sendall(df.to_string().encode())
conn.close()

