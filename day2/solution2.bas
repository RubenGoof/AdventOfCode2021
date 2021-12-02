open "data" for input as #in

horizontal = 0
depth = 0
aim = 0

while eof(#in) = 0 'eof returns 1 if it is reached, so go through every line.
    line input #in, text$
    if LEFT$(word$(text$, 1), 1) = "u" then 'Get the first character of the line
        aim = aim - val(word$(text$, 2)) 'cast to int and calculate value
    else
        if LEFT$(word$(text$, 1), 1) = "d" then 'yeaaa elseif is not supported
            aim = aim + val(word$(text$, 2))
        else 'Now we arrive at forward
            horizontal = horizontal + val(word$(text$, 2))
            depth = depth + aim * val(word$(text$, 2))
        end if
    end if
wend 'end while loop



close #in 'be polite
print:print:print "EOF"

print "Result: "; str$(depth*horizontal)





