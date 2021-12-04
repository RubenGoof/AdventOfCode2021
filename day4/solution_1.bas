
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
DIM sheets(sheetCount*5, 5) '(rows,columns)
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

'We now want to iterate over the sheets arrayuntil we find bingo for drawn numbers.
numIndex = 1
DIM currentSheet(5,5)
bingoSheet = 1
[iterateNumbers]
number = numbers(numIndex)
print "Current number: "; number
'First we need to go through the whole array and assign -1 to each position where the number occurs.
currentSheet = 1
for i = 1 to (sheetCount*5)
    for j = 1 to 5
        if sheets(i, j) = number then
            sheets(i, j) = -1
        end if
        curRow = i mod 5
        if curRow = 0 then curRow = 5
        currentSheet(curRow,j) = sheets(i,j)
    next j
    'Now let us check with two functions if we have any bingos for this sheet!!
    if (i mod 5) = 0 then
        row = checkRowBingo() 'No need to pass an argument because arrays are global by default
        column = checkColBingo()
        if row = 1 or column = 1 then goto [bingo]
        currentSheet = currentSheet + 1
    end if
next i


numIndex = numIndex + 1
if numIndex <= numbersAmount then goto [iterateNumbers]

[bingo]
print "Iterated over all numbers! Bingo at number: "; number
print "And sheet: "; currentSheet

'Now, we need to calculate the score.
print "The score is: "; calculateScore(currentSheet, number)



'----------------------------
'Simba: What are those functions in BASIC over there?
'Mufasa: That is beyond our borders, you must never go there!
'No really, I did not want to write functions in my solutions but otherwise it gets really really bad.
function countOccurances(str$, char$)
    count = 0
    position = instr(str$, char$)
    if position <> 0 then
        count = count + 1 + countOccurances(mid$(str$, position+1), char$)
    end if
    countOccurances = count
end function

function checkRowBingo()
    bingo = 0
    for row = 1 to 5
        one = 1
        for col = 1 to 5
            one = one * currentSheet(row, col)
        next col
        if one = -1 then
            bingo = 1
        end if
    next row
    checkRowBingo = bingo
end function

function checkColBingo()
    bingo = 0
    for col = 1 to 5
    one = 1
        for row = 1 to 5
            one = one * currentSheet(row, col)
        next row
        if one = -1 then
            bingo = 1
        end if
    next col
    checkColBingo = bingo
end function


function calculateScore(sheetNumber, number)
res = 0
for i = 1 to 5
    for j = 1 to 5
        if currentSheet(i, j) <> -1 then res = res + currentSheet(i,j)
    next j
next i
calculateScore = res*number
end function
