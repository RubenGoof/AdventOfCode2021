
fileName$ = "data.txt"
open fileName$ for input as #in

appearances = 0
DIM mapping$(11)
one$ = ""
four$ = ""
seven$ = ""
eight$ = ""

'print stripString$("She was a soul stripper. She took my heart!", "aei", 1)
'first consider the first input
number = 0
while eof(#in) = 0

    line input #in, txt$
    txt2$ = word$(txt$, 2, " | ") ' use later
    txt$ = word$(txt$, 1, " | ")
    'print txt$
    'digit => length
    ' 1 => 2
    ' 4 => 4
    ' 8 => 7
    ' 7 => 3
    for i = 1 to 10
        if len(word$(txt$, i, " ")) = 2 then
            mapping$(1) = word$(txt$, i, " ")
            print "one: "; mapping$(1)
        end if
        if len(word$(txt$, i, " ")) = 4 then
            mapping$(4) = word$(txt$, i, " ")
            print "four: "; mapping$(4)
        end if
        if len(word$(txt$, i, " ")) = 7 then
            mapping$(8) = word$(txt$, i, " ")
            print "eight: "; mapping$(8)
        end if
        if len(word$(txt$, i, " ")) = 3 then
            mapping$(7) = word$(txt$, i, " ")
            print "seven: "; mapping$(7)
        end if
    next i
    'first, we find the top mapping of a to ? with 7 and 1

    'a$ = stripString$(seven$, one$ , 1) 'a
    mapping$(6) = findSix$(txt$, mapping$(1))
    print "six: "; mapping$(6)
    mapping$(9) = findNine$(txt$, mapping$(4))     ' 9 does overlap with 4 if len = 6
    print "nine: "; mapping$(9)
    mapping$(0) = findZero$(txt$, mapping$(9), mapping$(6))    '0 does not overlap with 4 if len = 6
    print "zero: "; mapping$(0)
    'd = stripString$(eight$, zero$, 1) 'Can find middle (d) from 0 and 8
    ' where 2 are missing it can be either 2, 3 or 5.
    mapping$(3) = findThree$(txt$, mapping$(1))     ' for three substract one is possible and len = 5
    print "three: "; mapping$(3)
    ' but this is not the case for 5 and 2
    mapping$(5) = findFive$(txt$, mapping$(1), mapping$(9)) 'set of 5 + 1 is 9, or check that
    print "five: "; mapping$(5)

    mapping$(2) = findTwo$(txt$, mapping$(5), mapping$(3)) ' 2 is len=5 but not equal to five and three (or just do edit of findFive$)
    print "two: "; mapping$(2)
    strResult$ = ""
    print "find matching now!"
    for i = 1 to 4

        for j = 0 to 9
        'print "mapping: "; mapping$(j)
            if matchingStr(word$(txt2$, i, " "), mapping$(j)) = 1 then
                print "found ";  word$(txt2$, i, " "); " with "; mapping$(j)
                'print word$(txt$, i, " ")
                strResult$ = strResult$ + str$(j)
            end if
        next j
    next i
    print strResult$
    number = number + val(strResult$)

wend

print "Finally! "; number
close #in


'recursively strip a string
function stripString$(strip$, chars$, num)
    for i = 1 to len(strip$)
        if mid$(strip$, i, 1) <> mid$(chars$, num, 1) then
            stripString$ = (stripString$ + mid$(strip$, i, 1))
        end if
    next i
    if (num <= len(chars$)) then stripString$ = stripString$(stripString$, chars$, (num+1))
end function

function findSix$(txt$, one$)
    result$ = ""
    for i = 1 to 10
        cur$ = word$(txt$, i, " ")
        if len(cur$) = 6 then
            if instr(cur$, left$(one$, 1)) = 0 or instr(cur$, right$(one$, 1)) = 0 then
                result$ = cur$
            end if
        end if
    next i
    findSix$ = result$
end function

function findNine$(txt$, four$)
    result$ = ""
    for i = 1 to 10
        cur$ = word$(txt$, i, " ")
        if len(cur$) = 6 then
            isNine = 1
            for j = 1 to len(four$)
                if instr(cur$, mid$(four$, j, 1)) = 0 then
                    isNine = 0
                end if
            next j
        end if
        if isNine = 1 then
            result$ = cur$
            isNine = 0
        end if
    next i
    findNine$ = result$

end function

function findZero$(txt$, nine$, six$)
    result$ = ""
    for i = 1 to 10
        cur$ = word$(txt$, i, " ")
        if len(cur$) = 6 then
            if cur$ <> nine$ and cur$ <> six$ then result$ = cur$
        end if
    next i
    findZero$ = result$
end function

function findThree$(txt$, one$)
    result$ = ""
    for i = 1 to 10
        cur$ = word$(txt$, i, " ")
        if len(cur$) = 5 and (instr(cur$, left$(one$, 1)) <> 0) and (instr(cur$, right$(one$, 1)) <> 0) then
            result$ = cur$
        end if
    next i
    findThree$ = result$
end function

function findFive$(txt$, one$, nine$)
    'logic is to first add left of one, see if reducing it with 9 returns "". If not, add right one and check the same. Then go to next word.
    result$ = ""
    for i = 1 to 10
        cur$ = word$(txt$, i, " ")
        'print nine$
        if len(cur$) = 5 then
            'print "cur "; cur$
            'print "1"; stripString$(nine$, cur$+left$(one$, 1), 1)
            'print "2"; stripString$(nine$, cur$+right$(one$, 1), 1)
            if stripString$(nine$, cur$+left$(one$, 1), 1) = "" then
                result$ = cur$
            else
                if stripString$(nine$, cur$+right$(one$, 1), 1) = "" then
                    result$ = cur$
                end if
            end if
        end if
    next i
    findFive$ = result$
end function

function findTwo$(txt$, five$, three$)
    result$ = ""
    for i = 1 to 10
        cur$ = word$(txt$, i, " ")
        if len(cur$) = 5 then
            if cur$ <> three$ and cur$ <> five$ then
                result$ = cur$
            end if
        end if
    next i
    findTwo$ = result$
end function

function matchingStr(str$, chars$)
    result = 1
    if len(chars$) <> len(str$) then
        result = 0
        matchingStr = result
    end if
    for i = 1 to len(chars$)
        curChar$ = mid$(chars$, i, 1)
        if instr(str$, curChar$) = 0 then
            result = 0
        end if
    next i
    matchingStr = result
end function
