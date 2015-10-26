*
* HELLO WORLD
*
PRINT EQU $FDF0
*
START     ORG $8000
          LDX #$0
LOOP      INX
          LDA STRING,X
          JSR PRINT
          CPX STRING
          BLT LOOP
          RTS
STRING    STR "HELLO, NEXT"
          END
