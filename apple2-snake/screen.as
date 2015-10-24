*************
* PRINT ABC *
*************
*
PRINT EQU $FDF0
*
      LDA #"A"
      JSR PRINT
      LDA #"B"
      JSR PRINT
      LDA #"C"
      JSR PRINT
      RTS
      END
