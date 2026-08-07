from pathlib import Path
import pandas as pd

# -------------------------------------------------------
# Project Paths
# -------------------------------------------------------

SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_DIR = SCRIPT_DIR.parent
OUTPUT_DIR = PROJECT_DIR / "database" / "sample_data"

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

# -------------------------------------------------------
# Competition
# -------------------------------------------------------

def generate_competitions():

    competition = [

        {
            "COMPETITION_ID": 1,
            "COMPETITION_CODE": "IPL",
            "COMPETITION_NAME": "Indian Premier League",
            "FORMAT": "T20",
            "STATUS": "ACTIVE"
        },

        {
            "COMPETITION_ID": 2,
            "COMPETITION_CODE": "WPL",
            "COMPETITION_NAME": "Women's Premier League",
            "FORMAT": "T20",
            "STATUS": "ACTIVE"
        }

    ]

    df = pd.DataFrame(competition)

    df.to_csv(
        OUTPUT_DIR / "competition.csv",
        index=False
    )

    print("competition.csv generated.")

# -------------------------------------------------------
# Season
# -------------------------------------------------------

def generate_seasons():

    seasons = [

        {
            "SEASON_ID": 1,
            "COMPETITION_ID": 1,
            "SEASON_YEAR": 2021,
            "SEASON_NAME": "IPL 2021",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 2,
            "COMPETITION_ID": 1,
            "SEASON_YEAR": 2022,
            "SEASON_NAME": "IPL 2022",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 3,
            "COMPETITION_ID": 1,
            "SEASON_YEAR": 2023,
            "SEASON_NAME": "IPL 2023",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 4,
            "COMPETITION_ID": 1,
            "SEASON_YEAR": 2024,
            "SEASON_NAME": "IPL 2024",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 5,
            "COMPETITION_ID": 1,
            "SEASON_YEAR": 2025,
            "SEASON_NAME": "IPL 2025",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 6,
            "COMPETITION_ID": 2,
            "SEASON_YEAR": 2023,
            "SEASON_NAME": "WPL 2023",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 7,
            "COMPETITION_ID": 2,
            "SEASON_YEAR": 2024,
            "SEASON_NAME": "WPL 2024",
            "STATUS": "COMPLETED"
        },

        {
            "SEASON_ID": 8,
            "COMPETITION_ID": 2,
            "SEASON_YEAR": 2025,
            "SEASON_NAME": "WPL 2025",
            "STATUS": "COMPLETED"
        }

    ]

    df = pd.DataFrame(seasons)

    df.to_csv(
        OUTPUT_DIR / "season.csv",
        index=False
    )

    print("season.csv generated.")

    # -------------------------------------------------------
# Team
# -------------------------------------------------------

def generate_teams():

    teams = [

        {
            "TEAM_ID": 1,
            "TEAM_CODE": "CSK",
            "TEAM_NAME": "Chennai Super Kings",
            "SHORT_NAME": "CSK",
            "CITY": "Chennai",
            "STATE": "Tamil Nadu",
            "HOME_VENUE": "M. A. Chidambaram Stadium",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 2,
            "TEAM_CODE": "MI",
            "TEAM_NAME": "Mumbai Indians",
            "SHORT_NAME": "MI",
            "CITY": "Mumbai",
            "STATE": "Maharashtra",
            "HOME_VENUE": "Wankhede Stadium",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 3,
            "TEAM_CODE": "RCB",
            "TEAM_NAME": "Royal Challengers Bengaluru",
            "SHORT_NAME": "RCB",
            "CITY": "Bengaluru",
            "STATE": "Karnataka",
            "HOME_VENUE": "M. Chinnaswamy Stadium",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 4,
            "TEAM_CODE": "KKR",
            "TEAM_NAME": "Kolkata Knight Riders",
            "SHORT_NAME": "KKR",
            "CITY": "Kolkata",
            "STATE": "West Bengal",
            "HOME_VENUE": "Eden Gardens",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 5,
            "TEAM_CODE": "RR",
            "TEAM_NAME": "Rajasthan Royals",
            "SHORT_NAME": "RR",
            "CITY": "Jaipur",
            "STATE": "Rajasthan",
            "HOME_VENUE": "Sawai Mansingh Stadium",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 6,
            "TEAM_CODE": "DC",
            "TEAM_NAME": "Delhi Capitals",
            "SHORT_NAME": "DC",
            "CITY": "New Delhi",
            "STATE": "Delhi",
            "HOME_VENUE": "Arun Jaitley Stadium",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 7,
            "TEAM_CODE": "PBKS",
            "TEAM_NAME": "Punjab Kings",
            "SHORT_NAME": "PBKS",
            "CITY": "Mohali",
            "STATE": "Punjab",
            "HOME_VENUE": "Maharaja Yadavindra Singh International Cricket Stadium",
            "FOUNDED_YEAR": 2008,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 8,
            "TEAM_CODE": "SRH",
            "TEAM_NAME": "Sunrisers Hyderabad",
            "SHORT_NAME": "SRH",
            "CITY": "Hyderabad",
            "STATE": "Telangana",
            "HOME_VENUE": "Rajiv Gandhi International Cricket Stadium",
            "FOUNDED_YEAR": 2013,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 9,
            "TEAM_CODE": "GT",
            "TEAM_NAME": "Gujarat Titans",
            "SHORT_NAME": "GT",
            "CITY": "Ahmedabad",
            "STATE": "Gujarat",
            "HOME_VENUE": "Narendra Modi Stadium",
            "FOUNDED_YEAR": 2022,
            "STATUS": "ACTIVE"
        },

        {
            "TEAM_ID": 10,
            "TEAM_CODE": "LSG",
            "TEAM_NAME": "Lucknow Super Giants",
            "SHORT_NAME": "LSG",
            "CITY": "Lucknow",
            "STATE": "Uttar Pradesh",
            "HOME_VENUE": "BRSABV Ekana Cricket Stadium",
            "FOUNDED_YEAR": 2022,
            "STATUS": "ACTIVE"
        }

    ]

    df = pd.DataFrame(teams)

    df.to_csv(
        OUTPUT_DIR / "team.csv",
        index=False
    )

    print("team.csv generated.")

# -------------------------------------------------------
# Venue
# -------------------------------------------------------

def generate_venues():

    venues = [

        {
            "VENUE_ID": 1,
            "VENUE_NAME": "M. A. Chidambaram Stadium",
            "CITY": "Chennai",
            "STATE": "Tamil Nadu",
            "COUNTRY": "India",
            "CAPACITY": 38000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 2,
            "VENUE_NAME": "Wankhede Stadium",
            "CITY": "Mumbai",
            "STATE": "Maharashtra",
            "COUNTRY": "India",
            "CAPACITY": 33000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 3,
            "VENUE_NAME": "M. Chinnaswamy Stadium",
            "CITY": "Bengaluru",
            "STATE": "Karnataka",
            "COUNTRY": "India",
            "CAPACITY": 40000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 4,
            "VENUE_NAME": "Eden Gardens",
            "CITY": "Kolkata",
            "STATE": "West Bengal",
            "COUNTRY": "India",
            "CAPACITY": 68000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 5,
            "VENUE_NAME": "Narendra Modi Stadium",
            "CITY": "Ahmedabad",
            "STATE": "Gujarat",
            "COUNTRY": "India",
            "CAPACITY": 132000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 6,
            "VENUE_NAME": "Arun Jaitley Stadium",
            "CITY": "New Delhi",
            "STATE": "Delhi",
            "COUNTRY": "India",
            "CAPACITY": 41000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 7,
            "VENUE_NAME": "Rajiv Gandhi International Cricket Stadium",
            "CITY": "Hyderabad",
            "STATE": "Telangana",
            "COUNTRY": "India",
            "CAPACITY": 55000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 8,
            "VENUE_NAME": "Sawai Mansingh Stadium",
            "CITY": "Jaipur",
            "STATE": "Rajasthan",
            "COUNTRY": "India",
            "CAPACITY": 30000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 9,
            "VENUE_NAME": "Maharaja Yadavindra Singh International Cricket Stadium",
            "CITY": "Mohali",
            "STATE": "Punjab",
            "COUNTRY": "India",
            "CAPACITY": 38000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 10,
            "VENUE_NAME": "BRSABV Ekana Cricket Stadium",
            "CITY": "Lucknow",
            "STATE": "Uttar Pradesh",
            "COUNTRY": "India",
            "CAPACITY": 50000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 11,
            "VENUE_NAME": "Dr. Y.S. Rajasekhara Reddy ACA-VDCA Cricket Stadium",
            "CITY": "Visakhapatnam",
            "STATE": "Andhra Pradesh",
            "COUNTRY": "India",
            "CAPACITY": 27000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 12,
            "VENUE_NAME": "Barsapara Cricket Stadium",
            "CITY": "Guwahati",
            "STATE": "Assam",
            "COUNTRY": "India",
            "CAPACITY": 40000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 13,
            "VENUE_NAME": "Himachal Pradesh Cricket Association Stadium",
            "CITY": "Dharamshala",
            "STATE": "Himachal Pradesh",
            "COUNTRY": "India",
            "CAPACITY": 23000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 14,
            "VENUE_NAME": "Greenfield International Stadium",
            "CITY": "Thiruvananthapuram",
            "STATE": "Kerala",
            "COUNTRY": "India",
            "CAPACITY": 50000,
            "STATUS": "ACTIVE"
        },

        {
            "VENUE_ID": 15,
            "VENUE_NAME": "Brabourne Stadium",
            "CITY": "Mumbai",
            "STATE": "Maharashtra",
            "COUNTRY": "India",
            "CAPACITY": 20000,
            "STATUS": "ACTIVE"
        }

    ]

    df = pd.DataFrame(venues)

    df.to_csv(
        OUTPUT_DIR / "venue.csv",
        index=False
    )

    print("venue.csv generated.")

# -------------------------------------------------------
# Umpire
# -------------------------------------------------------

def generate_umpires():

    umpires = [

        {
            "UMPIRE_ID": 1,
            "FIRST_NAME": "Nitin",
            "LAST_NAME": "Menon",
            "FULL_NAME": "Nitin Menon",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 2,
            "FIRST_NAME": "Anil",
            "LAST_NAME": "Chaudhary",
            "FULL_NAME": "Anil Chaudhary",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 3,
            "FIRST_NAME": "Rod",
            "LAST_NAME": "Tucker",
            "FULL_NAME": "Rod Tucker",
            "COUNTRY": "Australia",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 4,
            "FIRST_NAME": "Kumar",
            "LAST_NAME": "Dharmasena",
            "FULL_NAME": "Kumar Dharmasena",
            "COUNTRY": "Sri Lanka",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 5,
            "FIRST_NAME": "Chris",
            "LAST_NAME": "Gaffaney",
            "FULL_NAME": "Chris Gaffaney",
            "COUNTRY": "New Zealand",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 6,
            "FIRST_NAME": "Richard",
            "LAST_NAME": "Illingworth",
            "FULL_NAME": "Richard Illingworth",
            "COUNTRY": "England",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 7,
            "FIRST_NAME": "Paul",
            "LAST_NAME": "Reiffel",
            "FULL_NAME": "Paul Reiffel",
            "COUNTRY": "Australia",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 8,
            "FIRST_NAME": "Bruce",
            "LAST_NAME": "Oxenford",
            "FULL_NAME": "Bruce Oxenford",
            "COUNTRY": "Australia",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 9,
            "FIRST_NAME": "Marais",
            "LAST_NAME": "Erasmus",
            "FULL_NAME": "Marais Erasmus",
            "COUNTRY": "South Africa",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 10,
            "FIRST_NAME": "Jayaraman",
            "LAST_NAME": "Madanagopal",
            "FULL_NAME": "Jayaraman Madanagopal",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 11,
            "FIRST_NAME": "KN",
            "LAST_NAME": "Ananthapadmanabhan",
            "FULL_NAME": "KN Ananthapadmanabhan",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 12,
            "FIRST_NAME": "Ulhas",
            "LAST_NAME": "Gandhe",
            "FULL_NAME": "Ulhas Gandhe",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 13,
            "FIRST_NAME": "Virender",
            "LAST_NAME": "Sharma",
            "FULL_NAME": "Virender Sharma",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 14,
            "FIRST_NAME": "Vineet",
            "LAST_NAME": "Kulkarni",
            "FULL_NAME": "Vineet Kulkarni",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 15,
            "FIRST_NAME": "Akshay",
            "LAST_NAME": "Totre",
            "FULL_NAME": "Akshay Totre",
            "COUNTRY": "India",
            "STATUS": "ACTIVE"
        },

        {
            "UMPIRE_ID": 16,
            "FIRST_NAME": "Sundaram",
            "LAST_NAME": "Ravi",
            "FULL_NAME": "Sundaram Ravi",
            "COUNTRY": "India",
            "STATUS": "RETIRED"
        },

        {
            "UMPIRE_ID": 17,
            "FIRST_NAME": "Nigel",
            "LAST_NAME": "Llong",
            "FULL_NAME": "Nigel Llong",
            "COUNTRY": "England",
            "STATUS": "RETIRED"
        },

        {
            "UMPIRE_ID": 18,
            "FIRST_NAME": "Simon",
            "LAST_NAME": "Fry",
            "FULL_NAME": "Simon Fry",
            "COUNTRY": "Australia",
            "STATUS": "RETIRED"
        },

        {
            "UMPIRE_ID": 19,
            "FIRST_NAME": "Chettithody",
            "LAST_NAME": "Nandan",
            "FULL_NAME": "C K Nandan",
            "COUNTRY": "India",
            "STATUS": "RETIRED"
        },

        {
            "UMPIRE_ID": 20,
            "FIRST_NAME": "S",
            "LAST_NAME": "Ravi",
            "FULL_NAME": "S Ravi",
            "COUNTRY": "India",
            "STATUS": "RETIRED"
        }

    ]

    df = pd.DataFrame(umpires)

    df.to_csv(
        OUTPUT_DIR / "umpire.csv",
        index=False
    )

    print("umpire.csv generated.")

# -------------------------------------------------------
# Main
# -------------------------------------------------------

def main():

    generate_competitions()
    generate_seasons()
    generate_teams()
    generate_venues()
    generate_umpires()

    print("\nAll sample files generated successfully.")

if __name__ == "__main__":
    main()