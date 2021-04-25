
# %%
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])



near_time = [32.2, 9.7, 9.5, 9.3, 9.2, 9.2]
far_time = [185.1, 36.7, 18.4, 9.5, 5.3, 3.12]


# higher X is worse



xaxis = [1,5,10,20, 40, 80]
plt.plot(xaxis, near_time, '.-', label="Near (30ms)")
plt.plot(xaxis, far_time, 'v-', label="Far (170ms)")



plt.xlabel("How often we get from Local (get from Local every x iterations)")
plt.ylabel("Time used for 1000 iterations (s)")
# plt.yscale('log')
plt.xscale('log')
plt.grid(True)
plt.title("Time used vs rate of retrieveing from Local") 
plt.legend()
# plt.show()
plt.savefig("times.png", dpi=400)
# %%
