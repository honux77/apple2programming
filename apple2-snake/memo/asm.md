# APPLE2 ASSEMBLY GUIDE
## 명령어 형식
```
LABEL MNEMONIC OPERAND ;COMMENTS
```

## LABEL

- LABEL 은 대문자 / 숫자로 6자 이내

## 명령어

### LOAD

- LDA: Loading a constant into the accumulator
- LDA $1000 ; Loading a value at memory location $1000
- LDA #$1000 ;LDA #$00
- LDA /$1000 ;LDA #$10
- LDA /$FF   ;LDA #$00 ($FF = $00FF)

### STORE

- STA: Store data from accumulator
- TXA: Transfer data from the X-register to accumulator
- TYA
- TAX
- TAY
- TXS: X to SP

## INCREMENT / DECREMENT REGISTER

- INX: Takes the value from X, adds one, and leaves the result in the X
- INY
- DEX
- DEY

## INCREMENT / DECREMENT

- INC $2255
- DEC $0F


## LABELS AND VARIABLES

- LABEL EQU <value> : LABEL을 변수처럼 사용 가능, 단 어드레싱 모드에서는 절대 모드로만 동작
- LABEL EQZ <value> : value <= FF, 제로 페이지 어드레싱으로 사용 가능
- LABEL DFS <value> : 적당한 자리에 값을 저장

## 오퍼랜드의 추가 연산자

- 간단한 덧셈 / 뺄셈 가능
XCOORD EQU $800
       LDA #$0
       STA XCOORD
       STA XCOORD+$1

## 예제 코드
