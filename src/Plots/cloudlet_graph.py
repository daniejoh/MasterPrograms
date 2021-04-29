
# %%
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])



near_time = [9.3, 9.1, 9.1, 9.1, 9.1, 9.1]
far_time = [188.4, 36.4, 17.4, 10.4, 5.1, 3.24]


# higher X is worse



xaxis = [1,5,10,20, 40, 80]
plt.plot(xaxis, near_time, '.-', label="Cloudlet (3ms)")
plt.plot(xaxis, far_time, 'v-', label="Far (170ms)")



plt.xlabel("How often we get from Local (get from Local every x iterations)")
plt.ylabel("Time used for 1000 iterations (s)")
# plt.yscale('log')
plt.xscale('log')
plt.grid(True)
plt.title("Time used vs rate of retrieveing from Local") 
plt.legend()
# plt.show()
plt.savefig("Cloudlet_latency.png", dpi=400)
# %%
