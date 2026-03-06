import seaborn as sns
import matplotlib.pyplot as plt

tips = sns.read_dataset("tips")

plt.figure(figsize=(10, 6))

sns.boxplot(x="day", y="tip", data=tips, palette="Set2", width=0.6)

plt.title("Tip Distribution by Day", fontsize=10, fontweight='bold', pad=20)
plt.xlabel("Day of Week", fontsize=10, fontweight='bold')
plt.ylabel("Tip Amount ($)", fontsize=10, fontweight='bold')

plt.grid(axis='y', alpha=0.3, linestyle='--')

plt.xticks(fontsize=11)
plt.yticks(fontsize=11)

ax = plt.gca()
ax.set_facecolor("#5f8ab5")

plt.tight_layout()
plt.show()
