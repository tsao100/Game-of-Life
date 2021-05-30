; MouseOn routine called by TEST.FOR
; Assemble with ML /c kbhit.ASM

        .MODEL LARGE, FORTRAN

kbhit	PROTO	FORTRAN

        .CODE

kbhit	PROC	 FORTRAN

        mov     ah, 1
	    int	    16h
        jz      bye
        mov     ah,0
        int     16h
        mov     ah,0
bye:    ret
kbhit	ENDP
        END
