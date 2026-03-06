import pandas as pd
df = pd.read_csv("StudentMarksDataset.csv")
print(df.head(5))
print(df.describe())