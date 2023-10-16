
REM CIRCLE
REM px = cx + r * cos(angle)
REM py = cy + r * sin(angle)

10 sr# = 0.0 : PI# = 3.141592
20 bitmap on : bitmap clear $09 : cls

50 radius = 60 : cx = 200 : cy = 120

100 for t=0 to 360 : REM NOT RADIANS BUT WHATEV
110 sinproximate(t) : sint# = sr#
120 cosproximate(t) : cost# = sr#
130 px = int(cx + radius * cost#)
140 py = int(cy + radius * sint#)
200 plot color $45 to px,py
210 next

998 list : REM LOOKS NEAT :) 
999 end : REM SIN/COS LIBRARY
1000 proc sinproximate(x#)
1100    k = int(x#*2.0/PI#)
1200    y# = x# - k * PI# * 0.5
1300    q = k % 4
1400    if q = 0 then sinpart(y#)
1500    if q = 1 then sinpart(PI#*0.5-y#)
1600    if q = 2 
1700        sinpart(y#)
1800        sr# = sr# * -1
1900    endif
2000    if q = 3 
2100        sinpart(PI#*0.5-y#)
2200        sr# = sr# * -1
2300    endif
2310 endproc

2400 proc cosproximate(x#)
2410    sinproximate(x#-PI#/2)
2420 endproc
                         
2500 proc sinpart(x#)
2510    x2# = x# * x#
2520    x3# = x2# * x#
2530    x5# = x3# * x2#
2540    sr# = x# - x3# / 6.0 + x5# /  120.0
2550 endproc