


#GPU Speeds

 Device 0: Tesla K80
 Quick Mode

 Host to Device Bandwidth, 1 Device(s)
 PINNED Memory Transfers
   Transfer Size (Bytes)    Bandwidth(MB/s)
  33554432         7760.1

 Device to Host Bandwidth, 1 Device(s)
 PINNED Memory Transfers
   Transfer Size (Bytes)    Bandwidth(MB/s)
   33554432         7761.0

 Device to Device Bandwidth, 1 Device(s)
 PINNED Memory Transfers
   Transfer Size (Bytes)    Bandwidth(MB/s)
   33554432         140484.7


#Fusion.io in use with GPU
fio on a SX300 gives the following info:
WRITE: io=281138MB, aggrb=2334.7MB/s, minb=2334.7MB/s, maxb=2334.7MB/s, mint=120422msec, maxt=120422msec

so we see that host to device is 3x faster. Therefore one should always try to stay in gpu memory > system memory > fusion memory (thats obvious :-). But if you start dealing with a lot of data latency and bandwith may keep your gpu idle most of the time...

#GPU to GPU bandwith considerations
Run a p2p bandwith test (proviced in the sample sources of the cuda toolkid) to see which devices are fastest with each other..
Check for:
1. Bandwith
2. Latency


