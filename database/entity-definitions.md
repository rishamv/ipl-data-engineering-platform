# Entity Definitions

## IPL Data Engineering Platform

**Version:** 1.0

**Prepared By:** Risham Venghat

---

# 1. Purpose

This document defines all business entities used in the IPL Data Engineering Platform. It serves as the foundation for database design, PL/SQL development, ETL implementation, API development, and reporting.

Each entity represents a real-world business object that the system needs to store or process.

---

# 2. Entity Classification

The entities are grouped into four categories.

| Category             | Description                                    |
| -------------------- | ---------------------------------------------- |
| Master Entities      | Core reference data that changes infrequently. |
| Transaction Entities | Events generated during IPL matches.           |
| Analytical Entities  | Calculated statistics and rankings.            |
| Operational Entities | Data used for ETL and system monitoring.       |

---

# 3. Master Entities

Master entities contain relatively stable data and are referenced by other entities.

---

## 3.1 Competition

### Purpose

Represents a cricket tournament.

Although Version 1 focuses on the Indian Premier League (IPL), introducing this entity allows the platform to support additional competitions in the future (e.g., Women's Premier League or other T20 leagues).

### Business Example

| Competition ID | Competition Name      |
| -------------- | --------------------- |
| 1              | Indian Premier League |

### Primary Attributes

* Competition ID
* Competition Name
* Country
* Governing Body
* Start Year

### Relationships

* One Competition contains many Seasons.

### Business Rules

* Every Season must belong to one Competition.
* Competition names must be unique.

---

## 3.2 Season

### Purpose

Represents one edition of a competition.

Example:

* IPL 2023
* IPL 2024
* IPL 2025

### Primary Attributes

* Season ID
* Competition ID
* Season Name
* Start Date
* End Date

### Relationships

* One Competition has many Seasons.
* One Season has many Matches.

### Business Rules

* A Season belongs to exactly one Competition.
* Start Date must be earlier than End Date.

---

## 3.3 Team

### Purpose

Stores information about IPL franchises.

### Examples

* Chennai Super Kings
* Mumbai Indians
* Royal Challengers Bengaluru
* Rajasthan Royals

### Primary Attributes

* Team ID
* Team Name
* Short Name
* Home City
* Founded Year

### Relationships

* One Team participates in many Matches.
* One Team has many Players through Player Team History.

### Business Rules

* Team names must be unique.
* Short names must be unique.
* Every Team belongs to one Competition.

---

## 3.4 Player

### Purpose

Stores player information.

### Examples

* Virat Kohli
* Jasprit Bumrah
* MS Dhoni

### Primary Attributes

* Player ID
* Full Name
* Date of Birth
* Nationality
* Batting Style
* Bowling Style
* Primary Role

### Relationships

* One Player may represent different Teams over different Seasons.
* One Player appears in many Deliveries.
* One Player accumulates many statistics.

### Business Rules

* A Player should exist only once in the database.
* Team changes must be tracked using Player Team History instead of updating the Player record.

---

## 3.5 Player Team History

### Purpose

Tracks the teams represented by a player across seasons.

### Why This Entity Exists

Players can move between franchises.

Example:

* Player A plays for Team X in IPL 2023.
* The same Player joins Team Y in IPL 2025.

Without this entity, historical reports would become inaccurate.

### Primary Attributes

* History ID
* Player ID
* Team ID
* Season ID
* Start Date
* End Date

### Relationships

* Many records belong to one Player.
* Many records belong to one Team.
* Many records belong to one Season.

### Business Rules

* A Player cannot belong to multiple teams within the same season unless explicitly supported by business rules.
* Historical records should never be deleted.

---

## 3.6 Venue

### Purpose

Stores stadium information.

### Examples

* Wankhede Stadium
* Eden Gardens
* M. A. Chidambaram Stadium

### Primary Attributes

* Venue ID
* Venue Name
* City
* State
* Country
* Capacity

### Relationships

* One Venue hosts many Matches.

### Business Rules

* Venue names should be unique.

---

## 3.7 Umpire

### Purpose

Stores umpire information.

### Primary Attributes

* Umpire ID
* Full Name
* Nationality

### Relationships

* One Umpire can officiate multiple Matches.

### Business Rules

* An umpire may officiate many matches in different seasons.

---

# 4. Transaction Entities

These entities capture match activity.

---

## 4.1 Match

### Purpose

Represents one IPL fixture.

### Primary Attributes

* Match ID
* Season ID
* Match Date
* Venue ID
* Team 1 ID
* Team 2 ID
* Toss Winner
* Toss Decision
* Match Winner
* Player of the Match

### Relationships

* One Match belongs to one Season.
* One Match is played at one Venue.
* One Match has two Innings.

### Business Rules

* Team 1 and Team 2 must be different.
* Every Match belongs to exactly one Season.

---

## 4.2 Innings

### Purpose

Represents one innings within a match.

### Primary Attributes

* Innings ID
* Match ID
* Batting Team
* Bowling Team
* Total Runs
* Total Wickets
* Overs Played

### Relationships

* One Match has multiple Innings.
* One Innings contains many Deliveries.

### Business Rules

* An innings must belong to one Match.

---

## 4.3 Delivery

### Purpose

Represents every legal or illegal ball bowled.

This is the largest transactional entity.

### Primary Attributes

* Delivery ID
* Match ID
* Innings ID
* Over Number
* Ball Number
* Batter
* Bowler
* Non-Striker
* Runs Scored
* Extras
* Total Runs

### Relationships

* One Delivery belongs to one Match.
* One Delivery belongs to one Innings.
* One Delivery may produce one Wicket.

### Business Rules

* Every Delivery belongs to exactly one Innings.
* Ball numbers must follow cricket rules.

---

## 4.4 Wicket

### Purpose

Stores dismissal events.

### Primary Attributes

* Wicket ID
* Delivery ID
* Player Out
* Dismissal Type
* Fielder

### Relationships

* One Wicket belongs to one Delivery.

### Business Rules

* A Delivery may have zero or one Wicket.

---

# 5. Analytical Entities

These entities contain calculated information.

---

## 5.1 Player Statistics

### Purpose

Stores season-wise player performance.

### Examples

* Runs
* Strike Rate
* Average
* Boundaries
* Wickets
* Economy

### Relationships

* One Player has many statistical records.

### Business Rules

* Statistics should be generated from transactional data.

---

## 5.2 Team Statistics

### Purpose

Stores aggregated team performance.

### Examples

* Matches Played
* Wins
* Losses
* Win Percentage
* Net Run Rate

### Relationships

* One Team has many season-wise statistics.

### Business Rules

* Values should be calculated automatically.

---

## 5.3 Venue Statistics

### Purpose

Stores venue-level analytics.

### Examples

* Average First Innings Score
* Highest Score
* Lowest Score
* Matches Hosted

---

## 5.4 Points Table

### Purpose

Represents tournament standings.

### Attributes

* Team
* Season
* Matches
* Wins
* Losses
* Points
* Net Run Rate
* Position

### Business Rules

* Generated after each completed match.

---

# 6. Operational Entities

---

## 6.1 ETL Job

### Purpose

Tracks every ETL execution.

### Attributes

* Job ID
* Job Name
* Start Time
* End Time
* Status
* Records Processed
* Records Failed

### Business Rules

* Every execution should be logged.

---

## 6.2 Error Log

### Purpose

Stores validation failures.

### Examples

* Invalid Team
* Duplicate Match
* Missing Player
* Invalid Venue

### Attributes

* Error ID
* Job ID
* Error Type
* Error Message
* Source File
* Timestamp

### Business Rules

* Errors should never stop the entire ETL process.
* Every validation failure must be recorded.

---

# 7. Entity Summary

| Category    | Entities                                                              |
| ----------- | --------------------------------------------------------------------- |
| Master      | Competition, Season, Team, Player, Player Team History, Venue, Umpire |
| Transaction | Match, Innings, Delivery, Wicket                                      |
| Analytical  | Player Statistics, Team Statistics, Venue Statistics, Points Table    |
| Operational | ETL Job, Error Log                                                    |

---

# 8. Conclusion

The entities defined in this document form the conceptual data model for the IPL Data Engineering Platform. They have been identified based on business requirements rather than technical implementation details. In subsequent phases of the project, these entities will be transformed into normalized Oracle database tables with primary keys, foreign keys, constraints, and PL/SQL business logic.

This document serves as the primary reference for database schema creation, ETL development, API design, reporting, and future system enhancements.
