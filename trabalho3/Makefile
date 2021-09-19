CC=g++
SRC_DIR=src
TARGET_DIR=./target
PROJECT_NAME=laplace
PROFILE_DIR=./profiles
R_PREFIX=refactor_
PROJECT_FILE=${SRC_DIR}/${PROJECT_NAME}.cpp
REFACTOR_PROJECT_FILE=${SRC_DIR}/${R_PREFIX}${PROJECT_NAME}.cpp
PROJECT_BUILD=${TARGET_DIR}/${PROJECT_NAME}
REFACTOR_PROJECT_BUILD=${TARGET_DIR}/${R_PREFIX}${PROJECT_NAME}
REFACTORED_PROJECT_BUILD=${TARGET_DIR}/${R_PREFIX}${PROJECT_NAME}


help:
	echo "Para entender como executar os projetos, leia o README da pasta"

compile: prepare
	${CC} ${CFLAGS} -o ${PROJECT_BUILD} ${PROJECT_FILE}

run: compile
	echo "500 100 0.0000000000000001" | ${TARGET_DIR}/${PROJECT_NAME}

compile-refactor: prepare
	${CC} ${CFLAGS} -o ${REFACTOR_PROJECT_BUILD} ${REFACTOR_PROJECT_FILE}

run-refactor: compile-refactor
	echo "500 100 0.0000000000000001" | ${REFACTOR_PROJECT_BUILD}

compile-all: compile compile-refactor

prune:
	rm -r target/*

# Create temporary directory for the builds
prepare:
	mkdir -p ${TARGET_DIR}

# Remove builds and directory
clean:
	rm -rf ${TARGET_DIR}
