# IPL Data Engineering Platform

## Business Domain Analysis Document

**Project Name:** IPL Data Engineering Platform

**Version:** 1.0

**Prepared By:** Risham Venghat

**Date:** August 2026

---

# 1. Introduction

The Indian Premier League (IPL) is one of the world's largest professional T20 cricket tournaments. Every season generates a significant amount of structured and semi-structured data, including information about teams, players, matches, ball-by-ball events, venues, and tournament statistics.

Sports analytics companies, broadcasters, fantasy sports platforms, and cricket analysts use this data to generate insights, reports, and visualizations.

The objective of this project is to design and build an end-to-end data engineering platform that automates the collection, storage, validation, analysis, and visualization of IPL data using Oracle PL/SQL and modern data engineering technologies.

---

# 2. Business Problem

Currently, IPL data is available from multiple sources such as CSV datasets and cricket APIs. Analysts often spend considerable time downloading, cleaning, transforming, and combining this data before meaningful analysis can begin.

Common challenges include:

* Manual data collection.
* Duplicate records.
* Data quality issues.
* Inconsistent formats across seasons.
* Difficulty generating historical reports.
* Lack of centralized storage.
* Limited automation.

These issues reduce productivity and increase the possibility of reporting errors.

---

# 3. Proposed Solution

Develop an automated IPL Data Engineering Platform capable of:

* Collecting IPL match data.
* Validating incoming data.
* Storing data in an Oracle relational database.
* Applying business rules using PL/SQL.
* Exposing processed data through REST APIs.
* Displaying analytics using interactive dashboards.

The platform should minimize manual intervention and provide a reliable foundation for cricket analytics.

---

# 4. Business Objectives

The primary objectives of the system are:

* Automate IPL data ingestion.
* Maintain high-quality validated data.
* Store historical IPL records.
* Support analytical queries.
* Generate player and team statistics.
* Enable dashboard reporting.
* Demonstrate a complete end-to-end data engineering solution.

---

# 5. Business Process Overview

The overall business workflow is illustrated below.

```
IPL Match Played
        │
        ▼
Match Data Generated
        │
        ▼
Data Collected from Dataset/API
        │
        ▼
Python ETL Process
        │
        ▼
Oracle Staging Tables
        │
        ▼
PL/SQL Validation
        │
        ▼
Production Database
        │
        ▼
REST API
        │
        ▼
Dashboard & Reports
```

---

# 6. Understanding the IPL Domain

An IPL season consists of multiple teams competing in scheduled matches across various venues.

Each match generates numerous events including:

* Toss
* Innings
* Overs
* Deliveries
* Runs
* Extras
* Wickets
* Match result

Every event contributes to player statistics and tournament standings.

---

# 7. Types of Business Data

## 7.1 Master Data

Master data changes infrequently and serves as reference information throughout the system.

Examples include:

* Competition
* Season
* Team
* Player
* Venue
* Umpire

Characteristics:

* Stable
* Reusable
* Shared across multiple transactions

---

## 7.2 Transaction Data

Transaction data represents events occurring during the tournament.

Examples include:

* Match
* Innings
* Ball-by-ball delivery
* Wicket
* Extras
* Toss
* Player performance

Characteristics:

* Generated continuously
* Large in volume
* Historical

---

## 7.3 Analytical Data

Analytical data is calculated from transactional data.

Examples include:

* Orange Cap standings
* Purple Cap standings
* Strike rate
* Economy rate
* Team rankings
* Venue statistics
* Season summaries

This information should be generated automatically rather than manually entered.

---

## 7.4 System Data

System data supports platform operations.

Examples include:

* ETL execution logs
* Error logs
* Audit records
* API request logs

---

# 8. Business Workflow

The system follows the lifecycle below.

```
Season Created
      │
      ▼
Teams Registered
      │
      ▼
Players Assigned
      │
      ▼
Match Scheduled
      │
      ▼
Match Played
      │
      ▼
Ball-by-Ball Events Recorded
      │
      ▼
Statistics Calculated
      │
      ▼
Reports Generated
```

---

# 9. Stakeholders

The platform serves multiple business users.

| Stakeholder            | Responsibility                            |
| ---------------------- | ----------------------------------------- |
| Data Engineer          | Build and maintain ETL pipelines          |
| Database Developer     | Design Oracle schema and PL/SQL logic     |
| Database Administrator | Manage Oracle database                    |
| Data Analyst           | Generate analytical reports               |
| Cricket Analyst        | Analyze player and team performance       |
| Dashboard User         | View visual reports                       |
| API Consumer           | Consume statistical data programmatically |

---

# 10. Business Questions

The platform should be capable of answering questions such as:

* Which player scored the most runs in a season?
* Which bowler has the highest wicket count?
* Which venue has the highest average first innings score?
* Which team has the best win percentage?
* Which players consistently perform against specific opponents?
* Which bowler dismisses a particular batsman most often?
* Which venue produces the highest number of sixes?
* How many matches were decided in the final over?

These questions guide the database design and future analytics.

---

# 11. Data Sources

Version 1 of the project will use historical IPL datasets.

Primary dataset:

* matches.csv
* deliveries.csv

Future versions may integrate live cricket APIs for automated data ingestion.

---

# 12. Scope

## Included

* Historical IPL seasons
* Teams
* Players
* Venues
* Matches
* Innings
* Ball-by-ball data
* ETL pipeline
* Oracle database
* PL/SQL validation
* REST APIs
* Dashboard reporting

---

## Excluded

* Live score streaming
* User authentication
* Fantasy cricket management
* Betting functionality
* Mobile applications
* Real-time notifications

These features may be considered in future enhancements.

---

# 13. Technology Stack

| Layer            | Technology         |
| ---------------- | ------------------ |
| Database         | Oracle Database XE |
| Programming      | Oracle PL/SQL      |
| ETL              | Python             |
| API              | FastAPI            |
| Dashboard        | Power BI           |
| Version Control  | Git                |
| Repository       | GitHub             |
| Containerization | Docker             |

---

# 14. Expected Deliverables

At the completion of the project, the platform should include:

* Oracle database schema
* Normalized relational tables
* PL/SQL packages and procedures
* Automated Python ETL pipeline
* REST API layer
* Interactive Power BI dashboard
* Complete project documentation
* GitHub repository with version history

---

# 15. Conclusion

This project is designed to simulate a real-world enterprise data engineering solution using IPL cricket data. By combining Oracle PL/SQL, Python, FastAPI, Docker, Power BI, Git, and GitHub, the platform demonstrates the complete lifecycle of a modern data engineering project—from data ingestion and validation to analytics and visualization.

The Business Domain Analysis serves as the foundation for the subsequent phases of the project, including database design, schema modeling, ETL development, API implementation, dashboard creation, testing, deployment, and documentation.
