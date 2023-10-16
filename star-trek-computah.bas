10 a=0
20 poke $D6A0,209:for i=1 to 500:next
30 sound 1,int(rnd(1)*60)+300,1
40 poke $D6A0,a:for i=1 to 200:next :a=a+1:goto 20
