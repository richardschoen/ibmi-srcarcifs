             PGM

             DCL        VAR(&DESTFILE) TYPE(*CHAR) LEN(10) +
                          VALUE(SOURCE)
             DCL        VAR(&DESTLIB) TYPE(*CHAR) LEN(10) +
                          VALUE(MBSRCARC)
             DCL        VAR(&TGTRLS) TYPE(*CHAR) LEN(10) +
                          VALUE(*CURRENT)
             DCL        VAR(&VERSION) TYPE(*CHAR) LEN(30) +
                          VALUE(V1.0.1)
             DCL        VAR(&CMD) TYPE(*CHAR) LEN(512)
             DCL        VAR(&LEN) TYPE(*DEC) LEN(15 5)

 /** Add libraries to library list */
             ADDLIBLE   LIB(&DESTLIB)
             MONMSG     MSGID(CPF0000)

             CRTCMD     CMD(&DESTLIB/SRCARCIFS) +
                          PGM(&DESTLIB/SRCARCIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) +
                          PRDLIB(&DESTLIB) AUT(*USE) REPLACE(*YES)

             CRTBNDCL   PGM(&DESTLIB/SRCARCIFSC) +
                          SRCFILE(&DESTLIB/&DESTFILE) REPLACE(*YES) +
                          TGTRLS(&TGTRLS) AUT(*USE)

 /* Create and set data area for version                      */
             CRTDTAARA  DTAARA(&DESTLIB/VERSION) TYPE(*CHAR) LEN(30) +
                          VALUE(&VERSION) TEXT(&DESTLIB |> +
                          'version') AUT(*USE)
             MONMSG     MSGID(CPF0000)
             CHGDTAARA  DTAARA(&DESTLIB/VERSION *ALL) VALUE(&VERSION)

 /* Make /tmp/tmpsrcarc */
             MKDIR      DIR('/tmp/tmpsrcarc') DTAAUT(*RWX) OBJAUT(*ALL)
             MONMSG     MSGID(CPF0000)

 /* Change library desc to match the version */
             CHGLIB     LIB(&DESTLIB) TEXT('MobiGoGo Archive Source +
                          Members' |> &VERSION)

             ENDPGM
