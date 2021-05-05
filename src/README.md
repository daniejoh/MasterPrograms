# Prototype for testing Near-Far Computing

## Structure
Folder ```configs``` contain config files used in the program. How they work are described in the thesis. See implementation chapter.

Folder ```playground``` contains some isolated tests for some of the implementation. They are not in use and can frankly be ignored.

Folder ```Plots``` contains Python3 code used to create plots in the thesis

All Emerald files (```.m```) in this folder is used for the prototype.

## How to run
This will describe how you can start the prototype and test 3 nodes.

1. Log in to two nodes, preferably on PlanetLab so that you have a shell available on these nodes. Open a shell on your local device.
2. In one of the remote shells, write ```emx -U -R``` to start a server.
3. In the other remote shell, write ```emx -U -R<ip to other remote node>:<port>```
4. Write a config file, and ensure that the path to this file is in the code.
5. On your local device, run this:
```
make remote ARGS=<ip of remote node>:<port>
```

After this, the code should run. You will be prompted with where you want to place each HashWorker. After they are placed, they will start working. When every node is done, it will print how much time they used.