        01 message.
           03 ORDER-ID              PIC X(18).
           03 ORDER-DATE            PIC X(10).
           03 ORDER-TIME            PIC X(8).
           03 ITEM.
             05 I-CODE              PIC X(7).
             05 I-NAME              PIC X(60).
             05 I-PRICE             PIC 9(8).
             05 I-VENDORID          PIC X(4).
           03 ORDER-QUANTITY        PIC 9(8).
           03 SHOP-INFO. 
             05 S-ID                PIC X(6).
             05 S-NAME              PIC X(60).
             05 S-ZIP               PIC X(7).
             05 S-ADDRESS           PIC X(120).
             05 S-TEL               PIC X(12).
