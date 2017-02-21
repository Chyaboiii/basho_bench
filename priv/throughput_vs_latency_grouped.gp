set terminal pdfcairo font 'Verdana,10' linewidth 1 rounded fontscale 0.8

set style line 11 lc rgb '#808080' lt 1
set tics nomirror

set style line 12 lc rgb '#808080' lt 0 lw 1

set style line 1 dashtype 1 lc rgb '#E31A1C' pt 6 ps 1 lt 1 lw 3
set style line 2 dashtype 2 lc rgb '#387DB8' pt 4 ps 1 lt 1 lw 3

set output outputname
set datafile separator ','

set xlabel "Mean Throughput (ops/sec)"
set ylabel "Mean Latency (ms)"

set key horizontal outside box 3

set datafile missing '0'

plot inputone using 2:($3/1000) title titleone smooth bezier with lines ls 1, \
     inputtwo using 2:($3/1000) title titletwo smooth bezier with lines ls 2