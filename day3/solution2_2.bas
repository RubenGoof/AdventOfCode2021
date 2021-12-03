global fileSize
global currentValidBitOxygen
global currentValidBitCO2
fileSize = 0
txtSize = 0 'We do assume the length for each is equal
ones = 0
zeroes = 0

'STEP 0: First count the size of the file and make the DIMs below accordingly.
' Can also already count No1 and No0 for the first bit.

open "testdata" for input as #in 'open file
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

DIM resultingArrayOxygen$(1)
DIM resultingArrayCO2$(1)

if ones > zeroes then
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

print "FileSize "; fileSize
print


'STEP 1: Lets now loop through the file and fill a DIM with the relevant data!
index1 = 1
index2 = 1
open "testdata" for input as #in2 'open file
while eof(#in2) = 0
    line input #in2, txt$ 'read next line
    txtSize = len(txt$)
    value = val(right$(left$(txt$, 1), 1))
    if value = currentValidBitOxygen then
        resultingArrayOxygen$(index1) = txt$
        index1 = index1 + 1
        print "1: "; index1
    else
        resultingArrayCO2$(index2) = txt$
        index2 = index2 + 1
        print "2: "; index2
    end if
wend
close #in2 'close file for now


for i = 1 to (index2 - 1)
    print resultingArrayCO2$(i)
next i




