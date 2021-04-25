
# %%
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])


N = 5
calculation = (17, 17, 17, 17 ,17)
latency = (0, 0, 10, 30, 30)
overhead = (0, 20, 0, 0, 20)

menStd = (2, 3, 4, 1, 2)
womenStd = (3, 5, 2, 3, 3)
ind = np.arange(N)    # the x locations for the groups
width = 0.35       # the width of the bars: can also be len(x) sequence

fig, ax = plt.subplots()

p1 = ax.bar(ind, calculation, width, label='Calculation')
p2 = ax.bar(ind, latency, width,
            bottom=calculation, label='Latency')
p3 = ax.bar(ind, overhead, width, bottom=np.array(calculation)+np.array(latency), label='Overhead')

# ax.axhline(0, color='grey', linewidth=0.8)
ax.set_ylabel('Scores')
ax.set_title('Scores by group and gender')
ax.set_xticks(ind)
ax.set_xticklabels(('None', 'Overhead', 'latency', 'N*latency', 'N*latency\n+overhead'))
ax.legend()

# Label with label_type 'center' instead of the default 'edge'
# ax.bar_label(p1, label_type='center')
# ax.bar_label(p2, label_type='center')
# ax.bar_label(p3, label_type='center')
# ax.bar_label(p3)

plt.show()



# %%
