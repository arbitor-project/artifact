set term pdf font 'Verdana,60' size 15,10
ofile = sprintf("/root/results/sens.pdf")
input = sprintf("/root/results/sens.csv")

set datafile separator ","
set xrange [8:1]
set yrange [0:10]
set zrange [0:100]
set cbrange [0:100]
set ytics 0,2,10
set ztics 0,20,100
set xtics border offset 0,-0.2

set hidden3d
set palette functions gray, gray, gray

set grid xtics nomxtics ytics nomytics ztics nomztics nortics nomrtics nox2tics nomx2tics noy2tics nomy2tics nocbtics nomcbtics
set grid vertical layerdefault   lt 0 linecolor 0 linewidth 1.000,  lt 0 linecolor 0 linewidth 1.000
set xyplane at 0

set output ofile

splot input u 1:2:3 with lines t 'Full low-precision' lc 1 lw 1
