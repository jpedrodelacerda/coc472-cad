# COC472 - Computação de Alto Desempenho

## Trabalho 01: Multiplicação de matrizes

### Descrição do trabalho
O objetivo do primeiro trabalho é criar projetos que devem realizar o produto Matriz-Vetor, `A * x = b` e estimar o desempenho dos mesmo e comparar os tempos de execução e o impacto da ordem dos loops aninhados no desempenho.

### Requisitos
- Os projetos devem ser feitos nas linguagens `C` e `Fortran`;
- Os arrays utilizados durante as operações devem ser aleatórios;

### Questões a serem respondidas

#### Estimando limites
> Estime o tamanho máximo dos arrays A, x e b que podem ser alocados no seu sistema para realização da tarefa.

#### Aleatoriedade
> Os arrays a serem utilizados durante as operações devem ser inicializados com números aleatórios.

#### Escalando o problema
> Comece com um problema de tamanho pequeno e tente chegar ao tamanho máximo estimado no item 1. Contabilize o tempo para realiação das operações para todos os tamanhos de sistema e para ambas as ordens de execução dos loops.

#### Curvas
> Apresente curvas mostrando o tempo de execução para cada dimensão do problema e relacione estas curvas à complexidade computacional do produto matriz - vetor `(O(n^2))`.

#### Organização dos arrays
> Explique como o modo em que os arrays são armazenados nas duas linguagens afetam os resultados.
