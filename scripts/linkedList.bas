
'*****Basic necessities for linked list *****
open "kernel32.dll" for dll as #kernel 
struct Node,_
    index as int,_
    previousPtr as long,_
    nextPtr as long,_
    value as char[20]

global sizeOfNode
sizeOfNode = len(Node.struct)
    
'**** Functions for creating lists *****

'This function create an initial node and returns the pointer to it. Do not lose it ;)
function createList(value)


end function

'This function adds a node to the list before the index.
function addNode(byref list, index)

end function

'This function removes the node at the index
function removeNode(byref list, index)

end function

'Changes the value at the appropiate index
function editNode(byref list, index, value)

end function

'Gives the value of the node at the provided index
function getNode(byref list, index)

end if

'Removes all the allocated memory of the node
function removeList(byref list)

end function

function nullPointer(ptr)
    if ptr = 0
        nullPointer = 1
    else
        nullPointer = 0
    end if
end function

'**** Functions for memory allocation ****
'Alternative with less overhead! Ensures that nodes are not too far apart in memory, is nice for bby windows <3
'https://docs.microsoft.com/en-us/windows/win32/memory/heap-functions


'returns the handle of the newly allocated fixed global memory object.
'the return value is NULL (0) if fail.
Function GlobalAlloc( dwBytes )
     CallDll #kernel, "GlobalAlloc", _GMEM_MOVEABLE as long,_
     dwBytes as ulong, GlobalAlloc as long
End Function

'Locks a global (moveable) memory object 
' returns a pointer to the first byte of the object's memory block.
Function GlobalLock( hMem )
     CallDll #kernel, "GlobalLock", hMem as long, _
     GlobalLock as long
End Function

'Important to call when freeing up memory again!
Function GlobalFree( hMem )
     CallDll #kernel, "GlobalFree", hMem as long, _
     GlobalFree as long
End Function



