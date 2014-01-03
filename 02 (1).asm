    .SYMBOLS ON	
	ORG	0000H
	JMP	START

	ORG	0050H

SPEAKER REG P1.0
TONE    REG R0
MCOUNT  REG R1
TEMPO   REG R2
TIME    REG R3
START:
        MOV   MCOUNT,#0  
        MOV   R4,#12
BEGIN:
        MOV   DPTR,#SCALE
        MOV   A,MCOUNT
        MOVC  A,@A+DPTR
        MOV   TONE,A
        INC   MCOUNT
        MOV   A,MCOUNT
        MOVC  A,@A+DPTR
        MOV   TEMPO,A
        ACALL SOUND
        INC   MCOUNT
        DJNZ  R4,BEGIN
        JMP   START

SOUND:
        MOV   TIME,#2
SOUND1:
        SETB  SPEAKER   ;SPEAKER=1
        ACALL SDELAY
        CLR   SPEAKER    ;SPEAKER=0
        ACALL SDELAY
        DJNZ  TIME,SOUND1
        DJNZ  TEMPO,SOUND
        RET

SDELAY:
        MOV   B,TONE
DELAY1: 
        MOV   R5,#6
        DJNZ  R5,$
        DJNZ  TONE,DELAY1
        MOV   TONE,B
        RET

SCALE:
        DB    85,49
        DB    85,49
        DB    75,110
        DB    85,98
        DB    63,130
        DB    67,247
        DB    85,49
        DB    85,49
        DB    75,110
        DB    85,98
        DB    63,130
        DB    67,247