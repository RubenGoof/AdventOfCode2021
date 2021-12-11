fileName$ = "data.txt"

open fileName$ for input as #in

DIM cave(10,10)
DIM flashed(11,11)

nrflashes = 0
steps = 0

y = 1
while eof(#in) = 0
    line input #in, txt$
    for x = 0 to len(txt$)
          cave(x, y) = val(mid$(txt$, x, 1))
    next x
    y = y + 1
wend
close #in

'call printCave
all = 0
while all = 0
    print "------------NEXT STEP: "; s; "-------------"
    'call printCave
    call increase
    r = 1
    while r <> 0
        r = flash()
        nrflashes = r + nrflashes
    wend
    'call printCave
    'call printFlash
    all = allFlashes()
    REDIM flashed(11,11)
    s=s+1
wend

print s

'if we don't do anything we return 0, if we do flas anything we return 1
function flash()
    nrflashes = 0
    for y = 1 to 10
        for x = 1 to 10
            if cave(x,y) > 9 and flashed(x,y) = 0 then
                flashed(x,y) = 1
                nrflashes = nrflashes + 1
                cave(x,y) = 0
                'print "increase surrounding now."
                r = increaseSurrounding(x,y)
            end if
        next x
    next y
    flash = nrflashes
end function



sub increase
    for y = 1 to 10
        for x = 1 to 10
            cave(x,y) = cave(x,y) + 1
        next x
    next y
end sub



sub printCave
    for y = 1 to 10
        row$ = ""
        for x = 1 to 10
              row$ = row$ + str$(cave(x,y))
        next x
        print row$
    next y
    print
end sub

sub printFlash
    for y = 1 to 10
        row$ = ""
        for x = 1 to 10
              row$ = row$ + str$(flashed(x,y))
        next x
        print row$
    next y
    print
end sub

function increaseSurrounding(x,y)
    current = cave(x,y)
    'Left, topleft, botleft
    if x <> 1 then
        if flashed(x-1,y) = 0 then cave(x-1, y) = cave(x-1, y) + 1
        if y <> 1 and flashed(x-1,y-1) = 0 then cave(x-1, y-1) = cave(x-1, y-1) + 1
        if y <> 10 and flashed(x-1,y+1) = 0 then cave(x-1, y+1) = cave(x-1, y+1) + 1
    end if
    'Top, topright
    if y <> 1 then
        if flashed(x,y-1) = 0 then cave(x, y-1) = cave(x, y-1) + 1
        if x <> 10 and flashed(x+1,y-1) = 0 then cave(x+1, y-1) = cave(x+1, y-1) + 1
    end if
    'Bot, botright
    if y <> 10 then
        if flashed(x,y+1) = 0 then cave(x,y+1) = cave(x,y+1) + 1
        if x <> 10 and flashed(x+1,y+1) = 0 then cave(x+1, y+1) = cave(x+1, y+1) + 1
    end if
    'Right
    if x <> 10 and flashed(x+1,y) = 0 then cave(x+1,y) = cave(x+1,y) + 1

    r = 1
end function

function allFlashes()
    result = 1

    for x = 1 to 10
        for y = 1 to 10
            if flashed(x,y) = 0 then result = 0
        next y
    next x

    allFlashes = result
end function



