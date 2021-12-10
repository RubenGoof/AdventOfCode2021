
fileName$ = "data.txt"
open fileName$ for input as #in

'Idea: list of expected characters per opening
'This can be either a new opening OR the right closing
'We need a stack for this! Closing removes one, opening adds one
'And if this removal does not match up to what is expected, they dun fucted up

DIM stack$(200) 'should be enough?
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
            if cur$ <> expected$ then 'we got a good kind of problem now
                'print "Expected: "; expected$; " but found a "; cur$; " instead."
                if cur$ = ")" then score = score + 3
                if cur$ = "]" then score = score + 57
                if cur$ = "}" then score = score + 1197
                if cur$ = ">" then score = score + 25137
                EXIT FOR
            end if

        end if

    next i

    ptr = 0
    REDIM stack$(200)
wend

close #in

print "Total score is: "; score


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


