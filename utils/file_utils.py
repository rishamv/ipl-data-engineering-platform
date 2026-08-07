"""
Utility functions for reading and writing files.
"""

from pathlib import Path
import pandas as pd


def read_csv(file_path: Path) -> pd.DataFrame:
    """
    Read a CSV file and return a pandas DataFrame.
    """

    try:
        return pd.read_csv(file_path)

    except FileNotFoundError:
        raise FileNotFoundError(f"File not found: {file_path}")

    except Exception as error:
        raise Exception(f"Error reading {file_path}: {error}")


def write_csv(df: pd.DataFrame, file_path: Path) -> None:
    """
    Write a DataFrame to a CSV file.
    """

    try:
        file_path.parent.mkdir(parents=True, exist_ok=True)
        df.to_csv(file_path, index=False)

    except Exception as error:
        raise Exception(f"Error writing {file_path}: {error}")