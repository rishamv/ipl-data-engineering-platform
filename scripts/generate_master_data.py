from pathlib import Path
import pandas as pd

# -------------------------------------------------------
# Project Paths
# -------------------------------------------------------

PROJECT_DIR = Path(__file__).resolve().parent.parent

RAW_DIR = PROJECT_DIR / "data" / "raw"
OUTPUT_DIR = PROJECT_DIR / "database" / "sample_data"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# -------------------------------------------------------
# Read Source Files
# -------------------------------------------------------

matches = pd.read_csv(RAW_DIR / "matches.csv")
deliveries = pd.read_csv(RAW_DIR / "deliveries.csv")

# -------------------------------------------------------
# Team Master
# -------------------------------------------------------

def generate_team_master():

    teams = (
    pd.concat([matches["team1"], matches["team2"]])
      .dropna()
      .drop_duplicates()
      .sort_values()
      .tolist()
    )


    df = pd.DataFrame({
    "TEAM_ID": range(1, len(teams) + 1),
    "TEAM_NAME": teams
})

    df.to_csv(
        OUTPUT_DIR / "team.csv",
        index=False
    )

    print(f"{len(df)} teams generated.")

def main():

    generate_team_master()

if __name__ == "__main__":
    main()