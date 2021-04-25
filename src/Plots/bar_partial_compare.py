
# %%
import matplotlib
import matplotlib.pyplot as plt
import numpy as np
plt.rcParams["font.family"] = "CMU Serif"

# source ./bin/activate

# plt.axis([50, 1050, 0, 10000])


N = 3
#             local, near, far
calculation = (150.8, 17.9, 0.9)
waitingForGet = (0, 128.6, 154.7)
# overhead = (0, 20, 0, 0, 20)

menStd = (2, 3, 4, 1, 2)
womenStd = (3, 5, 2, 3, 3)
ind = np.arange(N)    # the x locations for the groups
width = 0.50       # the width of the bars: can also be len(x) sequence
#                               width, height
fig, ax = plt.subplots(figsize=(4,5))
# fig, ax = plt.subplots()

p1 = ax.bar(ind, calculation, width, label='Calculation', align="center")
p2 = ax.bar(ind, waitingForGet, width,
            bottom=calculation, label='Waiting for get', align="center")
# p3 = ax.bar(ind, overhead, width, bottom=np.array(calculation)+np.array(latency), label='Overhead')

# ax.axhline(0, color='grey', linewidth=0.8)
ax.set_ylabel('Time (s)')
ax.set_title('Time spent calculating vs waiting for response')
ax.set_xticks(ind)
ax.set_xticklabels(('Local', 'Near', 'Far'))
ax.legend(bbox_to_anchor=(0.05, 0.93, 1., .102), loc='lower left', ncol=2, mode=None, borderaxespad=0.)
# ax.legend()
ax.set_ylim([-5,175])

# Label with label_type 'center' instead of the default 'edge'
ax.bar_label(p1, label_type='center')
ax.bar_label(p2, label_type='center')
# ax.bar_label(p3, label_type='center')
# ax.bar_label(p2)

# plt.show()
plt.savefig("bar_local_near_far_compare.png", dpi=400)



# %%
