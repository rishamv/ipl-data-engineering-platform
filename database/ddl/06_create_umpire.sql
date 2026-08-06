/******************************************************************************
 * File Name   : 06_create_umpire.sql
 * Description : Creates the UMPIRE master table.
 ******************************************************************************/

CREATE TABLE UMPIRE
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    UMPIRE_ID               NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Business Information
    --------------------------------------------------------------------------
    FIRST_NAME              VARCHAR2(50)                NOT NULL,

    LAST_NAME               VARCHAR2(50),

    FULL_NAME               VARCHAR2(120)               NOT NULL,

    NATIONALITY             VARCHAR2(50)                NOT NULL,

    ICC_PANEL               VARCHAR2(20)
                             DEFAULT 'NO'
                             NOT NULL,

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
    CONSTRAINT PK_UMPIRE
        PRIMARY KEY (UMPIRE_ID),

    CONSTRAINT CHK_UMPIRE_STATUS
        CHECK (STATUS IN ('ACTIVE','INACTIVE','RETIRED')),

    CONSTRAINT CHK_UMPIRE_PANEL
        CHECK (ICC_PANEL IN ('YES','NO'))
);

COMMENT ON TABLE UMPIRE IS
'Stores umpire master information.';

COMMENT ON COLUMN UMPIRE.UMPIRE_ID IS
'Primary key of umpire.';

COMMENT ON COLUMN UMPIRE.FULL_NAME IS
'Full name of the umpire.';

COMMENT ON COLUMN UMPIRE.ICC_PANEL IS
'Indicates whether the umpire is part of the ICC Elite Panel.';