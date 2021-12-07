
fileName$ = "data.txt"
open fileName$ for input as #in
line input #in, txt$
print txt$

i = 1
[countLength]
if word$(txt$, i, ",") = "" then goto [finishedLength]
i = i + 1
goto [countLength]

[finishedLength]
print "There are this many crabs: "; (i-1)
close #in
DIM crabs(i)

j = 1
sum = 0
[fillArray]
if j = i then goto [finishedArray]
crabs(j) = val(word$(txt$, j, ","))
sum = sum + crabs(j)
j = j + 1
goto [fillArray]
[finishedArray]

mean = val(using("#####",(sum/(j-1))+0.5))
print "sum is "; sum; " and mean is: "; mean

'sort crabs(), 0, i

x = -30
minFuel = 10000000000
[findFuel]
if x = 30 goto [finishFuel]
j = 1
fuelVar = 0
[printCrabs]
if j = i then goto [finishedPrint]
'print "j: "; j; " crabs: "; crabs(j); " fuel: "; fuel(abs(crabs(j)-mean))
fuelVar = fuelVar + fuel(abs(crabs(j)-(mean+x)))
j = j + 1
goto [printCrabs]

[finishedPrint]
print "Fuel: "; fuelVar
if fuelVar < minFuel then minFuel = fuelVar

x = x + 1
goto [findFuel]

[finishFuel]
print "smallest fuel: "; minFuel
end




function fuel(x)
    'print x
    fuel = x*(x+1)/2 'Gauss sum
end function



