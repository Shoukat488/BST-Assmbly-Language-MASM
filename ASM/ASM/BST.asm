INCLUDE Irvine32.inc
INCLUDE Macros.inc
traverseInOrder proto , rootNode : ptr dword
searchInTree proto , rootNode : ptr dword , value : dword
deleteNode proto , rootNode: ptr dword , value : dword
preOrder proto ,preNode : ptr dword , currentNode : ptr dowrd
findMax proto , rootNode : ptr dword
findMin proto , rootNode : ptr dword

.data
typeFlag dword ?
deleteFlag dword ?
multi dword 4
dividend dword 4
tempIndex dword ?
maxValue dword 0
minValue dword 0
minValueNode dword ?
maxValueNode dword ?
p1 byte "Inserting values : ",0
p2 byte "Traversing binray Tree in order",0
p3 byte "Enter value to search in tree : ",0
foundString byte "Value found in tree ",0
nFoundString byte "Value not found in tree ",0
maxString byte "Max value in tree : ",0
minString byte "Min value in tree : ",0
notdelString byte "Value not find ",0
bst sdword 10000 dup(0)

.code

main PROC
TypeScreen:
call clrscr
mwriteln "        ---------------------------------------------------------------------------------------------------"
mwriteln "        ---------------------------------------Binary Search Tree------------------------------------------"
mwriteln "        ---------------------------------------------------------------------------------------------------"
call crlf
mwriteln "                                      On which data type you want to work?"
mwriteln "                                               1 - Character"
mwriteln "                                               2 - Integer"
mwriteln "                                               3 - Exit"
call readInt
cmp eax , 1
je charType
cmp eax , 2
je intType
cmp eax , 3
je endProgram
jmp TypeScreen

charType:
mov typeFlag , eax
jmp choice

intType:
mov typeFlag , eax
jmp choice

choice:
call clrscr
mwriteln "        ---------------------------------------------------------------------------------------------------"
mwriteln "        ---------------------------------------Binary Search Tree------------------------------------------"
mwriteln "        ---------------------------------------------------------------------------------------------------"
mwriteln "                                              1 - Insert into tree "
mwriteln "                                              2 - Traverse tree "
mwriteln "                                              3 - Search into tree "
mwriteln "                                              4 - Delete from tree "
mwriteln "                                              5 - Find maximum value in tree "
mwriteln "                                              6 - Find minimum value in tree "
mwriteln "                                              7 - End program"
call readInt
cmp eax , 1
je insertIntoTree
cmp eax , 2
je traverseIntoTree
cmp eax , 3
je search
cmp eax , 4
je deleteFromTree
cmp eax , 5
je maxValueIntoTree
cmp eax , 6
je minValueIntoTree
cmp eax , 7
je endProgram


wrongChoice:

mwriteln "Enter correct choice "
call waitMsg
jmp choice

insertIntoTree:
;<---------------------------------insert into tree------------------------->
call clrscr
mov edx , 0
mov eax , 0
mov ebx , 0
mov ecx , 0
mov edi , offset bst
mwriteln "How many elements you want to insert: "
call readInt
mov ecx , eax
mwriteln "Enter elements "
l1:
mov eax , typeFlag
cmp eax , 1
je readCharacter
jmp readInteger

readInteger:
call readDec
jmp endInput

readCharacter:
mov eax , 0
call readChar
movzx eax , al
call writeChar
call crlf
endInput:
mov ebx , eax
push offset [bst + 4]
push offset [bst + 8]

call insert

add esp , 8
mov edi , offset bst

loop l1

call crlf

call waitMsg
jmp choice

traverseIntoTree:
;<-----------------------------------Traverse into tree------------------------------------->
call clrscr
mov edx , offset p2
call writeString
call crlf

mov edx , 0
mov eax , 0
mov ebx , 0
mov ecx , 0

mov esi , offset bst
invoke traverseInOrder , addr bst

call waitMsg
jmp choice
search:
;<-----------------------------------Search into tree------------------------------------->
call clrscr
mwriteln "Enter value : "

mov eax , typeFlag
cmp eax , 1
je readCharacter2
jmp readInteger2

readInteger2:
mov eax , 0
call readDec
jmp endInput2

readCharacter2:
mov eax , 0
call readChar
movzx eax , al
call writeChar
call crlf
endInput2:

mov edx , 0
mov ebx , 0
mov ecx , 0

invoke searchInTree , offset bst , eax

cmp ecx , 1
je found
jmp notFound

found:
mov edx , offset foundString
call writeString
call crlf

call waitMsg
jmp choice

notFound:
mov edx , offset nFoundString
call writeString
call crlf

call waitMsg
jmp choice

maxValueIntoTree:
;<-----------------------------------Max in tree------------------------------------->
call clrscr
invoke findMax , offset bst
mov edx , offset maxString
call writeString

mov eax , typeFlag
cmp eax , 1
je writeCharacter
jmp writeInteger

writeInteger:
mov eax , 0
mov eax , maxValue
call writeDec
call crlf
jmp endInput3

writeCharacter:
mov eax , 0
mov eax , maxValue
call writeChar
call crlf
endInput3:

call waitMsg
jmp choice
minValueIntoTree:
;<-----------------------------------Min in tree------------------------------------->
call clrscr
invoke findMin , offset bst
mov edx , offset minString
call writeString

mov eax , typeFlag
cmp eax , 1
je writeCharacter2
jmp writeInteger2

writeInteger2:
mov eax , 0
mov eax , minValue
call writeDec
call crlf
jmp endInput4

writeCharacter2:
mov eax , 0
mov eax , minValue
call writeChar
call crlf
endInput4:

call waitMsg
jmp choice

deleteFromTree:
;<-----------------------------------Delete from tree------------------------------------->
call clrscr
mwriteln "Enter value to delete : "

mov eax , typeFlag
cmp eax , 1
je readCharacter3
jmp readInteger3

readInteger3:
mov eax , 0
call readDec
jmp endInput5

readCharacter3:
mov eax , 0
call readChar
movzx eax , al
call writeChar
call crlf
endInput5:

invoke deleteNode , offset bst , eax

mov eax , deleteFlag
cmp eax , 1
je printDeleteMessage
jmp noMessage
printDeleteMessage:
mwriteln "Value has been deleted"
noMessage:
call waitMsg
jmp choice


endProgram:
mwriteln"                                                ~THANK YOU~"
mwriteln "                          ......................End Program....................."
exit

main endp
;//////////////////////////////////////////////// Insert Function //////////////////////////////////////////
insert proc

push ebp
mov ebp , esp

cmp ebx , [edi]
je final

mov eax , [edi]

cmp eax , 0
je assignValueAtRoot

cmp  ebx , eax
jb leftNode
jmp rightNode

leftNode:
mov eax, [ebp + 12]
mov eax , [eax]
cmp eax , 0
je assignValueAtLeft

mov eax , [ebp + 12]
mov edi , eax
sub eax , offset bst

mov esi , [ebp + 12]
add esi , eax 

add esi , 4
push esi
add esi , 4
push esi

call insert 
jmp final

assignValueAtLeft:
mov esi , [ebp + 12]
mov [esi] , ebx
mov eax , [esi]

jmp final

rightNode:
mov eax, [ebp + 8]
mov eax , [eax]
cmp eax , 0
je assignValueAtRight
mov eax , [ebp + 8]
mov edi , eax
sub eax , offset bst

mov esi , [ebp + 8]
add esi , eax 

add esi , 4
push esi
add esi , 4
push esi

call insert
jmp final

assignValueAtRight:
mov esi , [ebp + 8]
mov [esi] , ebx
mov eax , [esi]
jmp final

assignValueAtRoot:
mov [edi] , ebx
mov eax , [edi]
jmp final

final:

mov esp , ebp
pop ebp 

ret 8

insert endp
;///////////////////////////////////////////////// Traverse Function ///////////////////////////////////////
traverseInOrder proc , rootNode : ptr dword

mov eax , rootNode
mov ebx , rootNode
sub eax , esi
add ebx , eax
add ebx , 4
mov eax , [ebx]

cmp eax , 0
jne traverseLeftNode

print:
mov eax , typeFlag
cmp eax , 1
je printChar
jmp printInt

printChar:
mov eax , [rootNode]
mov eax , [eax]
call writeChar
call crlf
jmp endPrint

printInt:
mov eax , [rootNode]
mov eax , [eax]
call writeDec
call crlf

endPrint:

mov eax , rootNode
mov ebx , rootNode
sub eax , esi
add ebx , eax
add ebx , 8
mov eax , [ebx]

cmp eax , 0
jne traverseRightNode
jmp final

traverseRightNode:
invoke traverseInOrder , ebx
jmp final

traverseLeftNode:
invoke traverseInOrder , ebx
jmp print

final:
ret
traverseInOrder endp
;////////////////////////////////////////// Search Function ////////////////////////////////////////////

searchInTree proc , rootNode : ptr dword , value : dword

mov eax , [rootNode]
mov eax , [eax]
mov edx , value
cmp eax , edx
je found

mov eax , rootNode
mov ebx , rootNode
sub eax , offset bst
add ebx , eax
add ebx , 4
mov eax , [ebx]

cmp eax , 0
jne traverseLeftNode

comeBack:
mov eax , rootNode
mov ebx , rootNode
sub eax , offset bst
add ebx , eax
add ebx , 8
mov eax , [ebx]

cmp eax , 0
jne traverseRightNode
jmp final

traverseRightNode:
invoke searchInTree , ebx , value
jmp final

traverseLeftNode:
invoke searchInTree , ebx , value
jmp comeBack

found:
mov ecx , 1

final:
ret

searchInTree endp
;///////////////////////////////////// Max Function ///////////////////////////////////////////
findMax proc , rootNode : ptr dword

mov eax , rootNode
mov ebx , rootNode
sub eax , offset bst
add ebx , eax
add ebx , 8
mov eax , [ebx]

cmp eax , 0
jne traverseRightNode
jmp foundMaxValue

traverseRightNode:
invoke findMax , ebx 
jmp final

foundMaxValue:
mov eax , [rootNode]
mov maxValueNode , eax
mov eax , [eax]
mov MaxValue , eax

final:
ret
findMax endp
;///////////////////////////////////// Min Function ///////////////////////////////////////////
findMin proc , rootNode : ptr dword

mov eax , rootNode
mov ebx , rootNode
sub eax , offset bst
add ebx , eax
add ebx , 4
mov eax , [ebx]

cmp eax , 0
jne traverseLeftNode
jmp foundMaxValue

traverseLeftNode:
invoke findMin , ebx 
jmp final

foundMaxValue:
mov eax , [rootNode]
mov minValueNode , eax
mov eax , [eax]
mov minValue , eax

final:
ret
findMin endp
;///////////////////////////////////// Delete Function ///////////////////////////////////////////
deleteNode proc , rootNode: ptr dword , value : dword

mov edx , value 
mov ecx , 0
l1:

mov ebx , rootNode
mov ebx , [ebx]

cmp ebx , edx
je breakLoop
cmp ebx , 0
je breakLoop

cmp edx , ebx
jb traverseLeft
jmp traverseRight

traverseLeft:

mov eax , rootNode
mov esi , eax
sub eax , offset bst
add esi , eax
add esi , 4
mov rootNode , esi
jmp fina1_1

traverseRight:
mov eax , rootNode
mov esi , eax
sub eax , offset bst
add esi , eax
add esi , 8
mov rootNode , esi
jmp fina1_1

fina1_1:

loop l1

breakLoop:

mov ebx , rootNode
mov ebx , [ebx]

cmp ebx , 0
je valueNotFound

mov eax , rootNode
mov esi , eax
sub eax , offset bst
add esi , eax
mov edi , esi
add edi , 4
add esi , 8
 
mov ecx , [edi]
cmp ecx , 0
je case1 ; if left is null
jmp case2 ; else case

case1:
mov ecx , [esi]
cmp ecx , 0
jne case2 ; if right is not null

mov eax , 0
mov ebx , rootNode
mov [ebx] , eax
jmp valueDeleted

case2:
mov ecx , [esi]
cmp ecx , 0 
jne deleteAtRight ; if right is not null
jmp deleteAtLeft ; if rght is null

deleteAtRight:
mov ecx , [edi]
cmp ecx , 0
jne case3

invoke findMin , esi
mov esi , minValueNode
mov eax , [esi]
mov ebx , rootNode
mov [ebx] , eax
invoke deleteNode , esi , eax
jmp valueDeleted

deleteAtLeft:
invoke findMax , edi
mov edi , maxValueNode
mov eax , [edi]
mov ebx , rootNode
mov [ebx] , eax
invoke deleteNode , edi , eax
jmp valueDeleted

case3:

mov eax , rootNode
sub eax , offset bst
add eax , rootNode
add eax , 8
mov ecx , 0
mov edx, rootNode
l2:

mov ebx , [eax]
cmp ebx , 0
je foundValue

mov edx, eax
sub eax , offset bst
add eax , edx
add eax , 4

loop l2

foundValue:
mov ebx , [edx]
mov eax , rootNode
mov [eax] , ebx

mov eax , edx
sub edx , offset bst
add edx , eax
add edx , 8

mov ebx , [edx]
cmp ebx , 0
jne callAnotheFun

mov ebx , 0
mov [eax] , ebx
jmp valueDeleted

callAnotheFun:

mov ebx , [eax]
invoke deleteNode , eax , ebx
jmp valueDeleted

valueDeleted:
mov deleteFlag , 1
jmp final_2

valueNotFound:
mov deleteFlag , 0
mov edx, offset notdelString
call writeString
call crlf

final_2:
ret
deleteNode endp
end main