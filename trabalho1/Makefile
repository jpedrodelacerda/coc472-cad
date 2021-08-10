CC=gcc
CFLAGS=-I
FC=gfortran
SRC_DIR=src
C_SRC_DIR=${SRC_DIR}/c
F90_SRC_DIR=${SRC_DIR}/fortran

TARGET_DIR=./target
PROJECT_NAME=product
C_PROJECT_FILE=${C_SRC_DIR}/${PROJECT_NAME}.c
C_PROJECT_BUILD=${TARGET_DIR}/c-${PROJECT_NAME}
F90_PROJECT_FILE=${F90_SRC_DIR}/${PROJECT_NAME}.f90
F90_PROJECT_BUILD=${TARGET_DIR}/f90-${PROJECT_NAME}

help:
	echo "Para entender como executar os projetos, leia o README da pasta"


compile-c: prepare
	gcc -o ${C_PROJECT_BUILD} ${C_PROJECT_FILE}

compile-f90: prepare
	${FC} -o ${F90_PROJECT_BUILD} ${F90_PROJECT_FILE};

run-c: ${C_BUILD_FILE}
	./${C_PROJECT_BUILD}

run-f90: ${F90_BUILD_FILE}
	./${F90_PROJECT_BUILD}

compile-and-run-c: compile-c run-c ${C_PROJECT_FILE}

compile-and-run-f90: compile-f90 run-f90 ${F90_PROJECT_FILE}

prune:
	rm -r assets/inputs/* assets/outputs/* target/*

create-csv: prepare
	echo "ORDER,LANG,LOOP_ORDER,TIME" > ./assets/output/times.csv

create-random-numbers:
	echo "Creating random numbers"


# Create temporary directory for the builds
prepare:
	mkdir -p assets/{inputs,outputs} ${TARGET_DIR}

# Remove builds and directory
clean:
	rm -rf ${TARGET_DIR}

run:
	echo "Not yet"
