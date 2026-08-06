/******************************************************************************
 * File Name   : 05_create_venue.sql
 * Description : Creates the VENUE master table.
 ******************************************************************************/

CREATE TABLE VENUE
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    VENUE_ID                NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    VENUE_CODE              VARCHAR2(20)                NOT NULL,

    VENUE_NAME              VARCHAR2(150)               NOT NULL,

    CITY                    VARCHAR2(50)                NOT NULL,

    STATE                   VARCHAR2(50),

    COUNTRY                 VARCHAR2(50)
                             DEFAULT 'India'
                             NOT NULL,

    CAPACITY                NUMBER(6),

    ESTABLISHED_YEAR        NUMBER(4),

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
    -- Constraints
    --------------------------------------------------------------------------
    CONSTRAINT PK_VENUE
        PRIMARY KEY (VENUE_ID),

    CONSTRAINT UK_VENUE_CODE
        UNIQUE (VENUE_CODE),

    CONSTRAINT UK_VENUE_NAME
        UNIQUE (VENUE_NAME),

    CONSTRAINT CHK_VENUE_STATUS
        CHECK (STATUS IN ('ACTIVE','INACTIVE')),

    CONSTRAINT CHK_VENUE_CAPACITY
        CHECK (CAPACITY IS NULL OR CAPACITY > 0),

    CONSTRAINT CHK_VENUE_YEAR
        CHECK (ESTABLISHED_YEAR IS NULL OR ESTABLISHED_YEAR >= 1800)
);

COMMENT ON TABLE VENUE IS
'Stores cricket stadium information.';

COMMENT ON COLUMN VENUE.VENUE_ID IS
'Primary key of venue.';

COMMENT ON COLUMN VENUE.VENUE_NAME IS
'Official venue name.';