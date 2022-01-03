
set title "time and incidents of universe"

set terminal png
set out "exercise01-02.png"

set grid xtics ytics

set xlabel "log10(x) value of the time[s]"
unset mxtics

plot 'exercise01-02.dat' using (log10($1)):0:yticlabels(2) title ""
