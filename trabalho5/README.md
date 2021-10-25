# COC472 - Computação de Alto Desempenho

## Trabalho 05: Trabalho Final

### Descrição do trabalho

O trabalho consiste em rodar o benchmark [HPL](https://www.netlib.org/benchmark/hpl/) em paralelo e a perfilagem do código, utilizando um `gprof` por exemplo.

#### Resumo da teoria

O benchmark `HPL` consiste na resolução de um sistema `Ax = b` utilizanod o método de fatoração LU. A solução é feita utilizando pivoteamento.

#### Resumo da implementação paralela do algoritmo

A implementação paralela do algoritmo faz o pivoteamento parcial da matriz e as matrizes de permuta e triangular inferiores são aplicadas no vetor `b`.

#### Rpeak

O Rpeak da máquina utilizada é 115.2 GFLOPS.
> [Métricas](https://ark.intel.com/content/www/us/en/ark/products/196449/intel-core-i7-10510u-processor-8m-cache-up-to-4-80-ghz.html)

#### Exploração dos parâmetros

Os parâmetros foram explorados utilizando o script `run.sh`.

#### Melhor resultado - Rmax

Analisando o arquivo `data.csv` podemos dizer que o Rpeak é 39.56.

```python
import pandas as pd
df = pd.read_csv('./data.csv')
df.sort_values('Gflops')
```
