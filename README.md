# SuperBASIC Programs
Fun programs and reference documentation for SuperBASIC on the F256 family of computers

### Usage
Copy these basic files to an SD card and run from your F256K like `run circle.bas` 

### Video
There's a silly video to go with this content here:
https://youtu.be/d8JnxXg3v24

### Programs
- [star-trek-computah.bas](star-trek-computah.bas) : My first F256 program! Blinken and bloopen...
- [rainbow-bounce.bas](rainbow-bounce.bas) : my second program, experimenting with the circle drawing and creating some very sus physics
- ![rainbow-bounce](/doc/img/20231015_223840_cropped.png?raw=true "rainbow-bounce.bas")
- [city.bas](city.bas) : Draw a city with some simple for loops - (unfinished, may crash)
- ![city.bas](/doc/img/20231015_223609_cropped.png?raw=true "city.bas")
- [city2.bas](city2.bas) : Add some spice to the city - (unfinished, may crash)
- ![city2.bas](/doc/img/20231015_223410_cropped.png?raw=true "city2.bas")
- [color-chart.bas](color-chart.bas) : Makes it easy to see color values and differences in your chart
- ![color-chart.bas](/doc/img/20231015_223758_cropped.png?raw=true "color-chart.bas")
- [sin.bas](sin.bas) : A library for *sine* and *cosine* approximations (procs) called `sinproximate()` and `cosproximate()`
- [drawsin.bas](drawsin.bas) : Visual demo of the sin/cos procs from above
- ![drawsin.bas](/doc/img/20231015_223714_cropped.png?raw=true "drawsin.bas")
- [circle.bas](circle.bas) : Use `sin.bas` library to draw a circle
- ![circle.bas](/doc/img/20231015_223645_cropped.png?raw=true "circle.bas")
- [heart.bas](heart.bas) : Calculate more advanced example of why we want to have sin/cos in our BASIC! :)
- ![heart.bas](/doc/img/20231015_223943_cropped.png?raw=true "heart.bas")
- [heart2.bas](heart2.bas) : Fun/fancy version
- ![heart2.bas](/doc/img/20231015_224048_cropped.png?raw=true "heart2.bas")

### Games
- [ski-jr.bas](ski-jr.bas) : Are you good enough to be the Ski Jr?!
- ![ski-jr.bas](/doc/img/ski_jr_title.png?raw=true "ski-jr.bas")]
- ![ski-jr.bas](/doc/img/ski_jr_game.png?raw=true "ski-jr.bas")]

### About SuperBASIC and Gotchas
Based on the BBC BASIC variant, I found some great additions, as well as some pitfalls when coming from other BASICs like AppleSoft (A Microsoft variant).  

This is not exhaustive, nor meant to be a shootout between BASICs since there are things I like and don't like about all BASICs.  I'm an equal opportunity hater. ;)  But if you're using SuperBASIC on a F256K computer, it's quite fast and capable.  Adding in sprites and bitmap graphics, one can make some fairly serious programs.

#### `FOR LOOP` STEPPING
A common pattern in for loops is to skip numbers or count backwards.  

Example 1a - AppleSoft for loop with STEP
```
FOR I = 1 TO 20 STEP 5
```
Produces range `[1, 6, 11, 16]`

This is not supported in SuperBASIC.  One might think, "I can produce the same values by iterating FOR 1 TO 4 and adding +5 every loop."  But this dramatically changes the logic if we don't know how many iterations we'll be doing, as is the case when using a variable, like `FOR I = 1 to Y`.  

An initial idea I had is that classic use of a modulus operator inside of a loop. But it gets messy and is not really reasonable to use/debug. 

Luckily, SuperBASIC implements a `WHILE` block that is effectively the same structure we want.

Example 1b - SuperBASIC WHILE loop
```
100 i = 1
110 while i <= 20
120   print i
130   i = i + 5
140 wend
```
Produces range `[1, 6, 11, 16]`

If you are familiar with the C style for construct you can think of it that way, e.g. `for(i=1; i<=20; i+=5)`.

##### `FOR LOOP` NEGATIVE STEPPING
Another common pattern is counting backwards using `FOR`.

Example 2a - **AppleSoft** BASIC negative STEP:
```
FOR I = 10 TO 1 STEP -1
```
Produces range `[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]`

In this case, there is a directly analogous way of doing this in SuperBASIC with `FOR`/`DOWNTO`.

Example 2b - **SuperBASIC counting down by 1 with DOWNTO:
```
for i = 10 downto 1
```
Produces range `[10, 9, 8, 7, 6, 5, 4, 3, 2, 1]`

But if we want to skip numbers, say `STEP -3`, then we would need to reimplement the SuperBASIC code using something like the while loop example above. 


#### `PROC` AND RESULTS ALA FUNCTIONS
While SuperBASIC supports classic `GOTO`/`GOSUB`, it denounces their use. (Silly.)  Instead it offers `PROC` which lets you create a _callable by name_ procedure, with arguments!!  Admittedly with this, you shouldn't ever need to use GOSUB, and the ability to call by _name_ instead of _line number_ will benefit any program you are writing. 

However, using PROC does change the style of my program a little bit so I think it's worth covering some design patterns I'm using to try to "keep things clean".

Example 3a - SuperBASIC `PROC` example from the manual
```
100 endgame()
110 end
120 proc endgame()
130   print "You lose !"
140 endproc
```
This should be sufficient to explain how a PROC works in general.  Line 120 contains our procedure, `endgame`.  We just call that once when the program starts on line 100 then end on 110. 

##### POINT 1 - `PROC` END
That `end` is critically important, as your program will crash if it runs into a proc without calling it. I've taken to the pattern of starting procs on major line numbers (say, hundreds), and putting an end before it. 

Example 3b - SuperBASIC `PROC` END close together:
```
10 playintrosong()


799 end ; REM "INTRO SONG ROUTINE"
800 proc playintrosong()
810   for i = 1 to 10 : sound 1,int(rnd(1)*60)+300,1 : next
820 endproc
```

##### POINT 2 - `PROC` RESULTS
One wonderful thing about `PROC` is that it can be called with arguments, and  those arguments are scoped to the PROC.

Example 3c - Calling PROC with arguments, from the SuperBASIC manual:
```
100 printmessage(“hello”,42)
110 end
120 proc printmessage(msg$,n)
130   print msg$+“world x “+str$(n)
140 endproc
```
Above, `msg$` only exists in the scope of the proc, but you can of course still reference variables outside of that scope.  

It's natural to want to call a `PROC` like a function where it can return a result.  Unfortunately I haven't found that this is implemented.  This means if you had a proc called `cube(x)`, you can't write code that uses it like `result = cube(x)`.

Currently the method I (and apparently some others) use is to store the result in a known location and then I reassign it to the desired variable immediately after the call, on the same line. 

Example 3d - PROC with postfix assignment
```
10 rs = 0 : REM RESULT HOLDER
50 cube(3) : x = rs
60 cube(4) : y = rs
70 cube(5) : z = rs
80 print x, y, z
99 end
100 proc cube(n)
110   rs = n * n * n
120 endproc
```
Perhaps it's not ideal but it keeps the code from getting too ugly and youve basically unlocked full functions with results _and_ you can of course have multiple results if you want. 

#### A QUICK NOTE ABOUT MODULUS `%`
It's really helpful to  have a built-in modulus operator as SuperBASIC does.  You will find it very handy for all sorts of interesting and fun maths.

Without a modulus operator, I always had to implement it using the classic integer math cast.

Example 4a - **AppleSoft** BASIC modulus formula
```
IF (Y - INT(Y/4) * 4) = 0 ...
```
Example 4b - **SuperBASIC** modulus formula
```
IF Y % 4 = 0 ...
```
It's much easier to understand what I'm doing with `%`.

#### A QUICK NOTE ABOUT `WHILE`
One neat trick you can do is pre-initialize a variable before doing a loop, all in a single line of code. 
Consider the following contrived code.

Example 5a - Loop with variable initialization outside the loop using `GOTO`
```
10 a = 0 
20 poke $D6A0,a :for i=1 to 200 :next :a=a+1 :goto 20
```

Using `WHILE`, we can do the same infinite loop and have our variable set outside of the loop, in one line.

Example 5b - Loop with variable initialization outside the loop using `WHILE`
```
10 a = 0 :while 1 :poke $D6A0,a :for i=1 to 200 :next :a=a+1 :wend
```

#### MISSING MATHS - SINE AND COSINE
One thing I've found useful when exploring BASIC for fun and adventure, is the ability to use SIN() and COS() to make all kinds of designs or to add a more organic flare to an algorithm. 

Understandably, not all BASICs implement trigonometric functions such as these, including SuperBASIC.  But I really did want them and if you can implement these functions in 8-bit assembly, then certainly we can attempt this in a higher level language like BASIC.  

I won't go into the various approximations of sine.  You can quickly look those up on the internet or in a a book.  You can see that my implementation is breaking the sine wave into 4 quadrants representing the overall repeated/mirrored symmetry of a sine wave.  There's an approximation that happens, then it flips the result back to the appropriate range depending on the quadrant.  

This is not intended to be optimized as we're demonstrating the steps of approximation.  

Example 6a - sin.bas
```
REM "SIN LIBRARY" 
REM "USE THIS IN YOUR CODE"
REM "CALL LIKE 'sinproximate(0.4)' AND RESULT WILL BE IN sr#"
10 sr# = 0.0  
20 PI# = 3.141592  

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
```
This is the contents of the `sin.bas` file in this repository.  This program by itself doesn't do anything.

The `cosproximate()` proc simply shifts the input by 90 degrees to reuse sinproximate().

Now we can make fun things with this... like draw circles, sine waves, and other shapes based on trigonometric functions. 

It should be known that the built-in SuperBASIC graphics routines can already draw circles, and fill them, probably using Bresenham.  So if you only care about circles, use the built-in `CIRCLE` command as it is much much faster. 
