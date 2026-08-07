from pathlib import Path
import pandas as pd

PROJECT_DIR = Path(__file__).resolve().parent.parent

MATCHES_FILE = PROJECT_DIR / "data" / "raw" / "matches.csv"
DELIVERIES_FILE = PROJECT_DIR / "data" / "raw" / "deliveries.csv"

matches = pd.read_csv(MATCHES_FILE)
deliveries = pd.read_csv(DELIVERIES_FILE)

print("MATCHES COLUMNS")
print(matches.columns.tolist())

print()

print("DELIVERIES COLUMNS")
print(deliveries.columns.tolist())