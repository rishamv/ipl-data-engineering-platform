/******************************************************************************
 * File Name   : 04_create_player.sql
 * Description : Creates the PLAYER master table.
 ******************************************************************************/

CREATE TABLE PLAYER
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    PLAYER_ID               NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    PLAYER_CODE             VARCHAR2(20)                NOT NULL,

    FIRST_NAME              VARCHAR2(50)                NOT NULL,

    LAST_NAME               VARCHAR2(50),

    FULL_NAME               VARCHAR2(120)               NOT NULL,

    DATE_OF_BIRTH           DATE,

    NATIONALITY             VARCHAR2(50)                NOT NULL,

    BATTING_STYLE           VARCHAR2(30),

    BOWLING_STYLE           VARCHAR2(50),

    PLAYER_ROLE             VARCHAR2(30)                NOT NULL,

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
    CONSTRAINT PK_PLAYER
        PRIMARY KEY (PLAYER_ID),

    CONSTRAINT UK_PLAYER_CODE
        UNIQUE (PLAYER_CODE),

    CONSTRAINT CHK_PLAYER_STATUS
        CHECK (STATUS IN ('ACTIVE','INACTIVE','RETIRED')),

    CONSTRAINT CHK_PLAYER_ROLE
        CHECK
        (
            PLAYER_ROLE IN
            (
                'BATSMAN',
                'BOWLER',
                'ALL_ROUNDER',
                'WICKET_KEEPER'
            )
        )
);

COMMENT ON TABLE PLAYER IS
'Stores player master information.';

COMMENT ON COLUMN PLAYER.PLAYER_ID IS
'Primary key of player.';

COMMENT ON COLUMN PLAYER.PLAYER_CODE IS
'Unique player identifier.';

COMMENT ON COLUMN PLAYER.PLAYER_ROLE IS
'Primary cricket role of the player.';