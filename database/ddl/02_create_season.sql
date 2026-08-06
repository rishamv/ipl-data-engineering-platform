/******************************************************************************
 * File Name   : 02_create_season.sql
 * Project     : IPL Data Engineering Platform
 * Module      : Database DDL
 * Author      : Risham
 * Description : Creates the SEASON master table.
 *
 * Business Purpose:
 * Stores each season belonging to a competition.
 *
 * Dependencies:
 * COMPETITION
 ******************************************************************************/

CREATE TABLE SEASON
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    SEASON_ID              NUMBER(10)                 NOT NULL,

    --------------------------------------------------------------------------
    -- Foreign Key
    --------------------------------------------------------------------------
    COMPETITION_ID         NUMBER(10)                 NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    SEASON_YEAR            NUMBER(4)                  NOT NULL,
    SEASON_NAME            VARCHAR2(50)               NOT NULL,

    START_DATE             DATE                       NOT NULL,
    END_DATE               DATE                       NOT NULL,

    TOTAL_MATCHES          NUMBER(3)                  DEFAULT 0 NOT NULL,

    STATUS                 VARCHAR2(20)
                            DEFAULT 'UPCOMING'
                            NOT NULL,

    --------------------------------------------------------------------------
    -- Audit Columns
    --------------------------------------------------------------------------
    CREATED_BY             VARCHAR2(50)
                            DEFAULT USER
                            NOT NULL,

    CREATED_DATE           TIMESTAMP
                            DEFAULT SYSTIMESTAMP
                            NOT NULL,

    UPDATED_BY             VARCHAR2(50),

    UPDATED_DATE           TIMESTAMP,

    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    CONSTRAINT PK_SEASON
        PRIMARY KEY (SEASON_ID),

    --------------------------------------------------------------------------
    -- Foreign Key
    --------------------------------------------------------------------------
    CONSTRAINT FK_SEASON_COMPETITION
        FOREIGN KEY (COMPETITION_ID)
        REFERENCES COMPETITION (COMPETITION_ID),

    --------------------------------------------------------------------------
    -- Unique Constraints
    --------------------------------------------------------------------------
    CONSTRAINT UK_SEASON_COMP_YEAR
        UNIQUE (COMPETITION_ID, SEASON_YEAR),

    CONSTRAINT UK_SEASON_NAME
        UNIQUE (SEASON_NAME),

    --------------------------------------------------------------------------
    -- Check Constraints
    --------------------------------------------------------------------------
    CONSTRAINT CHK_SEASON_STATUS
        CHECK
        (
            STATUS IN
            (
                'UPCOMING',
                'ONGOING',
                'COMPLETED',
                'CANCELLED'
            )
        ),

    CONSTRAINT CHK_SEASON_YEAR
        CHECK (SEASON_YEAR >= 1900),

    CONSTRAINT CHK_SEASON_MATCHES
        CHECK (TOTAL_MATCHES >= 0),

    CONSTRAINT CHK_SEASON_DATES
        CHECK (START_DATE <= END_DATE)
);