
set title "Several sizes from atom to universe"

set terminal png
set out "exercise01-01.png"

set grid xtics ytics

set xlabel "log10(x) value of the size"
set xrange [-11:30]
unset mxtics

plot 'exercise01-01.dat' using (log10($1)):0:yticlabels(2) title ""
