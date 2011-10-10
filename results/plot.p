# output as png image
set terminal png

# save file to "out.png"
set output "out.png"

# graph title
set title "Ruby webserver benchmark"

# nicer aspect ratio for image size
# set size 1,0.7

# y-axis grid
set grid y

# x-axis label
set xlabel "request"

# y-axis label
set ylabel "response time (ms)"

plot "webrick.dat" using 9 smooth sbezier with lines title "WEBrick", \
       "yarn.dat" using 9 smooth sbezier with lines title "Yarn", \
       "thin.dat" using 9 smooth sbezier with lines title "Thin"
