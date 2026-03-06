import matplotlib.pyplot as plt

months = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
sales = [200,250,300,280,350,400,420,460,480,500,530,600]

plt.figure(figsize=(12, 6))
plt.plot(months, sales, marker='o', markersize=8,color="#033394",linewidth=2.5,label='Sales Growth',linestyle='-')          

plt.title("Monthly Sales Growth", fontsize=16, fontweight='bold', pad=20)
plt.xlabel("Months", fontsize=12, fontweight='bold')
plt.ylabel("Sales ($)", fontsize=12, fontweight='bold')

plt.grid(True, alpha=0.3, linestyle='--', linewidth=0.7)

plt.xticks(rotation=45, fontsize=10)
plt.yticks(fontsize=10)

plt.legend(loc='upper left', fontsize=11, framealpha=0.9)

for i, (month, sale) in enumerate(zip(months, sales)):
    plt.text(i, sale + 15, f'${sale}', ha='center', fontsize=9, fontweight='bold')

plt.tight_layout()

plt.show()
