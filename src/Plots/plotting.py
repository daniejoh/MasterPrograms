
# %%
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])



near_time = [20, 40, 70, 110, 130]
far_time = [10, 30, 60, 150, 200]


# higher X is worse



xaxis = [1,10,100,1000, 10000]
plt.plot(xaxis, near_time, '.-', label="Near")
plt.plot(xaxis, far_time, '.-', label="Far")



plt.xlabel(r"N times we get from Local for every $\dfrac{X}{10000}$")
plt.ylabel("Time used")
# plt.yscale('log')
plt.xscale('log')
plt.grid(True)
plt.title("Time used vs rate of retrieveing from Local") 
plt.legend()
plt.show()
#plt.savefig("speedup_factor.png")
# %%
