'It is a good thing to note that I am definitely not proud of this.
'Just that Liberty Basic lacks binary numbers, lists, len(array) etc
'Enjoy the pain I went through :)
global fileSize 'Number of lines left currently in the remaining list. Kinda hackily used tho.
global currentValidBitOxygen 'needed because of function scopes
global currentValidBitCO2 'needed because of function scopes
global txtSize 'line size for computing to binary.
fileSize = 0
txtSize = 0 'We do assume the length for each is equal
ones = 0
zeroes = 0
fileName$ = "data"

OxygenDone = 0
CO2Done = 0
'STEP 0: First count the size of the file and make the DIMs below accordingly.
' Can also already count No1 and No0 for the first bit.

open fileName$ for input as #in 'open file


while eof(#in) = 0
    line input #in, txt$ 'read next line
    txtSize = len(txt$)
    value = val(right$(left$(txt$, 1), 1))
    if value = 1 then
        ones = ones + 1
    else
         zeroes = zeroes + 1
    end if
    fileSize = fileSize + 1
wend
close #in 'close file for now


DIM content$(fileSize)

open fileName$ for input as #in2 'open file

for x = 1 to fileSize
    input #in2, txt$
    'print "txt: "; txt$
    content$(x) = txt$
    'print "x: "; x
    'print "content"; content$(x)
next x
close #in2 'close file for now

DIM resultingArrayOxygen$(1)
DIM resultingArrayCO2$(1)


'Initial round
if ones >= zeroes then
    currentValidBitOxygen = 1
    currentValidBitCO2 = 0
    REDIM resultingArrayOxygen$(ones)
    REDIM resultingArrayCO2$(zeroes)
else
    currentValidBitOxygen = 0
    currentValidBitCO2 = 1
    REDIM resultingArrayOxygen$(zeroes)
    REDIM resultingArrayCO2$(ones)
end if

ones = 0
zeroes = 0
'first loop through data column
index1 = 1
index2 = 1
for i = 1 to fileSize
    value = val(right$(left$(content$(i), 1), 1))
    if value = currentValidBitOxygen then
        resultingArrayOxygen$(index1) = content$(i)
        index1 = index1 + 1
        'print "1: "; index1
    else
        resultingArrayCO2$(index2) = content$(i)
        index2 = index2 + 1
        'print "2: "; index2
    end if
next i
fileSizeBeforeOxygen = fileSize
'Now we have to continue separately for Oxygen and CO2.
DIM tempArray$(index1)
position = 2
[oxygenloop]
for i = 1 to (index1-1)
    value = val(right$(left$(resultingArrayOxygen$(i), position), 1))
    if value = 1 then
        ones = ones + 1
    else
        zeroes = zeroes + 1
    end if

    tempArray$(i) = resultingArrayOxygen$(i)
next i


if ones >= zeroes then
    currentValidBitOxygen = 1
    REDIM resultingArrayOxygen$(ones)
else
    currentValidBitOxygen = 0
    REDIM resultingArrayOxygen$(zeroes)
end if

fileSize = index1-1
index1 = 1
for i = 1 to fileSize
    value = val(right$(left$(tempArray$(i), position), 1))
    if value = currentValidBitOxygen then
        resultingArrayOxygen$(index1) = tempArray$(i)
        index1 = index1 + 1
    end if

next i

position = position + 1
zeroes = 0
ones = 0
REDIM tempArray$(index1)
if (fileSize) <> 1 then goto [oxygenloop]

print "RESULT!!!!"; resultingArrayOxygen$(1)




'------------------------------------------------

fileSize = fileSizeBeforeOxygen
DIM tempArray$(index2)
position = 2
[CO2loop]
for i = 1 to (index2-1)
    value = val(right$(left$(resultingArrayCO2$(i), position), 1))
    if value = 1 then
        ones = ones + 1
    else
        zeroes = zeroes + 1
    end if

    tempArray$(i) = resultingArrayCO2$(i)
next i


if ones >= zeroes then
    currentValidBitCO2 = 0
    REDIM resultingArrayCO2$(zeroes)
else
    currentValidBitCO2 = 1
    REDIM resultingArrayCO2$(ones)
end if

fileSize = index2-1

index2 = 1
for i = 1 to fileSize
    value = val(right$(left$(tempArray$(i), position), 1))
    if value = currentValidBitCO2 then
        resultingArrayCO2$(index2) = tempArray$(i)
        index2 = index2 + 1
    end if

next i

position = position + 1
zeroes = 0
ones = 0
REDIM tempArray$(index2)
if (index2-1) <> 1 then goto [CO2loop]

print "RESULT2!!!!"; resultingArrayCO2$(1)

'Now we translate it to a number instead of bits
oxygenNum = binaryStringToNumber(resultingArrayOxygen$(1))
CO2Num = binaryStringToNumber(resultingArrayCO2$(1))

print "Final result is:"; (oxygenNum*CO2Num)


function binaryStringToNumber(num$)
result = 0
for i = 1 to txtSize 'loop through the current line
    value = val(right$(left$(num$, i), 1))
    if value = 1 then
         result = result + 2^(txtSize-i)
    end if
next i
print result
binaryStringToNumber = result
end function

sub findValue byref index, byref resultingArray$

end sub




