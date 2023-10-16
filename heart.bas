REM HEART 
REM ORIGINALLY FROM MY APPLE2 VIDEO: 
REM https://www.youtube.com/watch?v=FviGabUk0ns

REM FULL A2 CODE AS 1-liner
REM HGR:HOME:FOR T=0 TO 359:X=16*SIN(T)^3:Y=13*COS(T)-5*COS(2*T)-2*COS(3*T)-COS(4*T):FOR S=1 TO 3:HCOLOR = 4+S:B=150-(Y*S+75):HPLOT X*S+139,B:HPLOT X*S+140,B:NEXT:NEXT:VTAB 21:HTAB 15:?"SPREAD LOVE"


REM SIN RESULT, PI CONST
10 sr# = 0.0 : PI# = 3.141592
20 bitmap on : bitmap clear $EE : cls

100 for t=1 to 360
110 sinproximate(t) : st# = sr#
120 cosproximate(t) : ct# = sr#
130 cosproximate(2*t) : c2t# = sr#
140 cosproximate(3*t) : c3t# = sr#
150 cosproximate(4*t) : c4t# = sr#
160 x = int(16*(st#*st#*st#))
170 y = int(13*ct#-5*c2t#-2*c3t#-c4t)
180 for s=1 to 3
190 b=50+(y*s+75)
200 plot color $80 to x*s+159,b
210 next : next
220 for i = 1 to 120 : print "SPREAD LOVE!  ";: next : for i = 1 to 24:print: next



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