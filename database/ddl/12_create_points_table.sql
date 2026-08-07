/******************************************************************************
 * File Name   : 12_create_points_table.sql
 * Description : Stores season points table.
 ******************************************************************************/

CREATE TABLE POINTS_TABLE
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    POINTS_TABLE_ID             NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Foreign Keys
    --------------------------------------------------------------------------
    SEASON_ID                   NUMBER(10)                  NOT NULL,

    TEAM_ID                     NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Statistics
    --------------------------------------------------------------------------
    MATCHES_PLAYED              NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    WINS                        NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    LOSSES                      NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    TIES                        NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    NO_RESULTS                  NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    POINTS                      NUMBER(3)
                                 DEFAULT 0
                                 NOT NULL,

    NET_RUN_RATE                NUMBER(8,3)
                                 DEFAULT 0
                                 NOT NULL,

    POSITION                    NUMBER(2),

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
    CONSTRAINT PK_POINTS_TABLE
        PRIMARY KEY (POINTS_TABLE_ID),

    CONSTRAINT FK_POINTS_SEASON
        FOREIGN KEY (SEASON_ID)
        REFERENCES SEASON(SEASON_ID),

    CONSTRAINT FK_POINTS_TEAM
        FOREIGN KEY (TEAM_ID)
        REFERENCES TEAM(TEAM_ID),

    CONSTRAINT UK_POINTS_TEAM
        UNIQUE (SEASON_ID, TEAM_ID),

    CONSTRAINT CHK_POINTS_POS
        CHECK (POSITION IS NULL OR POSITION > 0)
);

COMMENT ON TABLE POINTS_TABLE IS
'Stores season standings for every team.';