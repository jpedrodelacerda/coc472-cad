PROGRAM PRODUCT
      ! REAL SIZE
      INTEGER, PARAMETER :: wp = 8 ! Work precision
      INTEGER, PARAMETER :: tp = 10 ! Time precision

!     Args:
      ! Matrix Order
      CHARACTER(len=255) :: argMatrixOrder
      CHARACTER(LEN=255) :: inputDir
      INTEGER :: matrixOrder
      ! Matrix A file to be read
      CHARACTER(len=255) :: aMatrixFile
      ! Vector X file to be read
      CHARACTER(len=255) :: xVectorFile

!     Variables:
      REAL(wp), ALLOCATABLE :: aMatrix(:,:)
      REAL(wp), ALLOCATABLE :: xVector(:)
      REAL(wp), ALLOCATABLE :: bVector(:)
      CHARACTER(LEN=2) :: loopOrder
!     Auxiliary Variables:
      REAL(tp) :: startTime, finishTime, elapsedTime

! PROCESS ARGS
      ! GET MATRIX ORDER AND CONVERT TO INTEGER
      CALL GET_COMMAND_ARGUMENT(NUMBER=1, VALUE=inputDir)
      CALL GET_COMMAND_ARGUMENT(NUMBER=2, VALUE=argMatrixOrder)
      READ(argMatrixOrder, '(i5)') matrixOrder
      CALL GET_COMMAND_ARGUMENT(NUMBER=3, VALUE=loopOrder)

      ! Format matrix input
      aMatrixFile = TRIM(ADJUSTL(inputDir))//TRIM(ADJUSTL(argMatrixOrder))//".matrix"
      ! Format vector input
      xVectorFile = TRIM(ADJUSTL(inputDir))//TRIM(ADJUSTL(argMatrixOrder))//".vector"

      ! ALLOCATE ARRAYS
      ALLOCATE(aMatrix(matrixOrder,matrixOrder))
      ALLOCATE(xVector(matrixOrder))
      ALLOCATE(bVector(matrixOrder))

      ! READ MATRIX A AND VECTOR x
      CALL read_matrix(matrixOrder, aMatrix, aMatrixFile, 1)
      CALL read_vector(matrixOrder, xVector, xVectorFile, 1)

      SELECT CASE (loopOrder)
         CASE ("ij")
            CALL multiply_matrix_vector_ij(matrixOrder, aMatrix, xVector, bVector, elapsedTime)
         CASE ("ji")
            CALL multiply_matrix_vector_ji(matrixOrder, aMatrix, xVector, bVector, elapsedTime)
         CASE DEFAULT
            DEALLOCATE(aMatrix)
            DEALLOCATE(xVector)
            DEALLOCATE(bVector)
            PRINT *, "LOOP ORDER MUST BE ONE OF: 'ij' OR 'ji'"
            CALL EXIT(1)
      END SELECT


      CALL log(matrixOrder, loopOrder, elapsedTime)
      DEALLOCATE(aMatrix)
      DEALLOCATE(xVector)
      DEALLOCATE(bVector)


      CONTAINS

      SUBROUTINE log(order, loopOrder, elapsedTime)
        implicit none

        INTEGER :: order
        CHARACTER(LEN=2) :: loopOrder
        REAL(10) :: elapsedTime
        CHARACTER(tp) :: timeSpent


        CHARACTER(LEN=255) :: logString

        WRITE (timeSpent, "(ES10.4)") elapsedTime
        timeSpent = TRIM(timeSpent)
        WRITE (logString,'(I6, A, A, A)') matrixOrder,",FORTRAN,", loopOrder//",", timeSpent

        WRITE (*,*) TRIM(ADJUSTL(logString))

      END SUBROUTINE

      SUBROUTINE multiply_matrix_vector_ij(order, inMatrix, inVector, outVector, elapsedTime)
        implicit none

        INTEGER :: order
        REAL(wp) :: inMatrix(:,:)
        REAL(wp) :: inVector(:)
        REAL(wp) :: outVector(:)
        REAL(tp) :: startTime, finishTime, elapsedTime

        INTEGER :: i,j

        CALL cpu_time(startTime)
        DO i = 1, order
           DO j = 1, order
              outVector(i) = outVector(i) + inMatrix(i,j) * inVector(j)
           END DO
        END DO
        CALL cpu_time(finishTime)
        elapsedTime = finishTime - startTime
      END SUBROUTINE

      SUBROUTINE multiply_matrix_vector_ji(order, inMatrix, inVector, outVector, elapsedTime)
        implicit none

        INTEGER :: order
        REAL(wp) :: inMatrix(:,:)
        REAL(wp) :: inVector(:)
        REAL(wp) :: outVector(:)
        REAL(tp) :: startTime, finishTime, elapsedTime

        INTEGER :: i,j

        CALL cpu_time(startTime)
        DO j = 1, order
           DO i = 1, order
              outVector(i) = outVector(i) + inMatrix(i,j) * inVector(j)
           END DO
        END DO
        CALL cpu_time(finishTime)
        elapsedTime = finishTime - startTime
      END SUBROUTINE

      SUBROUTINE read_matrix(order, matrix, filePath, unit)
        implicit none

        INTEGER :: order
        REAL(wp) :: matrix(:,:)
        CHARACTER(LEN=255) :: filePath
        INTEGER :: unit
        INTEGER :: i = 1

        OPEN (unit=unit, file=filePath, action='read')
        DO WHILE (i <= order)
           READ(unit,*) matrix(i,:)
           i = i + 1
        END DO
        END SUBROUTINE

      SUBROUTINE read_vector(order, vector, filePath, unit)
        implicit none

        INTEGER :: order
        REAL(wp) :: vector(:)
        CHARACTER(LEN=255) :: filePath
        INTEGER :: unit
        INTEGER :: i = 1


        OPEN (unit=unit, file=filePath, action='read')
        DO WHILE (i <= order)
           READ(unit,*) vector(i)
           i = i + 1
        END DO
      END SUBROUTINE
END
