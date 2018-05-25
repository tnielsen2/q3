# IOQuake3 Server

This Dockerfile will build a container that houses an IOQuake3 Server. A legitimate copy of Quake 3 is required in order to run it. The Quake 3 engine is open source, however the pak0.pk3 file is not.


# Install instructions

Clone this repo.

Modify your q3config_server.cfg file. Set your rcon (remote connection) password, and other config parameters. Details on how to configure the server config file are all over Google.

In this case, on line 41 it is set to:

```
seta rconpassword "quakelan"
```

Obtain pak0.pk3 from a purchased copy of Quake 3. This is required to run the server. This can be found in your Steam Quake 3 folder.

Place it in the same folder as this cloned repo.

Build the container image and tag it by the name "quake3"

```
docker build . -t quake3
```

Run the container:

```
docker run --name quake3 -d -p 0.0.0.0:27960:27960/udp quake3
```


# Start the Server

Running the container will not start the server, so this will be achieved through 'rcon'. I use the ioquake3 client to do this. Open the console by pressing the tilde key, and set the IP address and password of the server where the container is running to remotely control it:

```
\seta rconaddress 192.168.1.100
\rcon "password" status
\rcon status
```


Then, start the server with a map of your choosing:

```
map q3dm1
```

To see all the maps on the server, type "map" followed by a space and a tab to see all maps on the server. 
