/******************************************************************************
 * File Name   : 08_create_match.sql
 * Project     : IPL Data Engineering Platform
 * Module      : Database DDL
 * Description : Creates the MATCH transaction table.
 ******************************************************************************/

CREATE TABLE MATCH
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    MATCH_ID                    NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Parent References
    --------------------------------------------------------------------------
    COMPETITION_ID              NUMBER(10)                  NOT NULL,

    SEASON_ID                   NUMBER(10)                  NOT NULL,

    VENUE_ID                    NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Teams
    --------------------------------------------------------------------------
    HOME_TEAM_ID                NUMBER(10)                  NOT NULL,

    AWAY_TEAM_ID                NUMBER(10)                  NOT NULL,

    WINNER_TEAM_ID              NUMBER(10),

    TOSS_WINNER_TEAM_ID         NUMBER(10),

    --------------------------------------------------------------------------
    -- Match Information
    --------------------------------------------------------------------------
    MATCH_NUMBER                NUMBER(3)                   NOT NULL,

    MATCH_DATE                  DATE                        NOT NULL,

    MATCH_TYPE                  VARCHAR2(20)
                                 DEFAULT 'LEAGUE'
                                 NOT NULL,

    TOSS_DECISION               VARCHAR2(10),

    RESULT_TYPE                 VARCHAR2(20),

    WIN_MARGIN                  NUMBER(4),

    PLAYER_OF_MATCH_ID          NUMBER(10),

    STATUS                      VARCHAR2(20)
                                 DEFAULT 'SCHEDULED'
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
    CONSTRAINT PK_MATCH
        PRIMARY KEY (MATCH_ID),

    CONSTRAINT FK_MATCH_COMPETITION
        FOREIGN KEY (COMPETITION_ID)
        REFERENCES COMPETITION(COMPETITION_ID),

    CONSTRAINT FK_MATCH_SEASON
        FOREIGN KEY (SEASON_ID)
        REFERENCES SEASON(SEASON_ID),

    CONSTRAINT FK_MATCH_VENUE
        FOREIGN KEY (VENUE_ID)
        REFERENCES VENUE(VENUE_ID),

    CONSTRAINT FK_MATCH_HOME_TEAM
        FOREIGN KEY (HOME_TEAM_ID)
        REFERENCES TEAM(TEAM_ID),

    CONSTRAINT FK_MATCH_AWAY_TEAM
        FOREIGN KEY (AWAY_TEAM_ID)
        REFERENCES TEAM(TEAM_ID),

    CONSTRAINT FK_MATCH_WINNER
        FOREIGN KEY (WINNER_TEAM_ID)
        REFERENCES TEAM(TEAM_ID),

    CONSTRAINT FK_MATCH_TOSS_WINNER
        FOREIGN KEY (TOSS_WINNER_TEAM_ID)
        REFERENCES TEAM(TEAM_ID),

    CONSTRAINT FK_MATCH_POM
        FOREIGN KEY (PLAYER_OF_MATCH_ID)
        REFERENCES PLAYER(PLAYER_ID),

    CONSTRAINT UK_MATCH_NUMBER
        UNIQUE (SEASON_ID, MATCH_NUMBER),

    CONSTRAINT CHK_MATCH_STATUS
        CHECK
        (
            STATUS IN
            (
                'SCHEDULED',
                'LIVE',
                'COMPLETED',
                'ABANDONED'
            )
        ),

    CONSTRAINT CHK_MATCH_TYPE
        CHECK
        (
            MATCH_TYPE IN
            (
                'LEAGUE',
                'QUALIFIER',
                'ELIMINATOR',
                'FINAL'
            )
        ),

    CONSTRAINT CHK_TOSS_DECISION
        CHECK
        (
            TOSS_DECISION IN
            (
                'BAT',
                'FIELD'
            )
            OR TOSS_DECISION IS NULL
        ),

    CONSTRAINT CHK_RESULT_TYPE
        CHECK
        (
            RESULT_TYPE IN
            (
                'RUNS',
                'WICKETS',
                'TIE',
                'NO_RESULT'
            )
            OR RESULT_TYPE IS NULL
        ),

    CONSTRAINT CHK_MATCH_TEAMS
        CHECK (HOME_TEAM_ID <> AWAY_TEAM_ID)
);

COMMENT ON TABLE MATCH IS
'Stores every cricket match.';

COMMENT ON COLUMN MATCH.MATCH_ID IS
'Primary key of match.';

COMMENT ON COLUMN MATCH.MATCH_NUMBER IS
'Sequential match number within the season.';

COMMENT ON COLUMN MATCH.MATCH_DATE IS
'Scheduled match date.';

COMMENT ON COLUMN MATCH.HOME_TEAM_ID IS
'Home team.';

COMMENT ON COLUMN MATCH.AWAY_TEAM_ID IS
'Away team.';

COMMENT ON COLUMN MATCH.WINNER_TEAM_ID IS
'Winning team.';

COMMENT ON COLUMN MATCH.PLAYER_OF_MATCH_ID IS
'Player awarded Player of the Match.';