/******************************************************************************
 * File Name   : 03_create_team.sql
 * Project     : IPL Data Engineering Platform
 * Module      : Database DDL
 * Author      : Risham
 * Description : Creates the TEAM master table.
 *
 * Business Purpose:
 * Stores all cricket teams participating in various competitions.
 *
 * Dependencies:
 * None
 ******************************************************************************/

CREATE TABLE TEAM
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    TEAM_ID                 NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    TEAM_CODE               VARCHAR2(10)                NOT NULL,

    TEAM_NAME               VARCHAR2(100)               NOT NULL,

    SHORT_NAME              VARCHAR2(10)                NOT NULL,

    HOME_CITY               VARCHAR2(50)                NOT NULL,

    HOME_STATE              VARCHAR2(50),

    COUNTRY                 VARCHAR2(50)
                             DEFAULT 'India'
                             NOT NULL,

    FOUNDED_YEAR            NUMBER(4),

    STATUS                  VARCHAR2(20)
                             DEFAULT 'ACTIVE'
                             NOT NULL,

    --------------------------------------------------------------------------
    -- Audit Columns
    --------------------------------------------------------------------------
    CREATED_BY              VARCHAR2(50)
                             DEFAULT USER
                             NOT NULL,

    CREATED_DATE            TIMESTAMP
                             DEFAULT SYSTIMESTAMP
                             NOT NULL,

    UPDATED_BY              VARCHAR2(50),

    UPDATED_DATE            TIMESTAMP,

    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    CONSTRAINT PK_TEAM
        PRIMARY KEY (TEAM_ID),

    --------------------------------------------------------------------------
    -- Unique Constraints
    --------------------------------------------------------------------------
    CONSTRAINT UK_TEAM_CODE
        UNIQUE (TEAM_CODE),

    CONSTRAINT UK_TEAM_NAME
        UNIQUE (TEAM_NAME),

    CONSTRAINT UK_TEAM_SHORT_NAME
        UNIQUE (SHORT_NAME),

    --------------------------------------------------------------------------
    -- Check Constraints
    --------------------------------------------------------------------------
    CONSTRAINT CHK_TEAM_STATUS
        CHECK (STATUS IN ('ACTIVE','INACTIVE')),

    CONSTRAINT CHK_TEAM_FOUNDED_YEAR
        CHECK (FOUNDED_YEAR IS NULL OR FOUNDED_YEAR >= 1900)
);