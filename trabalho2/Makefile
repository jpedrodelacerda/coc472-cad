CC=g++
SRC_DIR=src
CFLAGS=-g -pg
TARGET_DIR=./target
PROJECT_NAME=laplace
PROFILE_DIR=./profiles
R_PREFIX=refactor_
PROJECT_FILE=${SRC_DIR}/${PROJECT_NAME}.cpp
REFACTOR_FILE=${SRC_DIR}/${R_PREFIX}${PROJECT_NAME}.cpp
PROJECT_BUILD=${TARGET_DIR}/${PROJECT_NAME}
REFACTOR_PROJECT_BUILD=${TARGET_DIR}/${R_PREFIX}${PROJECT_NAME}
REFACTORED_PROJECT_BUILD=${TARGET_DIR}/${PROJECT_NAME}


help:
	echo "Para entender como executar os projetos, leia o README da pasta"

compile: prepare
	${CC} ${CFLAGS} -o ${PROJECT_BUILD} ${PROJECT_FILE}

run: compile
	echo "500 100 0.0000000000000001" | ${TARGET_DIR}/${PROJECT_NAME}
	mv gmon.out ${TARGET_DIR}/gmon.out

profile: run
	gprof ${TARGET_DIR}/${PROJECT_NAME} ${TARGET_DIR}/gmon.out > ${PROFILE_DIR}/profile.txt

compile-refactor: prepare
	${CC} ${CFLAGS} -o ${REFACTOR_PROJECT_BUILD} ${REFACTOR_PROJECT_FILE}

run-refactor: compile-refactor
	echo "500 100 0.0000000000000001" | ${TARGET_DIR}/${R_PREFIX}${PROJECT_NAME}
	mv gmon.out ${TARGET_DIR}/${R_PREFIX}gmon.out

profile-refactor: run-refactor
	gprof ${TARGET_DIR}/${PROJECT_NAME} ${TARGET_DIR}/${R_PREFIX}gmon.out > ${PROFILE_DIR}/${R_PREFIX}profile.txt

prune:
	rm -r target/*
	rm -r profiles/

# Create temporary directory for the builds
prepare:
	mkdir -p ${TARGET_DIR}

# Remove builds and directory
clean:
	rm -rf ${TARGET_DIR}
