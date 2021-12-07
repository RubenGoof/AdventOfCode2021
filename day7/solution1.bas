
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
[fillArray]
if j = i then goto [finishedArray]
crabs(j) = val(word$(txt$, j, ","))
j = j + 1
goto [fillArray]

[finishedArray]

sort crabs(), 0, i


'If we have an even number of crabs, median is avg of two numbers
median = 0
if i mod 2 = 0 then
    median = (crabs(i/2) + crabs(i/2+1))/2
else ' odd number of crabs
    median = crabs(int(i/2)+1)
end if

j = 1
fuel = 0
[printCrabs]
if j = i then goto [finishedPrint]
j = j + 1
print "j: "; j; " crabs: "; crabs(j); " fuel: "; abs(crabs(j)-median)
fuel = fuel + abs(crabs(j)-median)
goto [printCrabs]

[finishedPrint]
print "Fuel: "; fuel
end




