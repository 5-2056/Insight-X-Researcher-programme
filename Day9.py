import pandas as pd

df = pd.DataFrame({ 
    "Name": ["Mithul", "Gautam", "Mukul", "Mehul", "Kartik"],
    "Branch": ["A", "B", "A", "C", "B"],
    "Marks" : [80, 75, 90, 60, 85]
})

average_marks = df.groupby("Branch")["Marks"].mean()

print(average_marks)