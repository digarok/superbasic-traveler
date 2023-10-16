REM CITY SCAPE
REM BASED ON https://github.com/thelbane/Apple-II-Programs/blob/master/short-programs/city-scape.md
REM ... not finished
10 bitmap on :bitmap clear 1 :cls
50 ymax=239 :xish = 40 :yish = 48

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
220   i=j+1 :m=j=xish
240 next :next :next





