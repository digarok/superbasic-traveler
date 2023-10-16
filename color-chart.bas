REM COLOR CHART

10 bitmap on :bitmap clear 0 :cls
20 cs$ = "0123456789ABCDEF"
30 spc = 12
40 for row = 0 to 15
50   text mid$(cs$,row+1,1) color $FF to 20+(row*spc),10
60   text mid$(cs$,row+1,1) color $FF to 10,20+(row*spc)
70   for col = 0 to 15
80     box(20+(col*spc),20+(row*spc),((row*16)+col))
90 next :next

99 end
100 proc box(x,y,c)
110   rect colour c solid 0+x,0+y to 7+x,7+y
120 endproc