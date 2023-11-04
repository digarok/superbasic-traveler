10    cls :bitmap on :bitmap clear 1
20    poke 1,2:adr=$C000
100   chartable(30,16)
4999  end 
5000  proc chartable(x,y)
5010    for ch_y=0 to 15
5020      for ch_x=0 to 15
5030        char=ch_x+(ch_y*16)
5040        poke 1,2:poke adr+(y+ch_y)*80+(ch_x+x),char
5045        poke 1,3:poke adr+(y+ch_y)*80+(ch_x+x),char
5050    next :next 
5060  endproc 
