import numpy as np
from scipy import stats

x = np.array([1, 2, 3, 4, 5])
y = np.array([2, 4, 6, 8, 10])

correlation, p_value = stats.pearsonr(x, y)

print("Correlation:", correlation)
print("P-value:", p_value)
