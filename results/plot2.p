# set terminal png transparent nocrop enhanced font arial 8 size 420,320
set output 'mygraph.png'
set xlabel "Message Type"
set ylabel "Requests per second"
set boxwidth 0.9 absolute
set style fill solid 1.00 border -1
set style histogram clustered gap 1 title offset character 0, 0, 0
set datafile missing '-'
set style data histograms
set xtics border in scale 1,0.5 nomirror rotate by -45 offset character 0, 0, 0
set xtics ("echoDoubles" 0.00000, "echoInts" 1.00000, "echoMeshInterfaceObjects" 2.00000, "echoSimpleEvents" 3.00000, "echoStrings" 4.00000)
set title "Large Data Sets(500 elements)\nResults from Apache Bench"
set yrange [ 0.00000 : 700. ] noreverse nowriteback
plot 'thin.dat' using 2:xtic(1) ti col, '' u 3 ti col
