10 a=0 : while 1 : poke $D6A0,209:for i=1 to 500:next:sound 1,int(rnd(1)*60)+300,1: poke $D6A0,a:for i=1 to 200:next :a=a+1:wend
