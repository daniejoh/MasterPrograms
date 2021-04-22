
# %%
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])



speedup = [0.720, 1.713, 3.990, 4.183]



x = [2000000,20000000,200000000,2000000000]
plt.plot(x, speedup, '.-', label="speedup")

plt.xlabel("value of N")
plt.ylabel("Speedup relative to seq version")
# plt.yscale('log')
plt.grid(True)
plt.title("REEE") 
# plt.legend()
plt.show()
#plt.savefig("speedup_factor.png")
# %%
