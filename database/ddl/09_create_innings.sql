/******************************************************************************
 * File Name   : 09_create_innings.sql
 * Description : Creates the INNINGS transaction table.
 ******************************************************************************/

CREATE TABLE INNINGS
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    INNINGS_ID                  NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Foreign Keys
    --------------------------------------------------------------------------
    MATCH_ID                    NUMBER(10)                  NOT NULL,

    BATTING_TEAM_ID             NUMBER(10)                  NOT NULL,

    BOWLING_TEAM_ID             NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    INNINGS_NUMBER              NUMBER(1)                   NOT NULL,

    TOTAL_RUNS                  NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    TOTAL_WICKETS               NUMBER(2)
                                 DEFAULT 0
                                 NOT NULL,

    TOTAL_OVERS                 NUMBER(4,1)
                                 DEFAULT 0
                                 NOT NULL,

    EXTRA_RUNS                  NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    STATUS                      VARCHAR2(20)
                                 DEFAULT 'COMPLETED'
                                 NOT NULL,

    --------------------------------------------------------------------------
    -- Audit Columns
    --------------------------------------------------------------------------
    CREATED_BY                  VARCHAR2(50)
                                 DEFAULT USER
                                 NOT NULL,

    CREATED_DATE                TIMESTAMP
                                 DEFAULT SYSTIMESTAMP
                                 NOT NULL,

    UPDATED_BY                  VARCHAR2(50),

    UPDATED_DATE                TIMESTAMP,

    --------------------------------------------------------------------------
    -- Constraints
    --------------------------------------------------------------------------
    CONSTRAINT PK_INNINGS
        PRIMARY KEY (INNINGS_ID),

    CONSTRAINT FK_INNINGS_MATCH
        FOREIGN KEY (MATCH_ID)
        REFERENCES MATCH (MATCH_ID),

    CONSTRAINT FK_INNINGS_BATTING_TEAM
        FOREIGN KEY (BATTING_TEAM_ID)
        REFERENCES TEAM (TEAM_ID),

    CONSTRAINT FK_INNINGS_BOWLING_TEAM
        FOREIGN KEY (BOWLING_TEAM_ID)
        REFERENCES TEAM (TEAM_ID),

    CONSTRAINT UK_INNINGS_MATCH
        UNIQUE (MATCH_ID, INNINGS_NUMBER),

    CONSTRAINT CHK_INNINGS_NUMBER
        CHECK (INNINGS_NUMBER >= 1),

    CONSTRAINT CHK_INNINGS_STATUS
        CHECK (STATUS IN ('LIVE','COMPLETED')),

    CONSTRAINT CHK_INNINGS_TEAMS
        CHECK (BATTING_TEAM_ID <> BOWLING_TEAM_ID)
);

COMMENT ON TABLE INNINGS IS
'Stores innings information for every match.';