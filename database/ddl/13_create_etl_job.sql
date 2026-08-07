/******************************************************************************
 * File Name   : 13_create_etl_job.sql
 * Description : Stores ETL job execution details.
 ******************************************************************************/

CREATE TABLE ETL_JOB
(
    --------------------------------------------------------------------------
    -- Primary Key
    --------------------------------------------------------------------------
    ETL_JOB_ID                  NUMBER(10)                  NOT NULL,

    --------------------------------------------------------------------------
    -- Job Information
    --------------------------------------------------------------------------
    JOB_NAME                    VARCHAR2(100)               NOT NULL,

    JOB_TYPE                    VARCHAR2(30)
                                 DEFAULT 'LOAD'
                                 NOT NULL,

    START_TIME                  TIMESTAMP                   NOT NULL,

    END_TIME                    TIMESTAMP,

    STATUS                      VARCHAR2(20)
                                 DEFAULT 'RUNNING'
                                 NOT NULL,

    ROWS_READ                   NUMBER(10)
                                 DEFAULT 0
                                 NOT NULL,

    ROWS_INSERTED               NUMBER(10)
                                 DEFAULT 0
                                 NOT NULL,

    ROWS_UPDATED                NUMBER(10)
                                 DEFAULT 0
                                 NOT NULL,

    ROWS_REJECTED               NUMBER(10)
                                 DEFAULT 0
                                 NOT NULL,

    ERROR_COUNT                 NUMBER(10)
                                 DEFAULT 0
                                 NOT NULL,

    EXECUTED_BY                 VARCHAR2(50)
                                 DEFAULT USER
                                 NOT NULL,

    REMARKS                     VARCHAR2(500),

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
    CONSTRAINT PK_ETL_JOB
        PRIMARY KEY (ETL_JOB_ID),

    CONSTRAINT CHK_ETL_JOB_STATUS
        CHECK
        (
            STATUS IN
            (
                'RUNNING',
                'SUCCESS',
                'FAILED',
                'PARTIAL'
            )
        ),

    CONSTRAINT CHK_ETL_JOB_TYPE
        CHECK
        (
            JOB_TYPE IN
            (
                'LOAD',
                'VALIDATION',
                'REPROCESS',
                'REPORT'
            )
        )
);

COMMENT ON TABLE ETL_JOB IS
'Stores ETL job execution history.';

COMMENT ON COLUMN ETL_JOB.JOB_NAME IS
'Name of the ETL job.';

COMMENT ON COLUMN ETL_JOB.STATUS IS
'Execution status of the ETL job.';

COMMENT ON COLUMN ETL_JOB.ERROR_COUNT IS
'Total number of errors encountered.';