open "testdata" for input as #in 'open file

global counter
counter = 0

txt$ = "" 'so that it can be used it UPDATEGAMMA we make it global
txtSize = 0 'We do assume the length for each is equal
ones = 0
zeroes = 0

'STEP 0: We only do oxygen generator rating for now.
' First count the size of the file and make the DIMs below accordingly.
' Can also already count No1 and No0 for the first bit.
while eof(#in) = 0
    line input #in, txt$ 'read next line
    txtSize = len(txt$)
    'print counter
    value = val(right$(left$(txt$, 1), 1))
    if value = 1 then
        ones = ones + 1
    else
         zeroes = zeroes + 1
    end if
    counter = counter + 1
wend
close #in 'close file for now

DIM valid(counter)
if ones > zeroes then
    valid = fillValid(1, 1)
else
    valid = fillValid(0, 1)
end if

validBit = countValid(2)
for i = 2 to txtSize
    valid = fillValid(validBit, i)
    if i < (txtSize-1) then
        validBit = countValid(i+1)
    end if
next i


'STEP 1: Fill array with valid for most common one accordingly to the largest count
function fillValid(validBit, index)
    DIM result(counter)
    newCounter = 0
    for i = 1 to counter
        newCounter = newCounter + 1
        txt =  valid(i) 'read next line
        value = val(right$(left$(txt$, index), 1))
        if value = validBit then
           result(index) = value 'because we cannot read it char by char lmao. cleaner would be word$ with delimiter ""
        end if
    next i
    counter = newCounter
    fillValid = result
end function

'We count the number of valid according to the bit criteria
function countValid(index)
    ones = 0
    zeroes = 0
    for i = 1 to counter
        x = valid(i)
        value = val(right$(left$(x$, index), 1))
        if value = 1 then
            ones = ones + 1
        else
            zeroes = zeroes + 1
        end if
    next i
    if ones>zeroes then
        countValid = 1
    else
        countValid = 0
    end if
end function

'STEP 2: For this new array,
'STEP 3: Fill the position in the array with 1 or 0 and keep this in a new counter
'STEP 3: Make new DIM according to this new counter

print

