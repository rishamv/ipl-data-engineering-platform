# Relationship Notes

## IPL Data Engineering Platform

**Version:** 1.0

**Prepared By:** Risham Venghat

**Last Updated:** August 2026

---

# 1. Purpose

This document describes the relationships between entities in the IPL Data Engineering Platform database.

It explains:

* Entity relationships
* Cardinality
* Foreign key implementation
* Normalization decisions
* Design rationale
* Referential integrity
* Cascade behavior
* Indexing strategy

This document complements the **Business Domain Analysis**, **Entity Definitions**, and **Data Dictionary**.

---

# 2. Relationship Overview

The database consists of four categories of entities:

* Master Entities
* Transaction Entities
* Analytical Entities
* Operational Entities

Master entities provide reference data, transaction entities capture match events, analytical entities store aggregated statistics, and operational entities support ETL monitoring and auditing.

---

# 3. Entity Relationship Summary

| Parent Entity | Child Entity        | Relationship    |
| ------------- | ------------------- | --------------- |
| Competition   | Season              | One-to-Many     |
| Competition   | Team                | One-to-Many     |
| Season        | Match               | One-to-Many     |
| Season        | Player Team History | One-to-Many     |
| Season        | Player Statistics   | One-to-Many     |
| Season        | Team Statistics     | One-to-Many     |
| Season        | Venue Statistics    | One-to-Many     |
| Season        | Points Table        | One-to-Many     |
| Team          | Player Team History | One-to-Many     |
| Venue         | Match               | One-to-Many     |
| Match         | Innings             | One-to-Many     |
| Innings       | Delivery            | One-to-Many     |
| Delivery      | Wicket              | One-to-Zero/One |
| Player        | Player Team History | One-to-Many     |
| Player        | Player Statistics   | One-to-Many     |
| ETL Job       | Error Log           | One-to-Many     |

---

# 4. Relationship Details

---

## 4.1 Competition → Season

### Cardinality

One Competition can contain many Seasons.

One Season belongs to exactly one Competition.

### Business Reason

Although this project currently supports only the IPL, introducing the Competition entity makes the platform extensible for future tournaments such as:

* Women's Premier League
* Champions League T20
* Big Bash League
* International tournaments

### Foreign Key

```text
SEASON.COMPETITION_ID
```

---

## 4.2 Competition → Team

### Cardinality

One Competition has many Teams.

### Business Reason

Every franchise participates in a competition.

Future versions could support multiple competitions while keeping the same database structure.

---

## 4.3 Season → Match

### Cardinality

One Season contains many Matches.

Every Match belongs to exactly one Season.

### Foreign Key

```text
MATCH.SEASON_ID
```

### Example

```text
IPL 2025

├── Match 1

├── Match 2

├── Match 3

└── Match 74
```

---

## 4.4 Venue → Match

### Cardinality

One Venue hosts many Matches.

A Match is played at only one Venue.

### Foreign Key

```text
MATCH.VENUE_ID
```

---

## 4.5 Match → Innings

### Cardinality

One Match contains multiple Innings.

Normally:

* Innings 1
* Innings 2

However, the design supports additional innings for future flexibility.

### Foreign Key

```text
INNINGS.MATCH_ID
```

---

## 4.6 Innings → Delivery

### Cardinality

One Innings contains many Deliveries.

Each Delivery belongs to one Innings.

### Foreign Key

```text
DELIVERY.INNINGS_ID
```

### Design Reason

Every cricket event eventually traces back to a single delivery.

Examples:

* Runs
* Wickets
* Extras
* Boundaries

---

## 4.7 Delivery → Wicket

### Cardinality

One Delivery may produce one Wicket.

Some deliveries produce no wicket.

### Relationship

```text
Delivery

│

├── No Wicket

└── Wicket
```

### Foreign Key

```text
WICKET.DELIVERY_ID
```

---

## 4.8 Player → Player Team History

### Cardinality

One Player has many team history records.

### Why not store TEAM_ID in PLAYER?

A player may represent different franchises across seasons.

Example:

| Season   | Team |
| -------- | ---- |
| IPL 2022 | RCB  |
| IPL 2023 | RCB  |
| IPL 2024 | GT   |

Using Player Team History preserves historical accuracy.

---

## 4.9 Player Team History → Team

Many Player Team History records reference one Team.

This resolves the many-to-many relationship between Players and Teams.

---

## 4.10 Player Team History → Season

Each Player Team History record belongs to one Season.

This allows player transfers to be tracked accurately.

---

## 4.11 Player → Player Statistics

One Player can have multiple statistical records.

Example:

| Player      | Season   |
| ----------- | -------- |
| Virat Kohli | IPL 2023 |
| Virat Kohli | IPL 2024 |
| Virat Kohli | IPL 2025 |

---

## 4.12 Team → Team Statistics

One Team has one statistical record per Season.

Statistics are regenerated after every completed match.

---

## 4.13 Venue → Venue Statistics

One Venue stores season-specific statistics.

Examples:

* Highest Score
* Lowest Score
* Average First Innings Score

---

## 4.14 Season → Points Table

Each Season contains one Points Table record per Team.

Standings are recalculated automatically after every completed match.

---

## 4.15 ETL Job → Error Log

Every ETL execution may generate multiple validation errors.

Example:

```text
ETL Job

├── Error 1

├── Error 2

└── Error 3
```

This relationship allows all processing errors to be traced back to a specific ETL run.

---

# 5. Many-to-Many Relationships

The conceptual model contains one significant many-to-many relationship.

## Player ↔ Team

Without an intermediate table:

```text
Player

⇄

Team
```

This is not supported directly in a relational database.

Instead:

```text
Player

↓

Player Team History

↑

Team
```

This bridge entity enables:

* Historical reporting
* Team transfers
* Season-based assignments

---

# 6. Normalization

The schema has been designed to satisfy **Third Normal Form (3NF)**.

---

## First Normal Form (1NF)

Requirements:

* No repeating groups.
* Atomic values.
* Unique rows.

Example:

Each Delivery represents exactly one ball.

---

## Second Normal Form (2NF)

Requirements:

* All non-key attributes depend on the entire primary key.

Example:

Venue information is stored in the VENUE table instead of MATCH.

---

## Third Normal Form (3NF)

Requirements:

* No transitive dependencies.

Example:

Player nationality is stored in PLAYER rather than repeated in MATCH or DELIVERY.

Benefits include:

* Reduced redundancy
* Improved consistency
* Easier maintenance

---

# 7. Referential Integrity

Foreign key constraints ensure that child records always reference valid parent records.

Examples:

* MATCH must reference an existing SEASON.
* DELIVERY must reference an existing INNINGS.
* WICKET must reference an existing DELIVERY.

Invalid references will be rejected by the database.

---

# 8. Cascade Strategy

The platform follows a conservative deletion strategy.

| Parent      | Child    | Action          |
| ----------- | -------- | --------------- |
| Competition | Season   | Restrict Delete |
| Season      | Match    | Restrict Delete |
| Match       | Innings  | Restrict Delete |
| Innings     | Delivery | Restrict Delete |
| Delivery    | Wicket   | Restrict Delete |

### Why Restrict Delete?

Historical cricket data should never be removed accidentally.

If data must be archived, it should be moved to archive tables rather than deleted.

---

# 9. Indexing Strategy

Indexes improve query performance.

Recommended indexes include:

| Table               | Index                |
| ------------------- | -------------------- |
| MATCH               | MATCH_DATE           |
| MATCH               | SEASON_ID            |
| MATCH               | VENUE_ID             |
| DELIVERY            | MATCH_ID             |
| DELIVERY            | INNINGS_ID           |
| DELIVERY            | BATTER_ID            |
| DELIVERY            | BOWLER_ID            |
| PLAYER_TEAM_HISTORY | PLAYER_ID            |
| PLAYER_TEAM_HISTORY | TEAM_ID              |
| PLAYER_STATISTICS   | PLAYER_ID, SEASON_ID |

Additional indexes may be introduced after analyzing query execution plans.

---

# 10. Design Decisions

The following design decisions were made during database modeling.

### Competition Entity

Included for future extensibility.

---

### Player Team History

Introduced to preserve historical team assignments.

---

### Analytical Tables

Separate tables improve reporting performance by avoiding repeated aggregations.

---

### Operational Tables

ETL_JOB and ERROR_LOG support monitoring, auditing, and troubleshooting.

---

### Audit Columns

Common audit fields (CREATED_DATE and UPDATED_DATE) are included in most entities to support future governance requirements.

---

# 11. Future Relationship Enhancements

Future releases may introduce additional entities and relationships, including:

* Coach
* Sponsor
* Umpire Assignment
* Weather
* Broadcast Information
* Ticket Sales
* Fan Engagement
* Injury Reports
* Ball Tracking
* Fantasy Cricket

These can be added without major structural changes due to the modular design.

---

# 12. Conclusion

The IPL Data Engineering Platform uses a normalized relational model with clearly defined relationships, strong referential integrity, and extensibility for future enhancements.

The chosen design minimizes data redundancy, preserves historical accuracy, and supports efficient ETL processing, PL/SQL business logic, REST APIs, and reporting through analytical tables.

This document should be reviewed whenever new entities or relationships are introduced to ensure the logical data model remains consistent across the application.
