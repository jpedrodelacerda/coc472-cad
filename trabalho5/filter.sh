#!/bin/bash
echo "Creating csv headers"
echo "T/V,N,NB,P,Q,Time,Gflops" > ./data.csv
for log in data/*.log; do
    sed -n '49p' $log | sed -E 's/( )+/,/g' >> ./data.csv
done
