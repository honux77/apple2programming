*
PRINT   EQU $FDF0
*
START   ORG $8000
        LDA #"A"
LOOP    JSR PRINT
        ADC #1
        CMP #"Z"
        BNE LOOP
        BRK
        END
      
