5 REM SKI JR BY DIGAROK 
10 display_w = 80 : display_h = 60
20 scr = $C000: yline=(display_h-1)*display_w: soffs=scr+yline
30 dim ob(2,3): note_ch=0

50 note_idx=0: notes_len=48: dim notes(notes_len)
60 for n = 0 to notes_len-1: read v : notes(n) = v : next
70 data 426,507,639,853,426,507,639,-1
71 data 426,507,639,853,426,507,639,-1
72 data 380,452,639,853,380,452,639,-1
73 data 380,452,639,853,380,452,639,-1
74 data 338,426,569,667,338,426,569,-1
75 data 338,426,569,667,338,426,569,-1

100 quit = false
110 while quit = false
120  title()
130  play = 1: level = 0
140  while play = 1
150   level = level + 1
160   playlevel(level)
170   if level_len > 0 then play = -1
180   if level_len = 0 then if level = 5 then play = 0
190  wend
200  if play = 0 then youwin()
210  if play = -1 then youlose()
220  print "Press any key":k=get():cls:bitmap clear 0
230 wend

1000 proc playlevel(l)
1010  setlevel(l)
1020  levelintro()
1030  ski = true : colided = false
1040  bitmap clear level_bg_color
1050  while ski
1060   gennextline()
1070   skikeys()
1080   prline()
1090   playnote()
1100   if level_len > display_h-skier_y+5 then obstacle()
1110   poke 1,2:poke scr+((skier_y-1)*80)+skier_x,$22:poke scr+(skier_y*80)+skier_x,$E1
1200   collide()
1210   if colided = false
1220    print
1230    text str$(level_len) dim 1 color level_bg_color to 130,10
1240    level_len = level_len - 1
1250    text str$(level_len) dim 1 color 3 to 130,10
1260    if level_len = 0 then ski = false
1270   else 
1280    ski = false
1290    explode
1330   endif
1340  wend 
1350 endproc

1600 proc playnote()
1610  nextnote=notes(note_idx)
1620  note_idx = note_idx + 1 : if note_idx >= notes_len then note_idx = 0
1630  if nextnote > 0 then sound note_ch,nextnote,2
1640  note_ch = note_ch + 1: if note_ch = 3 then note_ch = 0 
1650 endproc

1700 proc wait(n)
1710  for i = 1 to n: next
1720 endproc

1800 proc levelintro()
1810  bitmap clear level_bg_color: q#=256/display_h
1820  for z=1 to display_h
1830   print
1835   if z=int(display_h/3) then text level_name$ dim 2 color (level_bg_color+c)%256 to 70,140
1840   if z%2=0
1850    c=int(rnd(1)*z*q#): ox=int(rnd(1)*3)-1: oy=int(rnd(1)*3)-1  
1860    text "GET READY"dim 2 color c to 80+ox,100+oy
1870   endif
1880  next  
1890  print "LEVEL ";: print l : REM TODO
1900 endproc

2000 proc gennextline()
2010  shiftl=int(rnd(1)*3)-1
2020  shiftr=int(rnd(1)*3)-1
2030  slx=slx+shiftl:srx=srx+shiftr
2040  if srx-slx<minw
2050   srx=srx+1:slx=slx-1
2055  endif 
2060  if slx<minx then slx=minx
2070  if srx>maxx then srx=maxx
2080  if srx-slx>maxw
2090   srx=srx-1:slx=slx+1
2100  endif
2110 endproc 

2200 proc skikeys()
2210  k=inkey()
2220  if k>0 then clearguy()
2230  if k=2 then skier_x=skier_x-1
2240  if k=6 then skier_x=skier_x+1
2260 endproc 

2300 proc prline()
2310  if level_len > display_h-skier_y+5 : REM TODO   
2320   poke 1,2:for x=0 to slx-1:poke soffs+x,level_grass_char:next 
2325   poke soffs+slx,level_border_char_l
2330   poke 1,3:for x=0 to slx-2:poke soffs+x,level_grass_color:next 
2335   poke soffs+slx,level_border_color: poke soffs+slx-1,level_border_color
2340   poke 1,2:for x=srx+1 to display_w:poke soffs+x,level_grass_char:next 
2345   poke soffs+srx,level_border_char_r
2350   poke 1,3:for x=srx+2 to display_w:poke soffs+x,level_grass_color:next 
2355   poke soffs+srx,level_border_color:poke soffs+srx+1,level_border_color
2356  endif
2360 endproc 

2400 proc collide()
2410  c=peek(scr+((skier_y+1)*display_w)+skier_x)
2420  if c<>$20 then colided = true
2430 endproc

2500 proc clearguy()
2510  poke 1,2:poke scr+((skier_y-1)*display_w)+skier_x,$20
2520 endproc 

2600 proc obstacle()
2605  if obsnext = 0 then obsnext = -4
2610  if obsnext = -1 
2620    obsnext = int(rnd(1)*(obsmax-obsmin))+obsmin
2630    obsx = -1
2650  else
2700   if obsnext > 0 then obsnext = obsnext -1 
2710   if obsnext < 0
2715    if obsx = -1 then obsx = int(rnd(1)*(srx-1-slx-1))+slx+1    : rem todo -1 -1 (is intentional but silly)
2720    loc=scr+((display_h-1)*display_w)+obsx
2730    poke 1,2:poke loc,ob(1,obsnext+5):poke loc+1,ob(2,obsnext+5)
2735    poke 1,3:poke loc,obscolor:poke loc+1,obscolor
2740    obsnext = obsnext + 1
2750   endif
2800  endif
2810 endproc

10000 proc title()
10005  title_bg = $8B
10010  cls:bitmap on:bitmap clear title_bg
10020  for i = 1 to 4 : text "Ski-Jr!" dim 4 color 256-i to 40+i,50+i: next
10030  for i = 1 to 30: print: next
10040  print "                            PRESS A KEY TO SKI!":k=get():cls
10050 endproc

10100 proc youlose()
10120  for i = 1 to display_h
10130    ox=int(rnd(1)*3)-1: oy=int(rnd(1)*3)-1
10140    text "BUMMER DUDE"dim 2 color 3+ox*oy to 35+ox,100+oy
10150    print
10160   next
10170 endproc

10200 proc youwin()
10210  bitmap clear title_bg:text "YOU DID IT!"dim 2 color 3 to 25,100
10220  for i = 1 to display_h
10230   ox=int(rnd(1)*3)-1: oy=int(rnd(1)*3)-1
10240   winnerguy(250+ox,15+oy)
10250   print
10260  next
10265  text "You are the Ski-JR!"dim 2 color 3 to 15,150
10270  sound 1,213,4: wait(3000):sound 1,213,3:  wait(1000):sound 1,213,4:
10272  wait(3000): sound 1,142,15
10280 endproc

10300 proc winnerguy(x,y)
10305  c=int(rnd(1)*256): c2 = $63+(int(rnd(1)*2)*$80)
10310  text "\O/" dim 2 color c to x,y
10320  text "|" dim 2 color c to x+17,y+20
10330  text "/" dim 3 color c2 to x+2,y+45
10340  text "/" dim 3 color c2 to x+14,y+45
10350  text "((" dim 2 color c to x+4,y+40
10400 endproc

11000 proc setlevel(l)
11005  obsnext=-1: skier_x=40: minx=3: maxx=display_w-minx
11006  level_border_char_l = $13: level_border_char_r = $13
11007  slx=20:srx=display_w-slx

11010 if l = 1
11020  skier_y=30: minw=20: maxw=50: level_len=200: level_name$="N00b Ridge"
11030  level_grass_color=$37: level_border_color=$58: level_bg_color=$FF
11040  level_grass_char = $16
11050  obsmin=15: obsmax=30: ob_tree()
11060 endif

11110 if l = 2
11120  skier_y=32: minw=15: maxw=40: level_len=220: level_name$="Frosty's Hill"
11130  level_grass_color=$A0: level_border_color=$88: level_bg_color=$DF
11140  level_grass_char=$17
11150  obsmin=5 : obsmax=25: ob_snowman()
11160 endif

11210 if l = 3
11220  skier_y=34: minw=10: maxw=30: level_len=240: level_name$="Sunset Valley"
11230  level_grass_color=$90: level_border_color=$66: level_bg_color=$85
11240  level_grass_char=$18
11250  obsmin=15 : obsmax=20: ob_barrier()
11260 endif

11310 if l = 4
11320  skier_y=36: minw=8: maxw=20: level_len=260: level_name$="Sweet Slopes"
11330  level_grass_color=$42: level_border_color=$58: level_bg_color=$DE
11340  level_grass_char=$19
11350  obsmin=3 : obsmax=5: ob_thang()
11360 endif

11410 if l = 5
11420  skier_y=38: minw=6: maxw=10: level_len=300: level_name$="Mount Foenix"
11430  level_grass_color=$E0: level_border_color=$58: level_bg_color=$FB
11440  level_grass_char=$15
11450  obsmin=10 : obsmax=15: ob_sled()
11490 endif
11600 endproc

12000 proc ob_tree()
12010  ob(1,1)=$EC:ob(2,1)=$ED:ob(1,2)=$E8:ob(2,2)=$E9:ob(1,3)=$E4: ob(2,3)=$E5
12020  obscolor=$30
12030 endproc

12100 proc ob_barrier()
12110  ob(1,1)=$1F:ob(2,1)=$1E:ob(1,2)=$BA:ob(2,2)=$BB:ob(1,3)=$BB: ob(2,3)=$BA
12120  obscolor=$E0
12130 endproc

12200 proc ob_snowman()
12210  ob(1,1)=$E2:ob(2,1)=$20:ob(1,2)=$B4:ob(2,2)=$20:ob(1,3)=$4F: ob(2,3)=$C0
12220  obscolor=$FF
12230 endproc

12300 proc ob_sled()
12310  ob(1,1)=$A4:ob(2,1)=$A8:ob(1,2)=$A4:ob(2,2)=$A8:ob(1,3)=$BE: ob(2,3)=$BF
12320  obscolor=$D0
12330 endproc

12400 proc ob_thang()
12410  ob(1,1)=$BC:ob(2,1)=$BD:ob(1,2)=$FC:ob(2,2)=$82:ob(1,3)=$20: ob(2,3)=$AE
12420  obscolor=$D0
12430 endproc