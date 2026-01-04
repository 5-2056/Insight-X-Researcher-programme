"""Simplified, human-friendly version of the original script.

Features:
- Clear functions: load, filter (IQR), normalize (min-max), plot
- No sklearn dependency (uses plain pandas/numpy for min-max)
- Saves plot images by default instead of calling plt.show() (use --show to display)
- CLI: --file path, --save-prefix, --show

Usage example:
  python "e:\\InsightX technical Question 1.py" --file ScaleMirage.csv

"""

import argparse
import os
from typing import Tuple

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def load_data(path: str) -> pd.DataFrame:
	"""Load CSV and ensure it has at least 'x' and 'y' columns."""
	df = pd.read_csv(path)
	if not {'x', 'y'}.issubset(df.columns):
		raise ValueError("Input CSV must contain 'x' and 'y' columns")
	return df[['x', 'y']].copy()


def filter_outliers_iqr(df: pd.DataFrame, k: float = 1.5) -> pd.DataFrame:
	"""Remove outliers using the IQR rule per column.

	Keeps rows where both x and y are inside [Q1 - k*IQR, Q3 + k*IQR].
	"""
	q1 = df.quantile(0.25)
	q3 = df.quantile(0.75)
	iqr = q3 - q1
	lower = q1 - k * iqr
	upper = q3 + k * iqr
	mask = ((df >= lower) & (df <= upper)).all(axis=1)
	return df.loc[mask].reset_index(drop=True)


def minmax_normalize(df: pd.DataFrame) -> pd.DataFrame:
	"""Simple column-wise min-max normalization to [0, 1]."""
	denom = df.max() - df.min()
	# avoid division by zero
	denom = denom.replace(0, 1)
	return (df - df.min()) / denom


def save_scatter(df: pd.DataFrame, title: str, out_path: str, color: str = 'C0') -> None:
	plt.figure(figsize=(8, 6))
	plt.scatter(df['x'], df['y'], s=10, c=color, alpha=0.7)
	plt.title(title)
	plt.xlabel('x')
	plt.ylabel('y')
	plt.tight_layout()
	plt.savefig(out_path)
	plt.close()


def parse_args() -> argparse.Namespace:
	p = argparse.ArgumentParser(description='Load, filter and normalize x,y data and produce plots')
	p.add_argument('--file', '-f', default='ScaleMirage.csv', help='CSV file with x,y columns')
	p.add_argument('--save-prefix', '-o', default='scale_mirage', help='Prefix for saved plot filenames')
	p.add_argument('--show', action='store_true', help='Also call plt.show() to display the plots')
	p.add_argument('--iqr-k', type=float, default=1.5, help='IQR multiplier for outlier removal')
	return p.parse_args()


def main() -> None:
	args = parse_args()

	if not os.path.exists(args.file):
		print(f"File not found: {args.file}")
		return

	df = load_data(args.file)
	print(f"Loaded {len(df)} rows from {args.file}")

	raw_plot = f"{args.save_prefix}_raw.png"
	save_scatter(df, 'Raw data', raw_plot, color='tab:red')
	print(f"Saved raw plot: {raw_plot}")

	filtered = filter_outliers_iqr(df, k=args.iqr_k)
	print(f"After IQR filtering (k={args.iqr_k}): {len(filtered)} rows remain")

	normalized = minmax_normalize(filtered)
	proc_plot = f"{args.save_prefix}_filtered_normalized.png"
	save_scatter(normalized, 'Filtered & Normalized (min-max)', proc_plot, color='tab:blue')
	print(f"Saved processed plot: {proc_plot}")

	if args.show:
		# show both figures if the user requested interactive display
		fig1 = plt.figure(figsize=(8, 6))
		plt.scatter(df['x'], df['y'], s=10, c='tab:red', alpha=0.6)
		plt.title('Raw data')

		fig2 = plt.figure(figsize=(8, 6))
		plt.scatter(normalized['x'], normalized['y'], s=10, c='tab:blue', alpha=0.7)
		plt.title('Filtered & Normalized (min-max)')

		plt.show()


if __name__ == '__main__':
	main()