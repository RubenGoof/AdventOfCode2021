
'Little test
firstX = 7
secondX = 9
firstY = 9
secondY = 7
stepSizeX = 1
stepSizeY = -1
for x = firstX to secondX step stepSizeX
    for y = firstY to secondY step stepSizeY
        print str$(x); ","; str$(y)
    next y
next x

DIM test(2)
'This can be either y3 or x3
i = 2
print linearInterpolation(1,1,3,3, i)


function linearInterpolation(x1, y1, x2, y2, x3)
    linearInterpolation = (y1*(x2-x3) + y2 * (x3 - x1)) / (x2 - x1)
end function
