fileName$ = "data.txt"

'First count the number of lines we have
numberOfLines = 0
maxX = 0
maxY = 0
open fileName$ for input as #in
while eof(#in) = 0
    line input #in, txt$
    first$ = word$(txt$, 1, " -> ")
    second$ = word$(txt$, 2, " -> ")
    if val(word$(first$, 1, ",")) > maxX then maxX = val(word$(first$, 1, ","))
    if val(word$(first$, 2, ",")) > maxY then maxY = val(word$(first$, 2, ","))
    if val(word$(second$, 1, ",")) > maxX then maxX = val(word$(second$, 1, ","))
    if val(word$(second$, 2, ",")) > maxY then maxY = val(word$(second$, 2, ","))
    numberOfLines = numberOfLines + 1
wend
close #in

'Now, we create our data structure:
'Honestly it pains me to do this; but this language does not offer hashmaps.
'So we will have to suffer n^2 later on
'A solution would be to keep a second maxX x 2 and maxY x 2 array with all the points that have been covered,
'and use those as keys. The size of this is the sum of the distance of all lines and we would have to count it, though.
DIM world(maxX, maxY)

print "Create a world! We have this many lines: "; numberOfLines
print "And our maxX is "; maxX; " and our maxY is "; maxY

'And we fill them...
open fileName$ for input as #in2
while eof(#in2) = 0
    line input #in2, txt$
    firstX = val(word$(word$(txt$, 1, " -> "), 1, ","))
    firstY = val(word$(word$(txt$, 1, " -> "), 2, ","))
    secondX = val(word$(word$(txt$, 2, " -> "), 1, ","))
    secondY = val(word$(word$(txt$, 2, " -> "), 2, ","))
    stepSizeX = 1
    stepSizeY = 1
    'Only consider horizontal and vertical lines!

    if firstX > secondX then stepSizeX = -1
    if firstY > secondY then stepSizeY = -1
    if firstX <> secondX and firstY <> secondY then goto [diagRoutine]
    if firstY <> secondY then goto [yRoutine]

    [xRoutine]
    for x = firstX to secondX step stepSizeX
        world(x, firstY) = world(x, firstY) + 1
    next x
    goto [FinishRound]

    [yRoutine]
    for y = firstY to secondY step stepSizeY
        world(firstX, y) = world(firstX, y) + 1
    next y
    goto [FinishRound]

    [diagRoutine]
    for x = firstX to secondX step stepSizeX
        y = linearInterpolation(firstX, firstY,secondX,secondY, x)
        world(x, y) = world(x, y) + 1
    next x
    goto [FinishRound]

    [FinishRound]
    print txt$
    'call printWorld maxX, maxY
    print " "
wend
close #in2

'And nowww we loop through the whole thing. Sorry, really.
sum = 0
for y = 0 to maxY
    prt$ = ""
    for x = 0 to maxX
        prt$ = prt$ + " " + str$(world(x,y))
        if world(x,y) > 1 then sum = sum + 1
    next x
    'print prt$
next y

print "The number of dangerous points is: "; sum

sub printWorld maxX, maxY
    for y = 0 to maxY
        prt$ = ""
        for x = 0 to maxX
            prt$ = prt$ + " " + str$(world(x,y))
        next x
        'print prt$
    next y
end sub


function linearInterpolation(x1, y1, x2, y2, x3)
    linearInterpolation = (y1*(x2-x3) + y2 * (x3 - x1)) / (x2 - x1)
end function
