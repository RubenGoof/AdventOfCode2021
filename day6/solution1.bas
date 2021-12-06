
fileName$ = "data.txt"
days = 80
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


j = 0
count = 0
[fillArray]
if j = i then goto [finishedArray]
j = j + 1
count = count + countFish(val(word$(txt$, j, ",")), days)
goto [fillArray]

[finishedArray]
print "finished "; count

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
