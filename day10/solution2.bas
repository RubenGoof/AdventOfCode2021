
fileName$ = "data.txt"
open fileName$ for input as #in

'Idea: list of expected characters per opening
'This can be either a new opening OR the right closing
'We need a stack for this! Closing removes one, opening adds one
'And if this removal does not match up to what is expected, they dun fucted up

DIM stack$(200) 'should be enough?
DIM results(200)
global ptrRes
ptrRes = 1
global ptr

opening$ = "([{<"
closing$ = ")]}>"
score = 0

while eof(#in) = 0
    line input #in, txt$
    for i = 1 to len(txt$)
        cur$ = mid$(txt$, i, 1)
        if instr(opening$, cur$) <> 0 then
            if cur$ = "(" then p = push(")")
            if cur$="[" then p = push("]")
            if cur$="{" then p = push("}")
            if cur$="<" then p = push(">")
        else 'is a closing bracket!
            expected$ = pop$()
            if expected$ <> cur$ then 'We discard the line if it is incorrect.
                print "discarded line"
                EXIT FOR
            end if
        end if

        if i = len(txt$) and ptr <> 0 then 'So we finished the word, but our stack is not empty!
            score = completeLine()
            'print "Incomplete line found! score is: "; score
            results(ptrRes) = score
            ptrRes = ptrRes + 1
        end if
    next i

    ptr = 0
    REDIM stack$(200)
wend

close #in

sort results(), 0, ptrRes
finRes = results(int(ptrRes/2)+1)
print finRes



function push(val$)
    ptr = ptr + 1
    if ptr < 201 then
        stack$(ptr) = val$
        push = ptr 'return value that was pushed
    else
        push = 0
        print "full stack!"
    end if
end function

function pop$()
    val$ = stack$(ptr)
    ptr = ptr-1
    if ptr < 0 then
        print "Will exceed limits!"
    end if
    pop$ = val$
end function


function completeLine()
    score = 0
    while ptr <> 0
        val$ = pop$()
        if val$ = ")" then score = (score*5) + 1
        if val$ = "]" then score = (score*5) + 2
        if val$ = "}" then score = (score*5) + 3
        if val$ = ">" then score = (score*5) + 4
        'print score
    wend

    completeLine = score
end function
