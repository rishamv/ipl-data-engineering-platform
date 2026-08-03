# Data Dictionary

## IPL Data Engineering Platform

**Version:** 1.0

**Prepared By:** Risham Venghat

---

# 1. Purpose

This document defines every database column used in the IPL Data Engineering Platform. It acts as the technical blueprint for designing Oracle database tables and ensures consistency across PL/SQL procedures, ETL pipelines, APIs, and dashboards.

---

# 2. Naming Standards

| Standard          | Convention                               |
| ----------------- | ---------------------------------------- |
| Table Names       | Singular, Uppercase (e.g., TEAM, PLAYER) |
| Primary Key       | `<TABLE_NAME>_ID`                        |
| Foreign Key       | References parent table primary key      |
| Date Columns      | Suffix `_DATE`                           |
| Timestamp Columns | Suffix `_TIMESTAMP`                      |
| Boolean Values    | CHAR(1) ('Y'/'N')                        |
| Status Columns    | VARCHAR2 with predefined values          |

---

# 3. Master Entities

---

# 3.1 COMPETITION

## Purpose

Stores cricket competitions supported by the platform.

### Table Definition

| Column           | Data Type     | Nullable | Key    | Description                   | Example               |
| ---------------- | ------------- | -------- | ------ | ----------------------------- | --------------------- |
| COMPETITION_ID   | NUMBER(10)    | No       | PK     | Unique competition identifier | 1                     |
| COMPETITION_NAME | VARCHAR2(100) | No       | Unique | Name of competition           | Indian Premier League |
| SHORT_NAME       | VARCHAR2(20)  | No       |        | Abbreviation                  | IPL                   |
| COUNTRY          | VARCHAR2(50)  | No       |        | Host country                  | India                 |
| GOVERNING_BODY   | VARCHAR2(100) | Yes      |        | Organizing body               | BCCI                  |
| START_YEAR       | NUMBER(4)     | No       |        | Competition start year        | 2008                  |
| CREATED_DATE     | DATE          | No       |        | Record creation date          | 01-JAN-2026           |
| UPDATED_DATE     | DATE          | Yes      |        | Last modification date        | 10-JAN-2026           |

### Business Rules

* Competition name must be unique.
* Start year cannot be in the future.

---

# 3.2 SEASON

## Purpose

Stores each edition of a competition.

### Table Definition

| Column         | Data Type    | Nullable | Key | Description                   | Example     |
| -------------- | ------------ | -------- | --- | ----------------------------- | ----------- |
| SEASON_ID      | NUMBER(10)   | No       | PK  | Unique season identifier      | 2025        |
| COMPETITION_ID | NUMBER(10)   | No       | FK  | References COMPETITION        | 1           |
| SEASON_NAME    | VARCHAR2(50) | No       |     | Display name                  | IPL 2025    |
| START_DATE     | DATE         | No       |     | Tournament start              | 21-MAR-2025 |
| END_DATE       | DATE         | No       |     | Tournament end                | 25-MAY-2025 |
| TOTAL_MATCHES  | NUMBER(3)    | Yes      |     | Number of matches             | 74          |
| STATUS         | VARCHAR2(20) | No       |     | UPCOMING / ACTIVE / COMPLETED | COMPLETED   |
| CREATED_DATE   | DATE         | No       |     | Record creation date          | 01-JAN-2026 |
| UPDATED_DATE   | DATE         | Yes      |     | Last update                   | 15-JAN-2026 |

### Business Rules

* Every season belongs to one competition.
* End date must be after start date.
* Status must be one of: UPCOMING, ACTIVE, COMPLETED.

---

# 3.3 TEAM

## Purpose

Stores IPL franchise information.

### Table Definition

| Column         | Data Type     | Nullable | Key    | Description                  | Example                   |
| -------------- | ------------- | -------- | ------ | ---------------------------- | ------------------------- |
| TEAM_ID        | NUMBER(10)    | No       | PK     | Unique team identifier       | 101                       |
| COMPETITION_ID | NUMBER(10)    | No       | FK     | Competition reference        | 1                         |
| TEAM_NAME      | VARCHAR2(100) | No       | Unique | Official team name           | Chennai Super Kings       |
| SHORT_NAME     | VARCHAR2(10)  | No       | Unique | Team abbreviation            | CSK                       |
| HOME_CITY      | VARCHAR2(100) | No       |        | Home city                    | Chennai                   |
| STATE          | VARCHAR2(100) | Yes      |        | State                        | Tamil Nadu                |
| COUNTRY        | VARCHAR2(50)  | No       |        | Country                      | India                     |
| FOUNDED_YEAR   | NUMBER(4)     | Yes      |        | Franchise establishment year | 2008                      |
| HOME_GROUND    | VARCHAR2(100) | Yes      |        | Home stadium                 | M. A. Chidambaram Stadium |
| ACTIVE_FLAG    | CHAR(1)       | No       |        | Y / N                        | Y                         |
| CREATED_DATE   | DATE          | No       |        | Record creation              | 01-JAN-2026               |
| UPDATED_DATE   | DATE          | Yes      |        | Record update                | 10-JAN-2026               |

### Business Rules

* Team name must be unique.
* Short name must be unique.
* Active flag must contain only Y or N.

---

# 3.4 PLAYER

## Purpose

Stores player master information.

### Table Definition

| Column        | Data Type     | Nullable | Key | Description                               | Example          |
| ------------- | ------------- | -------- | --- | ----------------------------------------- | ---------------- |
| PLAYER_ID     | NUMBER(10)    | No       | PK  | Player identifier                         | 5001             |
| FULL_NAME     | VARCHAR2(150) | No       |     | Player full name                          | Virat Kohli      |
| FIRST_NAME    | VARCHAR2(75)  | Yes      |     | First name                                | Virat            |
| LAST_NAME     | VARCHAR2(75)  | Yes      |     | Last name                                 | Kohli            |
| DATE_OF_BIRTH | DATE          | Yes      |     | Date of birth                             | 05-NOV-1988      |
| NATIONALITY   | VARCHAR2(50)  | No       |     | Country                                   | India            |
| BATTING_STYLE | VARCHAR2(50)  | Yes      |     | Batting style                             | Right-hand bat   |
| BOWLING_STYLE | VARCHAR2(100) | Yes      |     | Bowling style                             | Right-arm medium |
| PRIMARY_ROLE  | VARCHAR2(50)  | No       |     | Batter, Bowler, All-Rounder, Wicketkeeper | Batter           |
| DEBUT_YEAR    | NUMBER(4)     | Yes      |     | IPL debut                                 | 2008             |
| ACTIVE_FLAG   | CHAR(1)       | No       |     | Y / N                                     | Y                |
| CREATED_DATE  | DATE          | No       |     | Record creation                           | 01-JAN-2026      |
| UPDATED_DATE  | DATE          | Yes      |     | Last update                               | 15-JAN-2026      |

### Business Rules

* Player names should not be null.
* Primary role must be from an approved list.
* Active flag accepts only Y or N.

---

# 3.5 PLAYER_TEAM_HISTORY

## Purpose

Tracks the team represented by a player in each season.

### Table Definition

| Column        | Data Type    | Nullable | Key | Description        | Example     |
| ------------- | ------------ | -------- | --- | ------------------ | ----------- |
| HISTORY_ID    | NUMBER(10)   | No       | PK  | History identifier | 9001        |
| PLAYER_ID     | NUMBER(10)   | No       | FK  | References PLAYER  | 5001        |
| TEAM_ID       | NUMBER(10)   | No       | FK  | References TEAM    | 101         |
| SEASON_ID     | NUMBER(10)   | No       | FK  | References SEASON  | 2025        |
| JERSEY_NUMBER | NUMBER(3)    | Yes      |     | Jersey number      | 18          |
| AUCTION_PRICE | NUMBER(12,2) | Yes      |     | Purchase price     | 210000000   |
| START_DATE    | DATE         | Yes      |     | Association start  | 01-MAR-2025 |
| END_DATE      | DATE         | Yes      |     | Association end    | 31-MAY-2025 |
| CREATED_DATE  | DATE         | No       |     | Record creation    | 01-JAN-2026 |
| UPDATED_DATE  | DATE         | Yes      |     | Record update      | 15-JAN-2026 |

### Business Rules

* One player can have only one active team per season.
* End date must be greater than or equal to start date.
* Historical records should not be deleted.

---

# 3.6 VENUE

## Purpose

Stores stadium information.

### Table Definition

| Column           | Data Type     | Nullable | Key    | Description      | Example          |
| ---------------- | ------------- | -------- | ------ | ---------------- | ---------------- |
| VENUE_ID         | NUMBER(10)    | No       | PK     | Venue identifier | 301              |
| VENUE_NAME       | VARCHAR2(150) | No       | Unique | Stadium name     | Wankhede Stadium |
| CITY             | VARCHAR2(100) | No       |        | City             | Mumbai           |
| STATE            | VARCHAR2(100) | Yes      |        | State            | Maharashtra      |
| COUNTRY          | VARCHAR2(50)  | No       |        | Country          | India            |
| CAPACITY         | NUMBER(6)     | Yes      |        | Seating capacity | 33000            |
| ESTABLISHED_YEAR | NUMBER(4)     | Yes      |        | Year opened      | 1974             |
| CREATED_DATE     | DATE          | No       |        | Record creation  | 01-JAN-2026      |
| UPDATED_DATE     | DATE          | Yes      |        | Record update    | 10-JAN-2026      |

### Business Rules

* Venue names must be unique.
* Capacity cannot be negative.

---

# 3.7 UMPIRE

## Purpose

Stores umpire information.

### Table Definition

| Column       | Data Type     | Nullable | Key | Description          | Example          |
| ------------ | ------------- | -------- | --- | -------------------- | ---------------- |
| UMPIRE_ID    | NUMBER(10)    | No       | PK  | Umpire identifier    | 801              |
| FULL_NAME    | VARCHAR2(150) | No       |     | Full name            | Kumar Dharmasena |
| NATIONALITY  | VARCHAR2(50)  | No       |     | Country              | Sri Lanka        |
| ICC_PANEL    | VARCHAR2(50)  | Yes      |     | Panel classification | Elite Panel      |
| ACTIVE_FLAG  | CHAR(1)       | No       |     | Y / N                | Y                |
| CREATED_DATE | DATE          | No       |     | Record creation      | 01-JAN-2026      |
| UPDATED_DATE | DATE          | Yes      |     | Last update          | 10-JAN-2026      |

### Business Rules

* Umpire names should be unique.
* Active flag accepts only Y or N.

---

# 4. Common Audit Columns

The following columns will appear in most master tables.

| Column       | Data Type | Purpose                       |
| ------------ | --------- | ----------------------------- |
| CREATED_DATE | DATE      | Stores record creation date   |
| UPDATED_DATE | DATE      | Stores last modification date |

In later project phases, these may be extended to include:

* CREATED_BY
* UPDATED_BY
* VERSION_NUMBER
* ROW_STATUS

to support enterprise-style auditing and optimistic locking.

---

# 5. Summary

This section defines the master entities that serve as the foundation of the IPL Data Engineering Platform. These tables provide the reference data used throughout transactional processing, reporting, and analytics.

The next section of this data dictionary will define the **Transaction Entities** (MATCH, INNINGS, DELIVERY, and WICKET), which represent the core cricket events captured by the system.

# 6. Transaction Entities

Transaction entities store all match-related events. These tables contain the highest volume of data within the IPL Data Engineering Platform and form the foundation for analytics, reporting, and PL/SQL business logic.

---

# 6.1 MATCH

## Purpose

Stores information about every IPL match played in a season.

Each record represents one completed or scheduled match.

### Table Definition

| Column             | Data Type    | Nullable | Key | Description                     | Example     |
| ------------------ | ------------ | -------- | --- | ------------------------------- | ----------- |
| MATCH_ID           | NUMBER(10)   | No       | PK  | Unique match identifier         | 10001       |
| SEASON_ID          | NUMBER(10)   | No       | FK  | References SEASON               | 2025        |
| MATCH_NUMBER       | NUMBER(3)    | No       |     | Match number within season      | 1           |
| MATCH_DATE         | DATE         | No       |     | Match date                      | 22-MAR-2025 |
| VENUE_ID           | NUMBER(10)   | No       | FK  | References VENUE                | 301         |
| TEAM1_ID           | NUMBER(10)   | No       | FK  | First team                      | 101         |
| TEAM2_ID           | NUMBER(10)   | No       | FK  | Second team                     | 102         |
| TOSS_WINNER_ID     | NUMBER(10)   | Yes      | FK  | Toss winning team               | 101         |
| TOSS_DECISION      | VARCHAR2(10) | Yes      |     | BAT / FIELD                     | FIELD       |
| WINNER_TEAM_ID     | NUMBER(10)   | Yes      | FK  | Match winner                    | 101         |
| PLAYER_OF_MATCH_ID | NUMBER(10)   | Yes      | FK  | Award winner                    | 5001        |
| RESULT_TYPE        | VARCHAR2(30) | Yes      |     | Runs, Wickets, Tie, No Result   | Wickets     |
| WIN_MARGIN         | NUMBER(4)    | Yes      |     | Winning margin                  | 6           |
| MATCH_STATUS       | VARCHAR2(20) | No       |     | Scheduled, Completed, Abandoned | COMPLETED   |
| CREATED_DATE       | DATE         | No       |     | Record creation                 | 01-JAN-2026 |
| UPDATED_DATE       | DATE         | Yes      |     | Record update                   | 01-JAN-2026 |

### Business Rules

* TEAM1_ID and TEAM2_ID must be different.
* Winner must be one of the participating teams.
* Toss winner must be one of the participating teams.
* Match belongs to exactly one season.
* Match is played at exactly one venue.

---

# 6.2 INNINGS

## Purpose

Stores innings-level information for every match.

Normally, a T20 match contains two innings, but the model supports additional innings if required by future competitions.

### Table Definition

| Column          | Data Type   | Nullable | Key | Description        | Example     |
| --------------- | ----------- | -------- | --- | ------------------ | ----------- |
| INNINGS_ID      | NUMBER(10)  | No       | PK  | Innings identifier | 20001       |
| MATCH_ID        | NUMBER(10)  | No       | FK  | References MATCH   | 10001       |
| INNINGS_NUMBER  | NUMBER(1)   | No       |     | 1 or 2             | 1           |
| BATTING_TEAM_ID | NUMBER(10)  | No       | FK  | Batting team       | 101         |
| BOWLING_TEAM_ID | NUMBER(10)  | No       | FK  | Bowling team       | 102         |
| TOTAL_RUNS      | NUMBER(4)   | Yes      |     | Runs scored        | 186         |
| TOTAL_WICKETS   | NUMBER(2)   | Yes      |     | Wickets lost       | 6           |
| OVERS_PLAYED    | NUMBER(4,1) | Yes      |     | Overs completed    | 20.0        |
| EXTRAS          | NUMBER(3)   | Yes      |     | Total extras       | 8           |
| CREATED_DATE    | DATE        | No       |     | Record creation    | 01-JAN-2026 |
| UPDATED_DATE    | DATE        | Yes      |     | Record update      | 01-JAN-2026 |

### Business Rules

* Every innings belongs to one match.
* Batting and bowling teams must be different.
* Innings number must be unique within a match.

---

# 6.3 DELIVERY

## Purpose

Stores every ball bowled during an innings.

This is the largest table in the database and forms the basis for most analytical queries.

### Table Definition

| Column         | Data Type    | Nullable | Key | Description                 | Example     |
| -------------- | ------------ | -------- | --- | --------------------------- | ----------- |
| DELIVERY_ID    | NUMBER(12)   | No       | PK  | Delivery identifier         | 3000001     |
| MATCH_ID       | NUMBER(10)   | No       | FK  | References MATCH            | 10001       |
| INNINGS_ID     | NUMBER(10)   | No       | FK  | References INNINGS          | 20001       |
| OVER_NUMBER    | NUMBER(2)    | No       |     | Over number                 | 18          |
| BALL_NUMBER    | NUMBER(1)    | No       |     | Ball within over            | 4           |
| BATTER_ID      | NUMBER(10)   | No       | FK  | Batter                      | 5001        |
| NON_STRIKER_ID | NUMBER(10)   | No       | FK  | Non-striker                 | 5002        |
| BOWLER_ID      | NUMBER(10)   | No       | FK  | Bowler                      | 6001        |
| BATTER_RUNS    | NUMBER(2)    | No       |     | Runs from bat               | 4           |
| EXTRA_RUNS     | NUMBER(2)    | No       |     | Extras                      | 1           |
| TOTAL_RUNS     | NUMBER(2)    | No       |     | Total runs                  | 5           |
| EXTRA_TYPE     | VARCHAR2(20) | Yes      |     | Wide, No Ball, Bye, Leg Bye | Wide        |
| IS_BOUNDARY    | CHAR(1)      | No       |     | Y / N                       | Y           |
| IS_SIX         | CHAR(1)      | No       |     | Y / N                       | N           |
| CREATED_DATE   | DATE         | No       |     | Record creation             | 01-JAN-2026 |

### Business Rules

* Every delivery belongs to exactly one innings.
* Ball number starts at 1.
* Total runs = Batter runs + Extra runs.
* Boundary flag accepts only Y or N.
* Six flag accepts only Y or N.

---

# 6.4 WICKET

## Purpose

Stores dismissal events associated with deliveries.

A delivery may or may not result in a wicket.

### Table Definition

| Column         | Data Type    | Nullable | Key | Description                  | Example     |
| -------------- | ------------ | -------- | --- | ---------------------------- | ----------- |
| WICKET_ID      | NUMBER(12)   | No       | PK  | Wicket identifier            | 900001      |
| DELIVERY_ID    | NUMBER(12)   | No       | FK  | References DELIVERY          | 3000001     |
| PLAYER_OUT_ID  | NUMBER(10)   | No       | FK  | Dismissed player             | 5003        |
| DISMISSAL_TYPE | VARCHAR2(50) | No       |     | Bowled, Caught, LBW, Run Out | Caught      |
| FIELDER_ID     | NUMBER(10)   | Yes      | FK  | Assisting fielder            | 7001        |
| CREATED_DATE   | DATE         | No       |     | Record creation              | 01-JAN-2026 |

### Business Rules

* Every wicket must reference one delivery.
* A delivery can have at most one wicket record.
* Fielder is optional for dismissal types such as Bowled or LBW.
* Dismissal type must match a predefined list of cricket dismissal methods.

---

# 6.5 Design Notes

### Why separate MATCH, INNINGS, DELIVERY, and WICKET?

Each table represents a different level of cricket data.

```text
Match
   │
   ├── Innings
   │      │
   │      ├── Deliveries
   │      │        │
   │      │        └── Wicket (optional)
```

This hierarchy:

* Eliminates data duplication.
* Simplifies reporting.
* Improves query performance.
* Keeps the schema normalized.
* Makes future enhancements easier.

---

# 6.6 Common Validation Rules

The following validations will later be enforced through Oracle constraints and PL/SQL:

* Match date must fall within the associated season.
* A team cannot play against itself.
* Innings must belong to an existing match.
* Deliveries cannot exist without an innings.
* Wickets cannot exist without a delivery.
* Runs cannot be negative.
* Overs and ball numbers must follow cricket rules.
* Foreign key values must reference existing master records.

---

# 6.7 Summary

The transaction entities capture every significant event that occurs during an IPL match. These tables will receive data from the Python ETL pipeline and serve as the primary source for analytics, REST APIs, and dashboards.

The next section of the data dictionary will define the **Analytical Entities** and **Operational Entities**, which store aggregated statistics, tournament standings, ETL execution details, and system error logs.

# 7. Analytical Entities

Analytical entities store aggregated and derived data calculated from the transactional tables. These tables improve reporting performance by avoiding repeated calculations on millions of delivery records.

Unlike transaction tables, these tables are populated through scheduled ETL jobs and PL/SQL procedures.

---

# 7.1 PLAYER_STATISTICS

## Purpose

Stores season-wise statistics for each player.

This table is generated from MATCH, INNINGS, DELIVERY and WICKET data.

### Table Definition

| Column          | Data Type   | Nullable | Key | Description           | Example     |
| --------------- | ----------- | -------- | --- | --------------------- | ----------- |
| PLAYER_STAT_ID  | NUMBER(10)  | No       | PK  | Statistics identifier | 10001       |
| PLAYER_ID       | NUMBER(10)  | No       | FK  | References PLAYER     | 5001        |
| SEASON_ID       | NUMBER(10)  | No       | FK  | References SEASON     | 2025        |
| MATCHES_PLAYED  | NUMBER(3)   | No       |     | Total matches         | 14          |
| INNINGS_BATTED  | NUMBER(3)   | No       |     | Batting innings       | 14          |
| RUNS_SCORED     | NUMBER(5)   | No       |     | Total runs            | 741         |
| BALLS_FACED     | NUMBER(5)   | No       |     | Balls faced           | 480         |
| HIGHEST_SCORE   | NUMBER(3)   | No       |     | Highest score         | 113         |
| BATTING_AVERAGE | NUMBER(6,2) | Yes      |     | Batting average       | 61.75       |
| STRIKE_RATE     | NUMBER(6,2) | Yes      |     | Strike rate           | 154.37      |
| FIFTIES         | NUMBER(2)   | No       |     | Half centuries        | 5           |
| HUNDREDS        | NUMBER(2)   | No       |     | Centuries             | 1           |
| FOURS           | NUMBER(4)   | No       |     | Total fours           | 72          |
| SIXES           | NUMBER(4)   | No       |     | Total sixes           | 38          |
| WICKETS         | NUMBER(3)   | No       |     | Total wickets         | 2           |
| ECONOMY         | NUMBER(5,2) | Yes      |     | Bowling economy       | 7.42        |
| CREATED_DATE    | DATE        | No       |     | Record creation       | 01-JAN-2026 |
| UPDATED_DATE    | DATE        | Yes      |     | Last update           | 01-JAN-2026 |

### Business Rules

* One record per Player per Season.
* Statistics are generated automatically.
* Manual updates are not permitted.

---

# 7.2 TEAM_STATISTICS

## Purpose

Stores season-wise performance for every team.

### Table Definition

| Column         | Data Type   | Nullable | Key | Description           | Example     |
| -------------- | ----------- | -------- | --- | --------------------- | ----------- |
| TEAM_STAT_ID   | NUMBER(10)  | No       | PK  | Statistics identifier | 20001       |
| TEAM_ID        | NUMBER(10)  | No       | FK  | References TEAM       | 101         |
| SEASON_ID      | NUMBER(10)  | No       | FK  | References SEASON     | 2025        |
| MATCHES_PLAYED | NUMBER(3)   | No       |     | Total matches         | 14          |
| WINS           | NUMBER(3)   | No       |     | Matches won           | 10          |
| LOSSES         | NUMBER(3)   | No       |     | Matches lost          | 4           |
| TIES           | NUMBER(2)   | No       |     | Tied matches          | 0           |
| NO_RESULTS     | NUMBER(2)   | No       |     | Abandoned matches     | 0           |
| POINTS         | NUMBER(3)   | No       |     | League points         | 20          |
| NET_RUN_RATE   | NUMBER(6,3) | Yes      |     | NRR                   | 1.245       |
| RUNS_SCORED    | NUMBER(5)   | Yes      |     | Total runs scored     | 2854        |
| RUNS_CONCEDED  | NUMBER(5)   | Yes      |     | Total runs conceded   | 2611        |
| WICKETS_TAKEN  | NUMBER(4)   | Yes      |     | Wickets taken         | 98          |
| WICKETS_LOST   | NUMBER(4)   | Yes      |     | Wickets lost          | 76          |
| CREATED_DATE   | DATE        | No       |     | Record creation       | 01-JAN-2026 |
| UPDATED_DATE   | DATE        | Yes      |     | Last update           | 01-JAN-2026 |

### Business Rules

* One record per Team per Season.
* Points follow IPL rules.
* Net Run Rate is calculated automatically.

---

# 7.3 VENUE_STATISTICS

## Purpose

Stores aggregated statistics for every venue.

### Table Definition

| Column                 | Data Type   | Nullable | Key | Description                  | Example     |
| ---------------------- | ----------- | -------- | --- | ---------------------------- | ----------- |
| VENUE_STAT_ID          | NUMBER(10)  | No       | PK  | Statistics identifier        | 30001       |
| VENUE_ID               | NUMBER(10)  | No       | FK  | References VENUE             | 301         |
| SEASON_ID              | NUMBER(10)  | No       | FK  | References SEASON            | 2025        |
| MATCHES_HOSTED         | NUMBER(3)   | No       |     | Matches hosted               | 8           |
| HIGHEST_SCORE          | NUMBER(4)   | Yes      |     | Highest innings score        | 248         |
| LOWEST_SCORE           | NUMBER(4)   | Yes      |     | Lowest innings score         | 92          |
| AVERAGE_FIRST_INNINGS  | NUMBER(5,2) | Yes      |     | Average first innings score  | 181.42      |
| AVERAGE_SECOND_INNINGS | NUMBER(5,2) | Yes      |     | Average second innings score | 169.83      |
| TOTAL_SIXES            | NUMBER(5)   | Yes      |     | Sixes hit                    | 214         |
| TOTAL_FOURS            | NUMBER(5)   | Yes      |     | Fours hit                    | 487         |
| CREATED_DATE           | DATE        | No       |     | Record creation              | 01-JAN-2026 |
| UPDATED_DATE           | DATE        | Yes      |     | Last update                  | 01-JAN-2026 |

### Business Rules

* One record per Venue per Season.
* Statistics are refreshed after every completed match.

---

# 7.4 POINTS_TABLE

## Purpose

Represents the official tournament standings.

### Table Definition

| Column          | Data Type   | Nullable | Key | Description       | Example     |
| --------------- | ----------- | -------- | --- | ----------------- | ----------- |
| POINTS_TABLE_ID | NUMBER(10)  | No       | PK  | Identifier        | 40001       |
| SEASON_ID       | NUMBER(10)  | No       | FK  | References SEASON | 2025        |
| TEAM_ID         | NUMBER(10)  | No       | FK  | References TEAM   | 101         |
| POSITION        | NUMBER(2)   | No       |     | League rank       | 1           |
| MATCHES         | NUMBER(3)   | No       |     | Matches played    | 14          |
| WINS            | NUMBER(3)   | No       |     | Wins              | 10          |
| LOSSES          | NUMBER(3)   | No       |     | Losses            | 4           |
| NO_RESULTS      | NUMBER(2)   | No       |     | No Results        | 0           |
| POINTS          | NUMBER(3)   | No       |     | Total points      | 20          |
| NET_RUN_RATE    | NUMBER(6,3) | Yes      |     | Net Run Rate      | 1.245       |
| QUALIFIED_FLAG  | CHAR(1)     | No       |     | Y / N             | Y           |
| CREATED_DATE    | DATE        | No       |     | Record creation   | 01-JAN-2026 |

### Business Rules

* One record per Team per Season.
* Position is determined by Points and Net Run Rate.
* Qualified Flag accepts only Y or N.

---

# 7.5 Design Notes

The analytical entities are **not** manually maintained.

They are populated through scheduled PL/SQL packages after every ETL cycle.

Example workflow:

```text
Raw Match Data
       │
       ▼
Python ETL
       │
       ▼
Oracle Transaction Tables
       │
       ▼
PL/SQL Aggregation Packages
       │
       ▼
Analytical Tables
       │
       ▼
Power BI / FastAPI
```

This architecture separates operational processing from reporting, improving performance and maintainability.

---

# 8. Operational Entities

Operational entities help monitor and maintain the platform.

They are not part of cricket statistics but are essential for production-grade systems.

---

# 8.1 ETL_JOB

## Purpose

Tracks every ETL execution.

### Table Definition

| Column             | Data Type     | Nullable | Key | Description                | Example           |
| ------------------ | ------------- | -------- | --- | -------------------------- | ----------------- |
| JOB_ID             | NUMBER(10)    | No       | PK  | Job identifier             | 501               |
| JOB_NAME           | VARCHAR2(100) | No       |     | ETL job name               | Load IPL Matches  |
| START_TIMESTAMP    | TIMESTAMP     | No       |     | Job start time             | 01-JAN-2026 10:00 |
| END_TIMESTAMP      | TIMESTAMP     | Yes      |     | Job completion             | 01-JAN-2026 10:03 |
| STATUS             | VARCHAR2(20)  | No       |     | SUCCESS / FAILED / RUNNING | SUCCESS           |
| RECORDS_READ       | NUMBER(10)    | Yes      |     | Input records              | 200000            |
| RECORDS_INSERTED   | NUMBER(10)    | Yes      |     | Rows inserted              | 199850            |
| RECORDS_UPDATED    | NUMBER(10)    | Yes      |     | Rows updated               | 120               |
| RECORDS_REJECTED   | NUMBER(10)    | Yes      |     | Invalid rows               | 30                |
| EXECUTION_TIME_SEC | NUMBER(8,2)   | Yes      |     | Runtime                    | 182.45            |
| CREATED_DATE       | DATE          | No       |     | Log creation               | 01-JAN-2026       |

### Business Rules

* Every ETL execution creates one record.
* Status must be SUCCESS, FAILED, or RUNNING.

---

# 8.2 ERROR_LOG

## Purpose

Captures all validation and processing errors.

### Table Definition

| Column          | Data Type     | Nullable | Key | Description         | Example           |
| --------------- | ------------- | -------- | --- | ------------------- | ----------------- |
| ERROR_ID        | NUMBER(12)    | No       | PK  | Error identifier    | 90001             |
| JOB_ID          | NUMBER(10)    | No       | FK  | References ETL_JOB  | 501               |
| SOURCE_FILE     | VARCHAR2(200) | Yes      |     | Input file          | deliveries.csv    |
| ERROR_TYPE      | VARCHAR2(100) | No       |     | Validation category | Invalid Team      |
| ERROR_MESSAGE   | VARCHAR2(500) | No       |     | Detailed message    | Team ID not found |
| RECORD_NUMBER   | NUMBER(10)    | Yes      |     | Source row          | 15322             |
| ERROR_TIMESTAMP | TIMESTAMP     | No       |     | Error time          | 01-JAN-2026 10:01 |
| RESOLVED_FLAG   | CHAR(1)       | No       |     | Y / N               | N                 |

### Business Rules

* Every error must belong to an ETL Job.
* Error logs are retained for auditing.
* Resolved Flag accepts only Y or N.

---

# 8.3 Summary

The analytical and operational entities complete the logical data model of the IPL Data Engineering Platform.

Analytical tables provide fast access to aggregated statistics required by dashboards and APIs, while operational tables enable monitoring, troubleshooting, and auditing of ETL processes.

The next section of this document defines the platform-wide standards, validation rules, naming conventions, audit strategy, and appendix information used throughout the database.

# 9. Common Standards & Validation Rules

This section defines the common standards that apply across all database objects in the IPL Data Engineering Platform. These standards ensure consistency, maintainability, and data integrity.

---

## 9.1 Primary Key Standards

Every table shall contain a single-column primary key.

### Naming Convention

```text
<TABLE_NAME>_ID
```

### Examples

| Table       | Primary Key    |
| ----------- | -------------- |
| COMPETITION | COMPETITION_ID |
| SEASON      | SEASON_ID      |
| TEAM        | TEAM_ID        |
| PLAYER      | PLAYER_ID      |
| MATCH       | MATCH_ID       |
| DELIVERY    | DELIVERY_ID    |

### Standards

* Primary keys cannot be NULL.
* Primary keys must be unique.
* Oracle NUMBER data type will be used.
* Values will be generated using Oracle Sequences (or Identity Columns where appropriate).

---

## 9.2 Foreign Key Standards

Foreign keys enforce relationships between parent and child tables.

### Example

```text
MATCH.SEASON_ID
        │
        ▼
SEASON.SEASON_ID
```

### Standards

* Every foreign key must reference an existing parent record.
* Orphan records are not permitted.
* Foreign key columns should be indexed where beneficial for performance.

---

## 9.3 Naming Conventions

| Object     | Convention         | Example          |
| ---------- | ------------------ | ---------------- |
| Tables     | UPPERCASE Singular | PLAYER           |
| Views      | Prefix `VW_`       | VW_PLAYER_STATS  |
| Sequences  | Prefix `SEQ_`      | SEQ_MATCH        |
| Packages   | Prefix `PKG_`      | PKG_MATCH        |
| Procedures | Prefix `PR_`       | PR_LOAD_MATCHES  |
| Functions  | Prefix `FN_`       | FN_CALCULATE_NRR |
| Triggers   | Prefix `TRG_`      | TRG_PLAYER_AUDIT |
| Indexes    | Prefix `IDX_`      | IDX_MATCH_DATE   |

---

## 9.4 Audit Standards

Most transactional and master tables should include common audit columns.

| Column       | Data Type | Purpose                |
| ------------ | --------- | ---------------------- |
| CREATED_DATE | DATE      | Record creation date   |
| UPDATED_DATE | DATE      | Last modification date |

Future enhancements may include:

* CREATED_BY
* UPDATED_BY
* VERSION_NUMBER
* ROW_STATUS

to support enterprise auditing and optimistic locking.

---

## 9.5 Validation Rules

The following validations should be enforced using Oracle constraints and PL/SQL.

### Entity Validation

* Competition names must be unique.
* Team names must be unique.
* Venue names must be unique.
* Player names cannot be NULL.

### Match Validation

* Team 1 and Team 2 must be different.
* Match date must fall within the season.
* Winner must be one of the participating teams.

### Innings Validation

* Batting team and bowling team cannot be the same.
* Innings must belong to a valid match.

### Delivery Validation

* Over number must be positive.
* Ball number must be between 1 and 6 for legal deliveries.
* Total runs must equal batter runs plus extra runs.
* Batter and non-striker cannot be the same player.

### Wicket Validation

* A wicket cannot exist without a delivery.
* Dismissal type must be valid.

### Statistics Validation

* Statistics cannot be manually modified.
* Aggregated tables are refreshed by scheduled jobs.

---

## 9.6 Data Quality Rules

The ETL pipeline should perform the following checks before loading data.

* Mandatory fields cannot be NULL.
* Duplicate primary keys must be rejected.
* Invalid foreign keys must be rejected.
* Dates must use valid Oracle DATE formats.
* Numeric fields cannot contain alphabetic characters.
* Negative scores are not permitted.
* Duplicate matches should not be loaded.

Any failed validation should be recorded in the ERROR_LOG table.

---

## 9.7 Performance Guidelines

The database design follows normalization principles while considering query performance.

Guidelines include:

* Normalize master and transaction tables to Third Normal Form (3NF).
* Create indexes on frequently searched columns.
* Avoid storing derived values in transactional tables.
* Use analytical tables for reporting.
* Use PL/SQL bulk processing (`BULK COLLECT`, `FORALL`) for high-volume data loads.
* Gather optimizer statistics after major data loads.

---

# 10. Appendix

---

## 10.1 Abbreviations

| Abbreviation | Meaning                           |
| ------------ | --------------------------------- |
| IPL          | Indian Premier League             |
| ETL          | Extract, Transform, Load          |
| PK           | Primary Key                       |
| FK           | Foreign Key                       |
| API          | Application Programming Interface |
| NRR          | Net Run Rate                      |
| BI           | Business Intelligence             |

---

## 10.2 Recommended Oracle Data Types

| Data Type   | Usage                            |
| ----------- | -------------------------------- |
| NUMBER      | IDs, counts, scores              |
| NUMBER(p,s) | Averages, rates, monetary values |
| VARCHAR2    | Text fields                      |
| DATE        | Calendar dates                   |
| TIMESTAMP   | Date and time with precision     |
| CHAR(1)     | Boolean flags (`Y` / `N`)        |

---

## 10.3 Audit Columns

The following columns are recommended for all master and transaction tables.

| Column       | Purpose              |
| ------------ | -------------------- |
| CREATED_DATE | Record creation date |
| UPDATED_DATE | Last update date     |

Optional enterprise columns:

* CREATED_BY
* UPDATED_BY
* VERSION_NUMBER
* ROW_STATUS

---

## 10.4 Future Enhancements

The current schema is designed to be extensible.

Potential future additions include:

* Ball tracking data
* Player injury records
* Live score ingestion
* Fantasy cricket metrics
* Sponsorship information
* Match officials assignment
* Weather data integration
* Ticket sales analysis
* Machine learning prediction tables
* Historical archive tables

---

# 11. Change Log

| Version | Date        | Author         | Description                                                                                                 |
| ------- | ----------- | -------------- | ----------------------------------------------------------------------------------------------------------- |
| 1.0     | August 2026 | Risham Venghat | Initial creation of the Data Dictionary covering master, transaction, analytical, and operational entities. |

---

# 12. Conclusion

The Data Dictionary is the authoritative reference for the IPL Data Engineering Platform database. It defines the structure, standards, and validation rules for every entity used throughout the system.

Together with the **Business Domain Analysis** and **Entity Definitions** documents, this dictionary provides the foundation for:

* Oracle database schema creation
* PL/SQL package and procedure development
* Python ETL implementation
* FastAPI service development
* Power BI dashboard creation
* Future enhancements and maintenance

Any schema changes should be reflected in this document to ensure the database design, application code, and project documentation remain synchronized.
