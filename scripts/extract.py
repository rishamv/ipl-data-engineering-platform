"""
Extract Module

Reads raw datasets and performs basic validation.
"""

from config.config import (
    MATCHES_FILE,
    DELIVERIES_FILE
)

from utils.file_utils import read_csv

from utils.validation import (
    validate_required_columns,
    validate_duplicate_keys,
    validate_null_values
)


MATCHES_REQUIRED_COLUMNS = [
    "id",
    "season",
    "date",
    "team1",
    "team2",
    "venue"
]


DELIVERIES_REQUIRED_COLUMNS = [
    "match_id",
    "inning",
    "batter",
    "bowler"
]


def extract_data():

    print("Reading source files...")

    matches_df = read_csv(MATCHES_FILE)

    deliveries_df = read_csv(DELIVERIES_FILE)

    print("Validating matches dataset...")

    validate_required_columns(
        matches_df,
        MATCHES_REQUIRED_COLUMNS
    )

    validate_duplicate_keys(
        matches_df,
        "id"
    )

    validate_null_values(
        matches_df,
        [
            "id",
            "season",
            "team1",
            "team2"
        ]
    )

    print("Validating deliveries dataset...")

    validate_required_columns(
        deliveries_df,
        DELIVERIES_REQUIRED_COLUMNS
    )

    validate_null_values(
        deliveries_df,
        [
            "match_id",
            "inning",
            "batter",
            "bowler"
        ]
    )

    print("Extraction completed successfully.")

    return matches_df, deliveries_df


def main():

    matches_df, deliveries_df = extract_data()

    print()

    print(f"Matches      : {len(matches_df):,}")

    print(f"Deliveries   : {len(deliveries_df):,}")


if __name__ == "__main__":
    main()