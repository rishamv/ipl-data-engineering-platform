/******************************************************************************
 * File Name   : 10_create_delivery.sql
 * Description : Creates the DELIVERY transaction table.
 ******************************************************************************/

CREATE TABLE DELIVERY
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    DELIVERY_ID                 NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Foreign Keys
    --------------------------------------------------------------------------
    INNINGS_ID                  NUMBER(10)                  NOT NULL,

    STRIKER_ID                  NUMBER(10)                  NOT NULL,

    NON_STRIKER_ID              NUMBER(10)                  NOT NULL,

    BOWLER_ID                   NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Ball Information
    --------------------------------------------------------------------------
    OVER_NUMBER                 NUMBER(2)                   NOT NULL,

    BALL_NUMBER                 NUMBER(2)                   NOT NULL,

    RUNS_BAT                    NUMBER(2)
                                 DEFAULT 0
                                 NOT NULL,

    EXTRA_RUNS                  NUMBER(2)
                                 DEFAULT 0
                                 NOT NULL,

    TOTAL_RUNS                  NUMBER(2)
                                 DEFAULT 0
                                 NOT NULL,

    EXTRA_TYPE                  VARCHAR2(20),

    IS_BOUNDARY                 CHAR(1)
                                 DEFAULT 'N'
                                 NOT NULL,

    IS_DOT_BALL                 CHAR(1)
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
    CONSTRAINT PK_DELIVERY
        PRIMARY KEY (DELIVERY_ID),

    CONSTRAINT FK_DELIVERY_INNINGS
        FOREIGN KEY (INNINGS_ID)
        REFERENCES INNINGS (INNINGS_ID),

    CONSTRAINT FK_DELIVERY_STRIKER
        FOREIGN KEY (STRIKER_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT FK_DELIVERY_NON_STRIKER
        FOREIGN KEY (NON_STRIKER_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT FK_DELIVERY_BOWLER
        FOREIGN KEY (BOWLER_ID)
        REFERENCES PLAYER (PLAYER_ID),

    CONSTRAINT UK_DELIVERY_BALL
        UNIQUE (INNINGS_ID, OVER_NUMBER, BALL_NUMBER),

    CONSTRAINT CHK_DELIVERY_BOUNDARY
        CHECK (IS_BOUNDARY IN ('Y','N')),

    CONSTRAINT CHK_DELIVERY_DOT
        CHECK (IS_DOT_BALL IN ('Y','N')),

    CONSTRAINT CHK_DELIVERY_EXTRA
        CHECK
        (
            EXTRA_TYPE IS NULL
            OR EXTRA_TYPE IN
            (
                'WIDE',
                'NO_BALL',
                'BYE',
                'LEG_BYE'
            )
        )
);

COMMENT ON TABLE DELIVERY IS
'Stores ball-by-ball information.';

ALTER TABLE DELIVERY
ADD
(
    BALL_IN_OVER NUMBER(2)
);

ALTER TABLE DELIVERY
ADD
(
    BALL_SEQUENCE NUMBER(6)
);

ALTER TABLE DELIVERY
MODIFY
(
    BALL_IN_OVER NUMBER(2) NOT NULL,
    BALL_SEQUENCE NUMBER(6) NOT NULL
);

ALTER TABLE DELIVERY
ADD CONSTRAINT CHK_DELIVERY_BALL_SEQUENCE
CHECK (BALL_SEQUENCE > 0);