
fileName$ = "testData"

open fileName$ for input as #in

'first read the first line
line input #in, firstLine$
print "The comma occurs: "; countOccurances(firstLine$, ",")

'Now we fill the numbers array
DIM numbers(countOccurances(firstLine$, ",")+1)
token$ = "?"
numbersAmount = 1
[commaLoop]
token$ = word$(firstLine$, numbersAmount, ",")
if token$ = "" then goto [readSheets]
numbers(numbersAmount) = val(token$)
numbersAmount = numbersAmount + 1
goto [commaLoop]



[readSheets]
numbersAmount = numbersAmount - 1 'because we add it at the end of the loop above
print "We have this many numbers: "; numbersAmount


'Now, we want to find out how big our sheets array needs to be...
'One sheet is 5x5, so we need to count the amount of columns now.
sheetCount = 0
while eof(#in) = 0
    input #in, txt$
    if txt$ = "" then
        sheetCount = sheetCount + 1
    end if
wend
print "We have this many sheets:"; sheetCount
close #in

'Now we read our file! We skip the first two lines.
DIM sheets(sheetCount*5, 5)
open fileName$ for input as #in
line input #in, txt$ 'skip 1
line input #in, txt$ 'skip 2
index = 0
while eof(#in) = 0
    line input #in, txt$
    if txt$ <> "" then
        index = index + 1
        'print "index: "; index
        'print "txt: "; txt$
        for i = 1 to 5
            sheets(index, i) = val(word$(txt$, i))
        next i

    end if
wend
close #in
print "The last number of the last row is "; sheets(index, 5)


function countOccurances(str$, char$)
    count = 0
    position = instr(str$, char$)
    if position <> 0 then
        count = count + 1 + countOccurances(mid$(str$, position+1), char$)
    end if
    countOccurances = count
end function

