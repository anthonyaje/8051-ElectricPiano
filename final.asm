    .SYMBOLS ON
SPEAKER REG P1.0
TONE    REG R0
MCOUNT  REG R1
TEMPO   REG R2
TIME    REG R3	
    ORG 00H
    JMP START
    ORG 0FH

START:
        MOV        P1,#0
        MOV MCOUNT,#0        ;read the 1st row of table
        MOV R4,#0        
BEGIN:
        ;MOV MCOUNT,#0
        ;JMP BEGIN2
        MOV P0,#00001111B
        
        MOV P3,#01111111B
        JNB P2.0,L0
        JNB P2.1,L1
        JNB P2.2,L2
        JNB P2.3,L3

        MOV P3,#10111111B
        JNB P2.0,L4
        JNB P2.1,L5
        JNB P2.2,L6
        JNB P2.3,L7
        
        MOV P3,#11011111B
        JNB P2.0,MUSICBOX
        
        JMP BEGIN
        
L0:
        MOV MCOUNT,#0        ;read the 1st row of table
        MOV R4,#1        ;choose the one entry from table
        MOV P0,#00000010B ;led
        CALL BEGIN2        ;call the buzzer function
        JMP BEGIN

L1:
        MOV MCOUNT,#2        ;read the 2nd row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00000011B ;led
        CALL BEGIN2
        JMP BEGIN

L2:
        MOV MCOUNT,#4        ;read the 2nd row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00000111B ;led
        CALL BEGIN2
        JMP BEGIN
        
L3:
        MOV MCOUNT,#6        ;read the 1st row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00000010B ;led
        CALL BEGIN2        ;call the buzzer function
        JMP BEGIN

L4:
        MOV MCOUNT,#8        ;read the 2nd row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00000011B ;led
        CALL BEGIN2
        JMP BEGIN

L5:
        MOV MCOUNT,#10        ;read the 2nd row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00000111B ;led
        CALL BEGIN2
        JMP BEGIN
        
L6:
        MOV MCOUNT,#12        ;read the 2nd row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00000111B ;led
        CALL BEGIN2
        JMP BEGIN        
L7:
        MOV MCOUNT,#14        ;read the 2nd row of table
        MOV R4,#1        ;choose the first entry from table
        MOV P0,#00001111B ;led
        CALL BEGIN2
        JMP BEGIN
        

MUSICBOX:
        MOV MCOUNT,#16
        MOV R4, #29               
        CALL BEGIN2
        
        JMP BEGIN

        
BEGIN2:
        MOV     DPTR,#SCALE
        MOV     A,MCOUNT
        MOVC    A,@A+DPTR
        MOV     TONE,A
        INC     MCOUNT
        MOVC    A,@A+DPTR
        MOV     TEMPO,A
        ACALL   SOUND
        INC     MCOUNT
        DJNZ    R4,BEGIN2
        
        RET

SOUND:
        MOV     TIME, #2
sound1:
        SETB    SPEAKER
        ACALL   SDELAY
        CLR     SPEAKER
        ACALL   SDELAY
        DJNZ    TIME,sound1
        DJNZ    TEMPO,SOUND
        RET

SDELAY:
        MOV     B,TONE
delay1:
        MOV     R5,#2
        DJNZ    R5,$
        DJNZ    TONE,delay1
        MOV     TONE,B
        RET
END
SCALE:
    DB    126,50        ;do
    DB    113,95        ;re
    DB    100,255        ;mi
    DB    95,100        ;fa
    DB    85,150        ;sol
    DB    75,255        ;la
    DB    67,255        ;si
    DB    63,255        ;Do
    DB    126,50        ;do
    DB    126,50        ;do
    DB    113,95        ;re
    DB    126,50        ;do
    DB    95,140        ;fa
    DB    100,255        ;mi
    DB    126,50        ;do
    DB    126,50        ;do
    DB    113,95        ;re
    DB    126,50        ;do
    DB    85,196        ;sol
    DB    95,140        ;fa
    DB    126,50        ;do
    DB    126,50        ;do
    DB    63,255        ;Do
    DB    75,255        ;la
    DB    75,255        ;la
    DB    75,255        ;la
    DB    95,140        ;fa
    DB    100,255        ;mi
    DB    113,95        ;re
    DB    67,255        ;si
    DB    67,255        ;si
    DB    75,255        ;la
    DB    75,255        ;la
    DB    75,255        ;la
    DB    95,140        ;fa
    DB    85,196        ;sol
    DB    95,140        ;fa

