# 예제 코드 실습 사이트
1. easy6502: https://skilldrick.github.io/easy6502/simulator.html

# 윈본 문서
1. easy6502 by skilldrick: https://skilldrick.github.io/easy6502/

# 레퍼런스
1. http://www.6502.org/tutorials/6502opcodes.html

# Day 1
## Introduction
```
LDA #$01
STA $0200
LDA #$05
STA $0201
LDA #$08
STA $0202
```

* 애플의 인스트럭션은 주로 1~3 바이트로 되어 있다.따라서 코드를 실행하면 프로그램 카운터가 1/2/3씩 증가한다. 앞의 영어를 mnemonic (미모닉), 뒤의 숫자를 operand (오퍼랜드) 라고 부른다. 프로그램 카운터를 모른다면 뒤의 설명 참고

* \#은 숫자상수를 뜻하는 기호이며 $는 16진수를 나타내는 기호이다. #$08은 16진수 상수 0x08을 나타낸다. #이 없는 숫자는 메모리 주소를 나타낸다.

## 레지스터

* 6502에는 몇 개의 레지스터가 있다.
* A 레지스터: Accumulator의 약자이다. 일반적으로 상수를 저장하거나 계산한 결과값을 저장하는데 사용한다. A 레지스터의 값은 스택이나 메모리에 저장될 수 있다.
* SP 레지스터: 스택 포인터이다. 스택은 자료구조 또는 프로그래밍 언어에서 배우는 그 LIFO 자료구조로 1 byte push를 하면 감소하고 1byte pop을 하면 값이 증가한다. 초기값은 FF
* PC 레지스터: 프로그램 카운터. 우리가 작성한 어셈블리 코드는 기계어로 변환되고 메모리의 특정 위치에 저장되어 실행되는데 PC 레지스터는 현재 실행할 코드의 메모리 주소를 나타낸다.
* X 레지스터: X 인덱스 레지스터. 말처럼 인덱스로 사용. 추가기능 있음
* Y 레지스터: Y 인덱스 레지스터. X레지스터와 유사하지만 추가기능이 없다.
* CPU STATUS 레지스터: CPU의 상태를 나타내는 레지스터. 각 비트와 초기값은 아래와 같다.
* 자세한 내용은 http://www.obelisk.me.uk/6502/registers.html 참조
```
NV-BDIZC
00110000
;N,V,Z,C: 컨디션 코드 플래그
;N: NEGATIVE FLAG
;V: OVERFLOW FLAG
:Z: ZERO FLAG
;C: CARRY FLAG
;B: BREAK FLAG
;D: DECIMAL FLAG
;I: INTERRUPT DISABLE FLAG

```

## 예제 코드 2

* 6502 인스트럭션은 작은 기능의 집합이다. 아주 작은 함수라고 생각하면 이해가 쉬울 듯.
* 인스트럭션은 0개 또는 1개의 인자(오퍼랜드)를 갖는다.

```
LDA #$c0  ;Load the hex value $c0 into the A register
TAX       ;Transfer the value in the A register to X
INX       ;Increment the value in the X register
ADC #$c4  ;Add the hex value $c4 to the A register
BRK       ;Break - we're done
```

* 위 코드를 실행하면 A 레지스터에 0xC0 + 0xC4 = 0x184 가 아닌 84만 저장된다. (Why?) 그리고 CPU Status 레지스터의 마지막 비트(캐리 비트)에는 1이 세팅된다.
```
NV-BDIZC
10110001
```

```
LDA #$80
STA $01
ADC $01
```
* ADC 는 덧셈 명령이다. ADC #$01 은 A 레지스터에 1을 더하라는 명령이며 ADC $01은 메모리 1번지에 저장된 값을 A 레지스터에 더하라는 명령이다. 따라서 위 코드 실행화 A 레지스터에는 00이 저장된다. (0x80 + 0x80 = 0x0100)

## 인스트럭션
```
LDA #$01 ;A 레지스터에 1값을 로드함
LDX #$01 ;X 레지스터에 1값을 로드함
STA $01 ;메모리의 1번지에 A 레지스터의 값을 저장함
ADC #$0F ;A레지스터에 0F 값을 더함 (ADD WITH CARRY)
ADC $0F ;메모리의 0F 번지에 저장된 값을 A 레지스터에 더함
SBC #$0F ;A레지스터에 0F 값을 뺌 (SUB WITH CARRY)
TAX ;A레지스터의 값을 X 레지스터로
TXA ;자매품 1
TAY ;자매품 2
TYA ;자매품 3
INX ;X레지스터의 값을 1 증가
DEX ;X레지스터의 값을 1 감소
INY ;자매품
DEY ;자매품  
CLC ;CLEAR CARRY

```

# Day 2

## 브랜칭
```
  LDX #$08
DECREMENT:
  DEX
  STX $0200
  CPX #$03
  BNE decrement
  STX $0201
  BRK
```

* decrement는 라벨로 -첫번째 스페이스에 사용한 단어는 라벨로 간주된다 - 코드 점프의 분기점으로 사용된다.
* CPX는 COMPARE X의 의미로 X레지스터의 값을 주어진 값과 비교하여 값이 같을 경우 CPU STATUS의 Z플래그를 1로 만든다.
* 위 코드는 X에 8을 저장후 1씩 감소하면서 메모리의 0200번지에 해당 값을 기록
* X 레지스터 값이 3이 되면 해당 값을 0201 번지에 기록후 프로그램 종료

### 브랜치 관련 인스트럭션
```
CMP #$FF ;ACC와 상수FF의 값 비교
CPX #$08 ;X레지스터와 상수 8의 크기 비교, 같을 경우 Z=1, 클 경우 C=1, 작을 경우 N=1이 각각 세팅된다.
BNE label ;Branch Not Equal 비교한 값이 같지 않을 경우 (Z플래그가 0일 경우) 지정된 라벨로 점프
BEQ label ;Branch EQual 비교한 값이 같을 경우 지정된 라벨로 점프
BCC label ;Branch on Carry Clear CPU Status의 캐리 플래그가 0일 경우 점프
BCS label ;캐리플래그가 1일 경우 점프
BEQ - Branch if the zero flag is set.
BNE - Branch if the zero flag is clear.
BMI - Branch if minus (N=1).
BPL - Branch if plus (N=0).
BVS - Branch if overflow is set (V=1).
BVC - Branch if overflow is clear.
```

# day 3
## Addressing Modes
* 어드레싱 모드란 메모리의 특정 주소에 접근하는 방법을 말한다.
* 6502는 16비트 주소 버스를 사용하고 개별 바이트는 각각 독립적인 주소를 가지고 있다.
* 즉 65536개의 주소가 1 바이트마다 할당이 되므로 총 64KB의 메모리 공간을 사용할 수 있다.
* (참고: 애플2의 경우 일부 주소는 물리적인 IO 장치나 ROM / 서브루틴 등에 매핑되어 있다.)

### 절대 모드: $c000
* absolute 모드에서는 메모리의 개별 주소를 이용해서 직접 접근할 수 있다.
```
STA $c000 ;c000 번지에 A레지스터의 값을 저장한다.
```

### 제로 페이지: $c0
* 6502의 독특한 메모리 모드이다. 6502에서 첫 256바이트 공간 ($0000 - $00FF)을 제로 페이지라고 하며 1바이트 오퍼랜드로 엑세스할 수 있다. 페이지에 접근하기 위해 1바이트를 사용하므로, 절대모드보다 코드 크기는 작고 성능은 빠르다.

```
STA $00c0 ;A레지스터의 값을 $00C0 번지에 기록
STA $c0 ;위 명령과 동일한 제로 페이지 모드 명령어
```

### 제로 페이지,X; $C0,X
* x 레지스터의 값을 오퍼랜드의 상수 값과 더해서 해당 주소에 접근할 때 사용한다.

```
LDX #$00 ;X = $01
LDA #$64 ;A = #$64
STA $c0,X ;c0번지에 $64를 기록
INX ; X = X + 1
STA $c0,X ; c1번지에 $64를 기록
```

* 오퍼렌드가 기본 메모리 주소, x레지스터가 인덱스로 사용된다고 이해하면 될 듯.

### 제로 페이지,Y: $C0,Y
* 제로 페이지,X 와 같은 방식으로 동작한다. 자세한 차이는 다른 문서를 참고하자.

#### 절대,X 또는 절대,Y 모드:  $c0000,x 또는 $c0000,y
* 제로 페이지 주소 대신에 절대 주소 번지를 지정할 수도 있다.

```
LDX #$01
STA $0200,X ;$0201 번지에 A 레지스터의 값을 저장한다.
```

### 상수 모드: #$c0
* 엄밀히 말하면 메모리 모드는 아니지만, 여튼 #을 붙이면 상수를 나타낸다.

### 상대 모드: label
* 브랜치에서 라벨을 사용하면 실제 기계어에서는 상대 주소를 이용하게 된다. 자세한 설명은 생략
* 상대 주소란 '현재 주소부터 앞쪽(또는 뒤쪽) OO 바이트로 점프' 이런 식이라고 알고 있자.

### Indirect 모드: ($00f0)
* 지정한 메모리에서 2바이트를 읽고 해당 주소로 점프
* 주의사항: 첫번째 바이트가 LSB, 두번째 바이트가 MSB가 된다.
```
LDA #$01
STA $f0
LDA #$cc
STA $f1
JMP ($00f0) ;dereferences to $cc01
```

### Indexed Indirect: ($f0,X)
* 무언가 종합 선물 세트 같은 이 모드는 제로 페이지 메모리 주소에 X레지스터 값을 더한 곳의 주소에서 2바이트를 읽고 해당 위치의 메모리를 엑세스한다.
```
LDX #$01
LDA #$05
STA $01
LDA #$06
STA $02
LDY #$0a
STY $0605
LDA ($00,X)
```
* 위 코드의 마지막 명령은 제로페이지의 $00 $0001 번지부터 2바이트를 읽어 (05 06) 해당 번지 $0605 주소에 저장된 값 $0a를 A레지스터에 불러온다. (조금 어렵네요.)

### Indirect Indexed: ($f0), Y
* 위 내용을 이해했다면 표기법으로부터 어떤 차이가 나는지 대충 감이 올 것 같습니다.
* Indirect Indexed는 메모리 주소를 먼저 읽고 읽어진 값에 Y 인덱스 값만큼을 더해서 액세스를 합니다. 이 편이 요즘 보기에는 더 자연스러운 것 같습니다.
* 실제 코딩을 하게 되면 두 모드 모두 자주 사용하게 됩니다.

```
LDY #$01
LDA #$03
STA $01
LDA #$07
STA $02
LDX #$0a
STX $0704
LDA ($01),Y
```
* 코드에서 보는 것처럼 마지막 줄은 $0001 번지에서 두 바이트를 읽고 그 값인 $0703에 1을 더한 $0704에서 값을 읽어옵니다. A 레지스터에는 최종적으로 #$0a값이 들어갑니다.

# 4일차
## 스택
* 스택(Stack)은 접시가 쌓여있는 형태의 자료구조로 후입선출(LIFO - Last In First Out)의 자료구조이다.
* 6502는 메모리의 1번 페이지 ($0100 - $01FF)를 스택으로 사용한다.
* 스택의 값은 스택 레지스터로 접근할 수 있다. 스택 레지스터의 초기값은 앞서 설명한 것처럼 $FF이다. push 명령에 의해 1감소하고, Pop 명령에 의해 1 증가한다.
* 관련 인스트럭션은 PHA (PusH Accumulator), PLA (PuLL Accumulator) 두 종류가 있다.
```
  LDX #$00
  LDY #$00
firstloop:
  TXA
  STA $0200,Y
  PHA
  INX
  INY
  CPY #$10
  BNE firstloop ;loop until Y is $10
secondloop:
  PLA
  STA $0200,Y
  INY
  CPY #$20      ;loop until Y is $20
  BNE secondloop
```
 * 위 코드 실행 후의 메모리는 아래와 같이 된다.
```
0200: 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
0210: 0f 0e 0d 0c 0b 0a 09 08 07 06 05 04 03 02 01 00
0220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
```

# day 5
## Jump
### JMP: 조건 없는 점프
* JMP 는 말 그대로 조건 없이 해당 라벨로 점프한다.

```
  LDA #$03
  JMP there
  BRK
  BRK
  BRK
there:
  STA $0200
```
* 실행 결과
```
0200: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
```

### JSR / RTS
* JSR(Jump to SubRoutine)과 RTS(Retrun from subroutine)은 항상 쌍으로 사용되는 명령이다.
* JSR 은 다른 특정 라벨로 이동하고 RTS는 원래 자리로 돌아오는데 사용한다.
* JSR은 점프하기 전에 스택에 현재 위치를 저장하고 RTS는 그걸 POP해서 원래 위치로 돌아간다.
* 고급 언어의 함수 또는 메소드와 유사하다고 생각하면 된다.

```
  JSR init
  JSR loop
  JSR end

init:
  LDX #$00
  RTS

loop:
  INX
  CPX #$05
  BNE loop
  RTS

end:
  BRK
```
* JSR / RTS의 동작으로 보기 위해서는 PC 레지스터, SP 레지스터, 그리고 스택의 $01FE, $01FF에 저장되는 값을 잘 살펴보면 된다.
