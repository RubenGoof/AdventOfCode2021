open "data" for input as #in 'open file
counter = 1

txt$ = "" 'so that it can be used it UPDATEGAMMA we make it global
input #in, txt$ 'read first line
DIM ones(len(txt$))
DIM zeroes(len(txt$))


'loop thru the file
while eof(#in) = 0
    counter = counter + 1
    'print counter
    for i = 1 to len(txt$) 'loop through the current line
        value = val(right$(left$(txt$, i), 1))
        if value = 1 then
            ones(i) = ones(i) + 1 'because we cannot read it char by char lmao. cleaner would be word$ with delimiter ""
        else
            zeroes(i) = zeroes(i) + 1
        end if
    next i
    line input #in, txt$ 'read next line
wend
close #in

for i = 1 to len(txt$)
    print ones(i)
next i

'Now convert it to epsilon & gamma
epsilon = 0
gamma = 0
for i = 1 to len(txt$) 'for every position
    if ones(i) > zeroes(i) then
        gamma = gamma + 2^(len(txt$)-i)
    else
        epsilon = epsilon + 2^(len(txt$)-i)
    end if
next i


print epsilon*gamma



