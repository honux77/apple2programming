# APPLE 2e 게임 프로그래밍

## 멀린 어셈블러 사용법
1. 윈도우용 애플2 에뮬레이터 이미지 다운로드 (https://goo.gl/dLYymq) 및 적당한 폴더에 압축 해제
2. disk1 에 merlin 삽입
3. disk2 에 빈 디스크 사입
4. 멀린으로 부팅 (사과 아이콘)
6. 드라이브 교체: D
7. 에디트 모드: E
8. 라인 추가: A
9. 테스트 소스 작성
```
**************************
*     TEST CODE          *
**************************
        ORG   $8000
BELL    EQU   $FBDD
START   JSR   BELL
END     RTS     
```
* CTRL + P: 연속 *
* SPACE BAR, CTRL + p: 닫힌 *
* 에디터 종료: 첫 라인에서 엔터

10. 작성한 소스 리스트 확인: L
11. 어셈블: ASM
12. 저장하기 (파일이름에 S생략)
13. 오브젝트 저장하기
14. 디렉토리 확인: C
15. 어셈블러 종료: Q
16. 코드 실행: BRUN 프로그램 이름
- 기타 명령
```
D3,6 ;3번부터 6번까지 삭제
```

## 미니 어셈블러 사용법
- 애플2e 시작
- 도스로 부팅 또는 리셋 버튼 (에뮬레이터: ctrl + break) 을 눌러 베이직 프롬프트로
- 아래 명령 입력 (띄어쓰기 주의- )
```
] CALL -151
* F666G
!1000: LDA $C000
! BPL $1000
! STA $0468
! LDA $C010
! JMP $1000
공백에서 엔터
*1000G
아무 글자나 타이핑 해보기
중지하려면 리셋 버튼
```

## 시작 코드 지정하기
- 애플 베이직으로 부팅 프로그램 작성
- 실행할 바이너리 프로그램 이름은 PRGNAME으로 가정
```
10 D$=CHR$(4): PRINT D$;"BRUN PRGNAME"
```
- 해당 프로그램을 저장하고 INIT 프로그램으로 등록
```
SAVE MYBOOTING
INIT MYBOOTING
```
- 어셈블리 프로그램 이름을 PRGNAME 으로 저장
- 재부팅후 확인 