"""
Validation utility functions.
"""

import pandas as pd


def validate_required_columns(
    df: pd.DataFrame,
    required_columns: list[str]
) -> None:
    """
    Validate that all required columns exist.
    """

    missing_columns = [
        column
        for column in required_columns
        if column not in df.columns
    ]

    if missing_columns:
        raise ValueError(
            f"Missing required columns: {missing_columns}"
        )


def validate_duplicate_keys(
    df: pd.DataFrame,
    column_name: str
) -> None:
    """
    Validate duplicate values for a primary key column.
    """

    duplicate_rows = df[df[column_name].duplicated()]

    if not duplicate_rows.empty:
        raise ValueError(
            f"Duplicate values found in '{column_name}'."
        )


def validate_null_values(
    df: pd.DataFrame,
    required_columns: list[str]
) -> None:
    """
    Validate NULL values in mandatory columns.
    """

    for column in required_columns:

        if df[column].isnull().any():

            raise ValueError(
                f"NULL values found in '{column}'."
            )