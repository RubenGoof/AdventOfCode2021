fileName$ = "data.txt"
days = 256
'First count the number of lines we have
open fileName$ for input as #in
line input #in, txt$

i = 1
[countLength]
if word$(txt$, i, ",") = "" then goto [finishedLength]
i = i + 1
goto [countLength]

[finishedLength]
i=i-1
print "There are this many fish at the start: "; i
close #in

DIM count(9)
j = 0
countTotal = 0
[fillArray]
if j = i then goto [finishedArray]
j = j + 1
fish = val(word$(txt$, j, ","))
if count(fish) = 0 then
    count(fish) = countFish(fish, days)
end if
countTotal = countTotal + count(fish)
print j
goto [fillArray]

[finishedArray]
print "finished "; countTotal

end


function countFish(n, t)
    c = 0
    if t = 0 then
        c = 1
    end if

    if n = 0 and t <> 0 then
        c = c + countFish(8, t-1)
        c = c + countFish(6, t-1)
    else
        if t <> 0 then
            c = countFish(n-1, t-1) 'we dont use a
        end if
    end if
    countFish = c
end function
