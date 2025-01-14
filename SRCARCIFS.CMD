             CMD        PROMPT('Copy Src Member To Archive')
             PARM       KWD(SRCFILE) TYPE(QUAL2) MIN(1) +
                          PROMPT('From source file')
             PARM       KWD(SRCMBR) TYPE(*CHAR) LEN(10) MIN(1) +
                          PROMPT('From source member')
             PARM       KWD(ARCIFSDIR) TYPE(*CHAR) LEN(255) +
                          DFT(*HOMEDIR) SPCVAL((*HOMEDIR *HOMEDIR)) +
                          MIN(0) PROMPT('Archive output IFS directory')
             PARM       KWD(HOMESUBDIR) TYPE(*CHAR) LEN(100) +
                          DFT('archivesource') MIN(0) PROMPT('Home +
                          subdir if *HOMEDIR set')
             PARM       KWD(OUTPUTFMT) TYPE(*CHAR) LEN(20) +
                          RSTD(*YES) DFT(*LIBFILEDIR) +
                          VALUES(*LIBFILEMBR *LIBFILEDIR) +
                          PROMPT('Output format')
             PARM       KWD(APPENDTS) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Append +
                          timestamp to file names')
             PARM       KWD(METAINFO) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*YES) VALUES(*NO *YES) PROMPT('Output +
                          .metainfo IFS file')
             PARM       KWD(REPLACE) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Replace +
                          existing IFS file')
             PARM       KWD(PROMPTSQL) TYPE(*CHAR) LEN(4) RSTD(*YES) +
                          DFT(*NO) VALUES(*NO *YES) PROMPT('Prompt +
                          SQL')
 QUAL2:      QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES) +
                          PROMPT('Library')
