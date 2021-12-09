 'dimension the array for 100 addresses
     elements = 99
     dim structArray(elements) 'This one will store all the addresses (pointers) to the right struct

 'define one structure
     struct test,_
     a as char[20],_
     b as long,_
     c as char[20]

 'the size of the structure is
     sizeofTest = len(test.struct)
    print "sizeOfTest is "; sizeofTest
 'the amount of memory needed is
     memBlockSize = (elements + 1)*sizeofTest

open "kernel32.dll" for dll as #kernel

print "opened kernel "
hSArray = GlobalAlloc( memBlockSize ) 'malloc a block. Returns handle to memory object but does not check for null.
print "allocated memory"
ptrSArray = GlobalLock( hSArray ) 'Get pointer to the start of the first block.
print "Got pointer: "; str$(ptrSArray)

'for example purposes, fill the whole array of structures
     for i = 0 to 99
        'put some data into the struct
        test.a.struct = "Carol - " + str$( i)
        test.b.struct = i
        test.c.struct = "Andy - " + str$( i)
        'calculate the destination as an offset from the
        'first byte
        dest = ptrSArray+(i*sizeofTest)
        print "Made struct for address: "; str$(dest); " where ptrSArray is "; str$(ptrSArray)
         'put the structure into memory.
         'Needs: destination address (dest), source as address of the test structure (dest)
            'dwLen (number of necessary blocks in bytes)
         CallDll #kernel,"RtlMoveMemory", dest as long, _
         test as ptr, sizeofTest as long, ret as void
        'store the address so the data can be found when needed
        structArray(i) = dest
        print "Assigned to "; str$(dest); " for i "; i
     next i

'for example, read all of the structures
     for i = 0 to 99
     test.struct = structArray(i) 'Returns value of the struct at the object it refers to (so i gets the pointer to the i'th pointer refering to the i'th struct)
     A$ = test.a.struct
     B = test.b.struct
     C$ = test.c.struct
     print A$ + " " + str$(B) + " " + C$
     print "FINISHED READING ALL"
     next i

'To retrieve the third element from the 50th structure:
     test.struct = structArray(49)
     C$ = test.c.struct
     print "READ 3rd for 49"
     print C$

'To change the value of the third element of the 50th
     'structure:
     test.struct = structArray(49) 'get the structure
     test.c.struct = "Changed" 'change one or more values
     'save it
     dest = ptrSArray+(49*sizeofTest)
     print "Pointer before changing: "; str$(ptrSArray)
     print "Want to change structure for destination "; str$(dest); " with size "; str$(49*sizeofTest)
     CallDll #kernel,"RtlMoveMemory", dest as long, _
     test as ptr, sizeofTest as long, ret as void

 'just for example
     test.struct = structArray(49)
     C$ = test.c.struct
     print C$


[quit]
     ret = GlobalFree(hSArray) 'call this for every memory block allocated. Use the appropriate memory handle.
     print "Succesfully closed "; str$(ret)
     close #kernel
end

'**** Functions ****
Function GlobalAlloc( dwBytes )
     'returns the handle of the newly allocated memory object.
     'the return value is NULL if fail.
     CallDll #kernel, "GlobalAlloc", _GMEM_MOVEABLE as long,_
     dwBytes as ulong, GlobalAlloc as long
End Function

Function GlobalLock( hMem )
     'returns a pointer to the first byte of the memory block.
     'the return value is NULL if fail.
     CallDll #kernel, "GlobalLock", hMem as long, _
     GlobalLock as long
End Function

Function GlobalFree( hMem )
     CallDll #kernel, "GlobalFree", hMem as long, _
     GlobalFree as long
End Function
