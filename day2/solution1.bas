open "data" for input as #in

horizontal = 0
depth = 0

while eof(#in) = 0
    line input #in, text$
    if LEFT$(word$(text$, 1), 1) = "u" then
        depth = depth - val(word$(text$, 2))
    else
        if LEFT$(word$(text$, 1), 1) = "d" then
            depth = depth + val(word$(text$, 2))
        else
            horizontal = horizontal + val(word$(text$, 2))
        end if
    end if
wend



close #in 'be polite
print:print:print "EOF"

print "Result: "; str$(depth*horizontal)





