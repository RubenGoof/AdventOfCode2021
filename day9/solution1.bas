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
            'print "current "; current
            sum = sum + (current+1)
        end if
        i=i+1
    wend
    j = j + 1
wend
print "result: "; sum


