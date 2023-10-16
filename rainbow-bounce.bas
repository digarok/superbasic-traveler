10 bitmap on: bitmap clear 5 : rect colour $20 solid 0,209 to 319,239
20 for i = 1 to 60 : print : next : REM FUN CLEAR :P 
30 maxy=200 : vx=1 : vy#=0 : x=20 : y=50 : gc#=0.3 : REM FAKE PHYSICS VALUES
100 circ(x,y,int(rnd(1)*255))
110 movex() : movey() : goto 100

500 proc circ(x,y,c)
510   circle colour c solid 0+x,0+y to 9+x,9+y
520 endproc

600 proc movex()
610   x=x+vx
620   if x=320-10 then vx=-1 : sound 1,200,1
630   if x=0 then vx=1 : sound 1,200,1
640 endproc

700 proc movey()
710   y=y+int(vy#)
720   if y>maxy
730     y=maxy:vy#=vy#*-0.98
740     s=int(rnd(1)*60) : sound 1,s+700,2 : sound 1,s+720,2
750   else
760     vy#=vy#+gc#
770   endif
780   rem uncomment to see debug ->> print vy#,y
790 endproc
