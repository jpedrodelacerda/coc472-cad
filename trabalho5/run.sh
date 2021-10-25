MAX_THREADS=$(lscpu | egrep '^CPU\(s\)' | awk '{print $2}')
P=(1 2)
Q=($MAX_THREADS $(($MAX_THREADS / 2)))
NBS=(32 64 128 256)
PMAP=(0 1)
PFACTS=(0 1 2)
OUTPUT_DIR=./data

echo "Starting script"
echo "#NBs = $NBS"
echo "MAX_THREADS"
for nbs in "${NBS[@]}"; do
  for p in "${P[@]}"; do
    for q in "${Q[@]}"; do
      for pmap in "${PMAP[@]}"; do
        for pfacts in "${PFACTS[@]}"; do
          OUTPUT_FILE="$OUTPUT_DIR/output-$nbs-$p-$q-$pmap-$pfacts.log"
          INPUT_FILE=./HPL.dat
          echo "" >> $INPUT_FILE
          echo "NBs = $nbs"
          echo "P = $p"
          echo "Q = $q"
          echo "PMAP = $pmap"
          echo "PFACTS = $pfacts"
          cat <<EOF > $INPUT_FILE
HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any)
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
14336        Ns
1            # of NBs
$nbs          NBs
$pmap            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
$p            Ps
$q            Qs
16.0         threshold
1            # of panel fact
$pfacts            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterium
4            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
1            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
1            DEPTHs (>=0)
2            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
##### This line (no. 32) is ignored (it serves as a separator). ######
0                               Number of additional problem sizes for PTRANS
1200 10000 30000                values of N
0                               number of additional blocking sizes for PTRANS
40 9 8 13 13 20 16 32 64        values of NB
EOF
          cp $INPUT_FILE ./data/HPL.dat
          docker run --rm -v ${PWD}/hpl-test/:/usr/local/hpl-2.2/HPLtest ashael/hpl HPLtest/run.sh -n $MAX_THREADS -t 1

          cp ./hpl-test/log.out $OUTPUT_FILE
        done
      done
    done
  done
done
