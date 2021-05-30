C      PROGRAM TEST
      INCLUDE  'FGRAPH.FI'
      INCLUDE  'FGRAPH.FD'
      INTEGER*2 M1, M2, M3, M4, RET
      INTEGER G, row, col, num(1:80, 1:25)
      RECORD / rccoord / curpos
      CHARACTER*7        str

      INTEGER*2            dummy
      dummy = setvideomode( $TEXTC80 )
      CALL clearscreen( $GCLEARSCREEN )
C      dummy = setvideomode( $DEFAULTMODE )

      dummy = displaycursor( $GCURSOROFF )
      G=1
      M1=1
      CALL MOUSEL(M1, M2, M3, M4)
      DO WHILE (M2.NE.2)
	  M1=3
	  M2=0
	  CALL MOUSEL(M1, M2, M3, M4)
	  IF (M2 .EQ. 1) THEN
	    row = M4/8+1
	    col = M3/8+1
	    IF (row.LE.24 .AND. col.LE.80) THEN
	     num(col, row)=1
	     CALL settextposition( row, col, curpos )
	     CALL MOUSEL(2, M2, M3, M4)
	     CALL outtext( 'O' )
	     CALL MOUSEL(1, M2, M3, M4)
	     CALL settextposition( 1,1, curpos )
	     WRITE (str, '(I3 I3)') col, row
	     CALL outtext( '  ' // str )
	    END IF
C	  WRITE(*,*) 'O'
	END IF
C	IF (M2 .EQ. 2) THEN
C	  EXIT
C	END IF
      RET = KBHIT()
      IF ((CHAR(RET) .EQ. 'N').OR. (CHAR(RET) .EQ. 'n')) THEN 
	    CALL MOUSEL(2, M2, M3, M4)
        CALL clearscreen( $GCLEARSCREEN )
        CALL settextposition( 25,1, curpos )
C        WRITE (str, '(A A)') "Next Generation.", CHAR(RET)
        WRITE (str, '(I7)') G
        CALL outtext( 'Next Generation: ' // str)
        G=G+1
        CALL life_update (  80, 24, num)

        do j = 1, 24
         do i = 1, 80
            if ( num(i,j) .eq. 1 ) then
	          CALL settextposition( j, i, curpos )
              CALL outtext( 'O' )
            end if
         end do
        end do
	    CALL MOUSEL(1, M2, M3, M4)

      END IF
      IF ((CHAR(RET) .EQ. 'M').OR. (CHAR(RET) .EQ. 'm')) THEN 
        CALL settextposition( 25,1, curpos )
        CALL outtext( '  New Input Map' )
      END IF
      END DO
      END

      subroutine life_update (  m, n, grid)
      implicit none

      integer m
      integer n

      integer grid(1:80,1:24)
      integer i, U, D, L, R
      integer j
      integer s(1:80,1:24)

      do j = 1, n
        do i = 1, m
          U = j-1
          D = j+1
          L = i-1
          R = i+1
          if (U .EQ. 0)  U=24
	  if (D .EQ. 25) D=1
          if (L .EQ. 0)  L=80
          if (R .EQ. 81) R=1

          s(i,j) = grid(L, U) + grid(L, j) + grid(L, D)
     +           + grid(i, U)              + grid(i, D)
     +           + grid(R, U) + grid(R, j) + grid(R, D)

        end do
      end do
c
c  Any dead cell with 3 live neighbors becomes alive.
c  Any living cell with less than 2 or more than 3 neighbors dies.
c

       do j = 1, n
        do i = 1, m

          if ( grid(i,j) .eq. 0 ) then
            if ( s(i,j) .eq. 3 ) then
              grid(i,j) = 1
            end if
          else if ( grid(i,j) .eq. 1 ) then
            if ( s(i,j) .lt. 2 .or. 3 .lt. s(i,j) ) then
              grid(i,j) = 0
            end if
          end if

        end do
      end do

      return
      end
