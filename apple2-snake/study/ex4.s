*
I       EQU $0
J       EQU $1
*
        ORG $800
        LDA J
        STA I
        LDA #$0
        STA J
        JMP $800
        END
