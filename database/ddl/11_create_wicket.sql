/******************************************************************************
 * File Name   : 11_create_wicket.sql
 * Description : Creates the WICKET transaction table.
 ******************************************************************************/

CREATE TABLE WICKET
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    WICKET_ID                   NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Foreign Keys
    --------------------------------------------------------------------------
    DELIVERY_ID                 NUMBER(10)                  NOT NULL,

    BATSMAN_ID                  NUMBER(10)                  NOT NULL,

    BOWLER_ID                   NUMBER(10),

    FIELDER_ID                  NUMBER(10),

    --------------------------------------------------------------------------
    -- Wicket Information
    --------------------------------------------------------------------------
    WICKET_NUMBER               NUMBER(2)                   NOT NULL,

    WICKET_TYPE                 VARCHAR2(30)               NOT NULL,

    RUN_OUT_DIRECT              CHAR(1)
                                 DEFAULT 'N'
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
    CONSTRAINT PK_WICKET
        PRIMARY KEY (WICKET_ID),

    CONSTRAINT FK_WICKET_DELIVERY
        FOREIGN KEY (DELIVERY_ID)
        REFERENCES DELIVERY (DELIVERY_ID),

    CONSTRAINT FK_WICKET_BATSMAN
        FOREIGN KEY (BATSMAN_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT FK_WICKET_BOWLER
        FOREIGN KEY (BOWLER_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT FK_WICKET_FIELDER
        FOREIGN KEY (FIELDER_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT UK_WICKET_DELIVERY
        UNIQUE (DELIVERY_ID),

    CONSTRAINT CHK_WICKET_DIRECT
        CHECK (RUN_OUT_DIRECT IN ('Y','N')),

    CONSTRAINT CHK_WICKET_TYPE
        CHECK
        (
            WICKET_TYPE IN
            (
                'BOWLED',
                'CAUGHT',
                'LBW',
                'RUN_OUT',
                'STUMPED',
                'HIT_WICKET',
                'RETIRED_OUT',
                'OBSTRUCTING_FIELD',
                'TIMED_OUT'
            )
        )
);

COMMENT ON TABLE WICKET IS
'Stores wicket details for deliveries that resulted in dismissals.';