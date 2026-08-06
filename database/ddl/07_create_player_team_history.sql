/******************************************************************************
 * File Name   : 07_create_player_team_history.sql
 * Project     : IPL Data Engineering Platform
 * Module      : Database DDL
 * Description : Stores player-team association for every season.
 ******************************************************************************/

CREATE TABLE PLAYER_TEAM_HISTORY
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    PLAYER_TEAM_HISTORY_ID      NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Foreign Keys
    --------------------------------------------------------------------------
    PLAYER_ID                   NUMBER(10)                  NOT NULL,

    TEAM_ID                     NUMBER(10)                  NOT NULL,

    SEASON_ID                   NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    JERSEY_NUMBER               NUMBER(3),

    IS_CAPTAIN                  CHAR(1)
                                 DEFAULT 'N'
                                 NOT NULL,

    IS_WICKET_KEEPER            CHAR(1)
                                 DEFAULT 'N'
                                 NOT NULL,

    START_DATE                  DATE,

    END_DATE                    DATE,

    STATUS                      VARCHAR2(20)
                                 DEFAULT 'ACTIVE'
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
    CONSTRAINT PK_PLAYER_TEAM_HISTORY
        PRIMARY KEY (PLAYER_TEAM_HISTORY_ID),

    CONSTRAINT FK_PTH_PLAYER
        FOREIGN KEY (PLAYER_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT FK_PTH_TEAM
        FOREIGN KEY (TEAM_ID)
        REFERENCES TEAM (TEAM_ID),

    CONSTRAINT FK_PTH_SEASON
        FOREIGN KEY (SEASON_ID)
        REFERENCES SEASON (SEASON_ID),

    CONSTRAINT UK_PTH_PLAYER_SEASON
        UNIQUE (PLAYER_ID, SEASON_ID),

    CONSTRAINT CHK_PTH_STATUS
        CHECK (STATUS IN ('ACTIVE','INACTIVE')),

    CONSTRAINT CHK_PTH_CAPTAIN
        CHECK (IS_CAPTAIN IN ('Y','N')),

    CONSTRAINT CHK_PTH_KEEPER
        CHECK (IS_WICKET_KEEPER IN ('Y','N')),

    CONSTRAINT CHK_PTH_DATES
        CHECK
        (
            END_DATE IS NULL
            OR START_DATE IS NULL
            OR START_DATE <= END_DATE
        )
);

COMMENT ON TABLE PLAYER_TEAM_HISTORY IS
'Stores player association with a team for a particular season.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.PLAYER_TEAM_HISTORY_ID IS
'Primary key.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.PLAYER_ID IS
'Reference to PLAYER.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.TEAM_ID IS
'Reference to TEAM.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.SEASON_ID IS
'Reference to SEASON.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.JERSEY_NUMBER IS
'Jersey number worn during the season.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.IS_CAPTAIN IS
'Indicates whether the player captained the team.';

COMMENT ON COLUMN PLAYER_TEAM_HISTORY.IS_WICKET_KEEPER IS
'Indicates whether the player served as wicket keeper.';