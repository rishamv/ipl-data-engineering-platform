/******************************************************************************
 * File Name   : 01_create_competition.sql
 * Project     : IPL Data Engineering Platform
 * Module      : Database DDL
 * Author      : Risham
 * Description : Creates the COMPETITION master table.
 *
 * Business Purpose:
 * Stores information about cricket competitions such as IPL, WPL, etc.
 *
 * Dependencies:
 * None
 ******************************************************************************/

CREATE TABLE COMPETITION
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    COMPETITION_ID         NUMBER(10)             NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    COMPETITION_CODE       VARCHAR2(10)           NOT NULL,
    COMPETITION_NAME       VARCHAR2(100)          NOT NULL,
    COUNTRY                VARCHAR2(50)           NOT NULL,
    START_YEAR             NUMBER(4)              NOT NULL,
    STATUS                 VARCHAR2(20)           NOT NULL,

    --------------------------------------------------------------------------
    -- Audit Information
    --------------------------------------------------------------------------
    CREATED_BY             VARCHAR2(50)           DEFAULT USER NOT NULL,
    CREATED_DATE           TIMESTAMP              DEFAULT SYSTIMESTAMP NOT NULL,
    UPDATED_BY             VARCHAR2(50),
    UPDATED_DATE           TIMESTAMP,

    --------------------------------------------------------------------------
    -- Constraints
    --------------------------------------------------------------------------
    CONSTRAINT PK_COMPETITION
        PRIMARY KEY (COMPETITION_ID),

    CONSTRAINT UK_COMPETITION_CODE
        UNIQUE (COMPETITION_CODE),

    CONSTRAINT UK_COMPETITION_NAME
        UNIQUE (COMPETITION_NAME),

    CONSTRAINT CHK_COMPETITION_STATUS
        CHECK (STATUS IN ('ACTIVE','INACTIVE')),

    CONSTRAINT CHK_COMPETITION_START_YEAR
        CHECK (START_YEAR >= 1900)
);

COMMIT;