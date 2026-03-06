import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# ----------- data loading (CSV option) -----------

df = pd.read_csv("sales_data.csv")
df = pd.DataFrame({"Product": df['Product_ID'], "Sales": df['Sales_Amount']})
print(df.head())
print(df.info())

print("Duplicates?", df.duplicated().any())
print("Missing values?\n", df.isna().sum())
print(df.describe())

plt.figure(figsize=(12, 6))
plt.plot(df['Product'], df['Sales'], marker='o', color='green', linewidth=2)
plt.title('Line Chart: Monthly Sales Trend')
plt.xlabel('Product')
plt.ylabel('Sales')
plt.grid(True)
plt.tight_layout()
plt.show()

plt.figure(figsize=(10, 5))
sns.barplot(x='Product', y='Sales', data=df, palette='Blues_d')
plt.title('Bar Plot: Sales per Product')
plt.xlabel('Product')
plt.ylabel('Sales')
plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

plt.figure(figsize=(8, 4))
sns.boxplot(x='Sales', data=df, color='lightblue')
plt.title('Boxplot: Sales Distribution')
plt.tight_layout()
plt.show()

plt.figure(figsize=(10,5))
sns.regplot(x=pd.Categorical(df['Product']).codes, y='Sales', data=df, marker='o', scatter_kws={'s':50})
plt.xticks(ticks=range(len(df)), labels=df['Product'])
plt.title('Scatter w/ Trendline')
plt.xlabel('Product')
plt.ylabel('Sales')
plt.tight_layout()
plt.show()

