REM CITY SCAPE FANCY VARIANT
REM BASED ON https://github.com/thelbane/Apple-II-Programs/blob/master/short-programs/city-scape.md
REM ... not finished
10 bitmap on :bitmap clear 1 :cls
50 ymax=239 :xish = 40 :yish = 48

55 moond = int(rnd(1)*30)+30: 
56 moonx = 320-int(rnd(1)*15)-(moond)
57 moony=int(moond/2)+int(rnd(1)*(239-moond))
58 moon(moonx, moony, moond, $99)

60 for g = 0 to 239
70   th# = g/239 : r# = rnd(1) : if th# > r# then line color $21 from 0,g to 319,g
80 next

100 for n=0 to 3
110 i=0
120 for m=1 to 10
130 j=i+int(rnd(1)*3)+2:j=j-((j>xish)*(j-xish))
140 t=int(rnd(1)*(4-n)*yish)+n*yish
150 for x=i to j : y=t
160   while y <= ymax
170     if y%(4-n) = 0 then line color 0 from x*7,y to x*7+6,y
200     y=y+1
210   wend
220   i=j+1 : m=j=xish
240 next :next :next
 
499 end
500 proc moon(x,y,d, c)
510   circle colour c solid x,y to d+x,d+y
520 endproc



