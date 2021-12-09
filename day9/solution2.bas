fileName$ = "data.txt"
open fileName$ for input as #in
global width
global height

height = 0
while eof(#in) = 0
    height = height + 1
    input #in, txt$
    'print txt$
wend
close #in
width = len(txt$)


print "dimensions are "; width; " by "; height

DIM basin(width,height)
DIM visited(width, height)
DIM queueX(10000)'I would honestly rather use a list but my linkedlist implementation is not yet finished...
DIM queueY(10000) 'same story here.
global ptr
ptr = 0 'Only one pointer to indicate our current position in the queue and keep it aligned.
global size
size = 0
global curX
global curY
'Now we fill the array
open fileName$ for input as #in

j = 0
while eof(#in) = 0
    input #in, txt$
    j = j + 1
    for i = 1 to width
        'print "i "; i; " j "; j; " val "; val(mid$(txt$, i, 1))
        basin(i, j) = val(mid$(txt$, i, 1))
    next i
wend
close #in


DIM biggestBasins(3)
sum = 0
j = 1
while j <= height
    i = 1
    while i <= width
        lowest = 1
        current = basin(i, j)
        'print "i "; i; " j "; j; " val "; current
        if i <> 1 then
            if basin(i-1, j) <= basin(i,j) then lowest = 0
        end if
        if i <> width then
            if basin(i+1, j) <= basin(i,j) then lowest = 0
        end if
        if j <> 1 then
            if basin(i, j-1) <= basin(i,j) then lowest = 0
        end if
        if j <> height then
            if basin(i, j+1) <= basin(i,j) then lowest = 0
        end if

        if lowest = 1 then
            if current <> 9 then
                print "x "; i; " y "; j; " val "; current
                basinSize = findBasin(i, j)
                print "Has basin size: "; basinSize


                if biggestBasins(1) <= basinSize then
                    biggestBasins(3) = biggestBasins(2)
                    biggestBasins(2) = biggestBasins(1)
                    biggestBasins(1) = basinSize
                else
                    if biggestBasins(2) <= basinSize then
                        biggestBasins(3) = biggestBasins(2)
                        biggestBasins(2) = basinSize
                    else
                        if biggestBasins(3) <= basinSize then
                            biggestBasins(3) = basinSize
                        end if
                    end if
                end if
            end if
        end if
        i=i+1
    wend
    j = j + 1
wend
finalRes = biggestBasins(1)*biggestBasins(2)*biggestBasins(3)
print "result: "; finalRes


function findBasin(x, y)
    call resetQueue 'so we do not run out of time
    sizeRes = 0
    added = addQueue(x, y) 'Add lowest point to the queue, so we shall visit it....
    'print "Added first one!"
    if added = 0 then print "Queue almost full!"
    while queueEmpty() = 0
        call readQueue 'Stores it in curX and curY
        'print "curX: "; curX
        'print "curY: "; curY
        if basin(curX,curY) <> 9 and visited(curX,curY) = 0 then
            if curX > 1 then
                if basin(curX-1, curY) <> 9 and visited(curX-1,curY) = 0 then added = addQueue(curX-1, curY)
                if added = 0 then print "Queue almost full!"
            end if
            if curX < width then
                if basin(curX+1, curY) <> 9 and visited(curX+1,curY) = 0 then added = addQueue(curX+1, curY)
                if added = 0 then print "Queue almost full!"
            end if
            if curY > 1 then
                if basin(curX, curY-1) <> 9 and visited(curX,curY-1) = 0 then added = addQueue(curX, curY-1)
                if added = 0 then print "Queue almost full!"
            end if
            if curY < height then
                if basin(curX, curY+1) <> 9 and visited(curX,curY+1) = 0 then added = addQueue(curX, curY+1)
                if added = 0 then print "Queue almost full!"
            end if
            visited(curX, curY) = 1
            print "visited x: "; curX; " and y: "; curY; " val: "; basin(curX, curY); " with new size for basin "; str$(sizeRes+1)
            sizeRes = sizeRes + 1
        end if
    wend
    findBasin = sizeRes
end function

'Add to queue and increase size
function addQueue(x, y)
    if size < 9999 then
        queueX(size) = x
        queueY(size) = y
        size = size + 1
        addQueue = 1
    else ' queue will be full soon, might be nice for error handling.
        queueX(size) = x
        queueY(size) = y
        size = size + 1
        addQueue = 0
    end if
end function

'read from queue and increase pointer
sub readQueue
    curX = queueX(ptr)
    curY = queueY(ptr)
    ptr = ptr + 1
end sub

'1 if empty 0 if not
function queueEmpty()
    if size = ptr then
        queueEmpty = 1
    else
        queueEmpty = 0
    end if
end function

sub resetQueue
DIM queueX(10000)'I really wish this was not necessary but we need to reset it per basin, as this is our version of a list.
DIM queueY(10000)
ptr = 0 'Only one pointer to indicate our current position in the queue and keep it aligned.
size = 0
curX = 0
curY = 0
end sub
