       IDENTIFICATION DIVISION.
       PROGRAM-ID. BATCH001.
      *
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
         SELECT IN-FILE ASSIGN TO IN-FILE-NAME
                        ORGANIZATION IS LINE SEQUENTIAL.
         SELECT OUT-FILE ASSIGN TO OUT-FILE-NAME.
      *
       DATA DIVISION.
      ************************************ 
       FILE SECTION.
       FD  IN-FILE  LABEL RECORD STANDARD
                    BLOCK CONTAINS 0 RECORDS.
       01 IN-REC.
        COPY "location.cpy".
       FD  OUT-FILE LABEL RECORD OMITTED.
       01 OUT-REC.
        COPY "location.cpy".
      ************************************ 
       WORKING-STORAGE SECTION.
       01 IN-DATA.
         COPY "location.cpy".
      *   03  IN-STR PIC X(10).
       01 FLG-EOF PIC X(01).
      *     
       01 IN-FILE-NAME  PIC X(255).
       01 OUT-FILE-NAME PIC X(255). 
      *
       01 CURRENT-DATE.
          03 CD-YEAR  PIC 9(4).
          03 CD-MONTH PIC 9(2).
          03 CD-DAY   PIC 9(2).
       01 CURRENT-TIME.
          03 CT-HOURS   PIC 9(2).
          03 CT-MINUTES PIC 9(2).
          03 CT-SECONDS PIC 9(2).
          03 CT-10MSEC  PIC 9(2). 
      *
       01 APL-LOG.
          03 AL-YEAR    PIC 9(4).
          03 FILLER     PIC X(1) VALUE "/".
          03 AL-MONTH   PIC 9(2).
          03 FILLER     PIC X(1) VALUE "/".
          03 AL-DAY     PIC 9(2).
          03 FILLER     PIC X(1) VALUE "-".
          03 Al-HOURS   PIC 9(2).
          03 FILLER     PIC X(1) VALUE ":".
          03 AL-MINUTES PIC 9(2).
          03 FILLER     PIC X(1) VALUE ":".
          03 AL-SECONDS PIC 9(2).
          03 FILLER     PIC X(1) VALUE ".".
          03 AL-10MSEC  PIC 9(2).
          03 FILLER     PIC X(1) VALUE " ".
          03 AL-BATCHID PIC X(8) VALUE "BATCH001".
          03 FILLER     PIC X(1) VALUE " ".
          03 AL-MSGID   PIC X(8).
          03 FILLER     PIC X(2) VALUE ": ".
          03 AL-MSGTXT  PIC X(100).
      *
       01 D-VALUE01 PIC 9(8) VALUE 0.
       01 D-VALUE02 PIC 9(8) VALUE 0.
      *
       PROCEDURE DIVISION.
      ***********************************
      * Main 
       PGM-MAIN SECTION.
       PGM-MAIN-S.
      * Initialize
           ACCEPT IN-FILE-NAME FROM ENVIRONMENT "INFILENAME".
           ACCEPT OUT-FILE-NAME FROM ENVIRONMENT "OUTFILENAME".
           ACCEPT AL-BATCHID FROM ENVIRONMENT "BATCHID".
      *
           MOVE SPACE TO AL-MSGTXT.
           MOVE "MSGID001" TO AL-MSGID.
           MOVE "Begin Program" TO AL-MSGTXT.
           PERFORM WRITE-LOG.
      *
           PERFORM FILE-OPEN.
      * Main Logic
           PERFORM FILE-READ.             
           PERFORM FILE-WRITE-READ
                   UNTIL FLG-EOF = '1'.
      * Finalize
           PERFORM FILE-CLOSE.
           MOVE SPACE TO AL-MSGTXT.
           MOVE "MSGID002" TO AL-MSGID.
           MOVE "End Program" TO AL-MSGTXT.
           PERFORM WRITE-LOG.
       PGM-MAIN-E.
           STOP RUN.
      *********************************
      * Write Log
       WRITE-LOG SECTION.
       WRITE-LOG-S.
           ACCEPT CURRENT-DATE FROM DATE YYYYMMDD.
           ACCEPT CURRENT-TIME FROM TIME.
           MOVE CD-YEAR TO AL-YEAR.
           MOVE CD-MONTH TO AL-MONTH.
           MOVE CD-DAY TO AL-DAY.
           MOVE CT-HOURS TO AL-HOURS.
           MOVE CT-MINUTES TO AL-MINUTES.
           MOVE CT-SECONDS TO AL-SECONDS.
           MOVE CT-10MSEC TO AL-10MSEC.
           DISPLAY APL-LOG.
       WRITE-LOG-E.
         EXIT.
      *********************************     
      * File Open
       FILE-OPEN SECTION.
       FILE-OPEN-S.
         OPEN INPUT  IN-FILE
              OUTPUT OUT-FILE.
         MOVE SPACE  TO  FLG-EOF.
       FILE-OPEN-E.
         EXIT.
      *********************************
      * File Read
       FILE-READ SECTION.
       FILE-READ-S.
         READ IN-FILE INTO IN-DATA
           AT END
             MOVE '1'  TO  FLG-EOF
         END-READ.
      *
         MOVE SPACE TO AL-MSGTXT.
         MOVE "MSGID003" TO AL-MSGID.
         MOVE "Read 1 record from file." TO AL-MSGTXT.
         PERFORM WRITE-LOG.
      *     
       FILE-READ-E.
         EXIT.
      ********************************
      * File Write and Read
       FILE-WRITE-READ SECTION.
       FILE-WRITE-READ-S.
         PERFORM WL-LOOP.
      *
         WRITE OUT-REC FROM IN-DATA AFTER 1.
      *
         MOVE SPACE TO AL-MSGTXT.
         MOVE "MSGID004" TO AL-MSGID.
         MOVE "Write 1 record to file." TO AL-MSGTXT.
         PERFORM WRITE-LOG.
      *
         PERFORM FILE-READ.
       FILE-WRITE-READ-E.
         EXIT.
      *********************************
      * File Close
       FILE-CLOSE  SECTION.
       FILE-CLOSE-S.
         CLOSE IN-FILE
               OUT-FILE.
       FILE-CLOSE-E.
           EXIT.
      ********************************
      * Loop
       WL-LOOP SECTION.
       WL-LOOP-S.
           MOVE 0 TO D-VALUE01.
           PERFORM 1000000 TIMES
              COMPUTE D-VALUE01 = D-VALUE01 + 10
              COMPUTE D-VALUE01 = D-VALUE01 * 10
              COMPUTE D-VALUE01 = D-VALUE01 / 10
              COMPUTE D-VALUE01 = D-VALUE01 - 10
           END-PERFORM.
       WL-LOOP-E.
         EXIT.


