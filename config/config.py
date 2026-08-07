"""
Project Configuration

This module contains all project paths and configuration constants.
"""

from pathlib import Path

# -------------------------------------------------------
# Project Root
# -------------------------------------------------------

PROJECT_DIR = Path(__file__).resolve().parent.parent

# -------------------------------------------------------
# Data Directories
# -------------------------------------------------------

DATA_DIR = PROJECT_DIR / "data"

RAW_DIR = DATA_DIR / "raw"

PROCESSED_DIR = DATA_DIR / "processed"

OUTPUT_DIR = DATA_DIR / "output"

# -------------------------------------------------------
# Database Directories
# -------------------------------------------------------

DATABASE_DIR = PROJECT_DIR / "database"

DDL_DIR = DATABASE_DIR / "ddl"

DML_DIR = DATABASE_DIR / "dml"

SAMPLE_DATA_DIR = DATABASE_DIR / "sample_data"

# -------------------------------------------------------
# Log Directory
# -------------------------------------------------------

LOG_DIR = PROJECT_DIR / "logs"

# -------------------------------------------------------
# Source Files
# -------------------------------------------------------

MATCHES_FILE = RAW_DIR / "matches.csv"

DELIVERIES_FILE = RAW_DIR / "deliveries.csv"