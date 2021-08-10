#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

int read_matrix(char *filename, int order, double **matrix) {

  FILE *fp;

  fp = fopen(filename, "r");
  if (fp == NULL) {
    printf("Failed to read matrix at %s\n", filename);
    exit(1);
  }

  for (int i = 0; i < order; ++i) {
    for (int j = 0; j < order; ++j) {
      fscanf(fp, "%lf,", &matrix[i][j]);
    }
  }

  return 0;
}

double **create_matrix(char *filename, int order) {
  double **mp;
  int cols;

  mp = (double **)malloc((order) * sizeof(double));
  for (int i = 0; i < order; i++) {
    mp[i] = (double *)malloc(order * sizeof(double));
  }

  read_matrix(filename, order, mp);
  return mp;
}

int read_vector(char *filename, int order, double *v) {
  FILE *fp;

  fp = fopen(filename, "r");
  if (fp == NULL) {
    printf("Failed to read matrix at %s\n", filename);
    exit(1);
  }
  for (int i = 0; i < order; i++) {
    fscanf(fp, "%lf", &v[i]);
  }

  return 0;
}

double *create_vector(char *filename, int order) {
  double *v;
  v = (double *)malloc((order) * sizeof(double));

  read_vector(filename, order, v);

  return v;
}

double *multiply_matrix_ij(double **matrix, double *vector, int order) {
  double *bVec;

  bVec = (double *)malloc((order) * sizeof(double));

  clock_t start, finish;
  start = clock();
  for (int i = 0; i < order; i++) {
    for (int j = 0; j < order; j++) {
      bVec[i] += matrix[i][j] * vector[j];
    }
  }
  finish = clock();
  printf("%d,C,ij,%e\n", order, ((double)(finish - start)) / CLOCKS_PER_SEC);
  return bVec;
}

double *multiply_matrix_ji(double **matrix, double *vector, int order) {
  double *bVec;

  bVec = (double *)malloc((order) * sizeof(double));

  clock_t start, finish;
  start = clock();
  for (int j = 0; j < order; j++) {
    for (int i = 0; i < order; i++) {
      bVec[i] += matrix[i][j] * vector[j];
    }
  }
  finish = clock();
  printf("%d,C,ji,%e\n", order, ((double)(finish - start)) / CLOCKS_PER_SEC);
  return bVec;
}

int main(int argc, char *argv[]) {

  char *matrixPath = argv[1];
  char *vectorPath = argv[2];
  int order = atoi(argv[3]);
  char *loop_order = argv[4];

  double **aMatrix = create_matrix(matrixPath, order);
  double *xVector = create_vector(vectorPath, order);

  if (strcmp(loop_order, "ij") == 0) {
    multiply_matrix_ij(aMatrix, xVector, order);
  }
  else {
    multiply_matrix_ji(aMatrix, xVector, order);
  }

  free(aMatrix);
  free(xVector);
  return 0;
}
