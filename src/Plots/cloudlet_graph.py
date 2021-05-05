
# %%
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])



cloudlet_time = [9.3, 9.1, 9.1, 9.1, 9.1, 9.1]
mec_time = [32.2, 9.7, 9.5, 9.3, 9.2, 9.2]
far_time = [188.4, 36.4, 17.4, 10.4, 5.1, 3.24]


# higher X is worse



xaxis = [1,5,10,20, 40, 80]
plt.plot(xaxis, cloudlet_time, '.-.', label="Cloudlet (3ms)")
plt.plot(xaxis, mec_time, '8--', label="MEC (30ms")
plt.plot(xaxis, far_time, 'v-', label="Far (170ms)")



plt.xlabel("Frequency of interaction with Local")
plt.ylabel("Time used for 1000 iterations (s)")
plt.yscale('log')
plt.xscale('log')
plt.grid(True)
plt.title("Time used vs rate of retrieveing from Local") 
plt.legend()
# plt.show()
plt.savefig("All_latency.png", dpi=800)
# %%
