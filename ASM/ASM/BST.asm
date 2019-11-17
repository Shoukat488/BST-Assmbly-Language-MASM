INCLUDE Irvine32.inc 
traverseInOrder proto , rootNode : ptr dword
searchInTree proto , rootNode : ptr dword , value : dword
deleteNode proto , rootNode: ptr dword , value : dword
preOrder proto ,preNode : ptr dword , currentNode : ptr dowrd
findMax proto , rootNode : ptr dword
findMin proto , rootNode : ptr dword
.data
array dword 5,4,8,6,7,10,2,3,11,14,13,12,26,9,15
multi dword 4
dividend dword 4
tempIndex dword ?
maxValue dword 1
minValue dword 1
p1 byte "Inserting values : ",0
p2 byte "Traversing binray Tree in order",0
p3 byte "Enter value to search in tree : ",0
foundString byte "Value found in tree ",0
nFoundString byte "Value not found in tree ",0
maxString byte "Max value in tree : ",0
minString byte "Min value in tree ",0
deleteString byte "Value has been deleted",0
notdelString byte "Value not find ",0
bst dword 1000 dup(1)
.code
main PROC
;-------------------------
mov edx , offset p1
call writeString
call crlf
mov edx , 4
mov eax , 0
mov ebx , 0
mov ecx , 0
mov [bst] , 5
mov ecx, lengthof array
mov edi , offset bst


l1:

mov ebx, array[edx]
mov tempIndex , edx

push offset [bst + 4]
push offset [bst + 8]

call insert

add esp , 8
mov edi , offset bst
mov edx , tempIndex
add edx , 4

loop l1

call crlf
mov ecx, 15
mov esi, 0

l4:

mov eax , bst[esi]
call writeDec
call crlf
add esi , 4
loop l4
;-----------------------------------
call crlf

mov edx , offset p2
call writeString
call crlf

mov edx , 0
mov eax , 0
mov ebx , 0
mov ecx , 0

mov esi , offset bst
invoke traverseInOrder , addr bst


;----------------------------------------------

mov edx , offset p3
call writestring
call crlf
call readInt
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
jmp final

notFound:
mov edx , offset nFoundString
call writeString
call crlf



;-------------------------------------------

invoke findMax , offset bst
mov edx , offset maxString
call writeString
mov eax , maxValue
call writeDec
call crlf

;-------------------------------------------

invoke findMin , offset bst
mov edx , offset minString
call writeString
mov eax , minValue
call writeDec
call crlf

;-------------------------------------------
mov eax , 7
invoke deleteNode , offset bst , eax
final:
exit


main endp
;//////////////////////////////////////////////// Insert Function //////////////////////////////////////////
insert proc

push ebp
mov ebp , esp

cmp ebx , [edi]
je final

mov eax , [edi]

cmp  ebx , eax
jb leftNode
jmp rightNode

leftNode:
mov eax, [ebp + 12]
mov eax , [eax]
cmp eax , 1
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
call writeDec
call crlf
jmp final

rightNode:
mov eax, [ebp + 8]
mov eax , [eax]
cmp eax ,1
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
call writeDec
call crlf
jmp final

assigValueAtRoot:
mov [edi] , ebx
mov eax , [edi]
call writeDec
call crlf
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
mul multi
mov edx , 0
div dividend
add ebx , eax
add ebx , 4
mov eax , [ebx]

cmp eax , 1
jne traverseLeftNode

print:
mov eax , [rootNode]
mov eax , [eax]
call writeDec
call crlf

mov eax , rootNode
mov ebx , rootNode
sub eax , esi
mul multi
mov edx , 0
div dividend
add ebx , eax
add ebx , 8
mov eax , [ebx]

cmp eax , 1
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
mul multi
mov edx , 0
div dividend
add ebx , eax
add ebx , 4
mov eax , [ebx]

cmp eax , 1
jne traverseLeftNode

comeBack:
mov eax , rootNode
mov ebx , rootNode
sub eax , offset bst
mul multi
mov edx , 0
div dividend
add ebx , eax
add ebx , 8
mov eax , [ebx]

cmp eax , 1
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
mul multi
mov edx , 0
div dividend
add ebx , eax
add ebx , 8
mov eax , [ebx]

cmp eax , 1
jne traverseRightNode
jmp foundMaxValue

traverseRightNode:
invoke findMax , ebx 
jmp final

foundMaxValue:
mov eax , [rootNode]
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
mul multi
mov edx , 0
div dividend
add ebx , eax
add ebx , 4
mov eax , [ebx]

cmp eax , 1
jne traverseLeftNode
jmp foundMaxValue

traverseLeftNode:
invoke findMin , ebx 
jmp final

foundMaxValue:
mov eax , [rootNode]
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
cmp ebx , 1
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

cmp ebx , 1
jmp valueNotFound

mov eax , rootNode
mov esi , eax
sub eax , offset bst
add esi , eax
mov edi , esi
add edi , 4
add esi , 8
 
mov ecx , [edi]
cmp ecx , 1
je case1
jmp case2

case1:
mov ecx , [esi]
cmp ecx , 1
jne case2

mov eax , 1
mov [rootNode] , eax
jmp valueDeleted

case2:
mov ecx , [esi]
cmp ecx , 1
jne deleteAtRight
jmp deleteAtLeft

deleteAtRight:
mov ecx , [esi]
cmp ecx , 1
jne case3
mov eax , rootNode
invoke preOrder , eax , esi
jmp valueDeleted

deleteAtLeft:
mov ecx , [edi]
cmp ecx , 1
jne case3
mov eax , rootNode
invoke preOrder ,eax , edi
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
cmp ebx , 1
je foundValue

mov edx, eax
sub eax , offset bst
add eax , edx
add eax , 4

loop l2

foundValue:
mov ebx , [edx]
mov [rootNode] , ebx

mov eax , edx
sub edx , offset bst
add edx , eax
add edx , 8

mov ebx , [edx]
mov edx , 1
jne callAnotheFun

mov ebx , 1
mov [eax] , ebx
jmp valueDeleted

callAnotheFun:
invoke preOrder , eax , edx
jmp valueDeleted

valueDeleted:
mov edx, offset deleteString
call writeString
call crlf
jmp final_2

valueNotFound:
mov edx, offset notdelString
call writeString
call crlf

final_2:
ret
deleteNode endp
;///////////////////////////////////// PreOrder Function ///////////////////////////////////////////
preOrder proc ,preNode : ptr dword , currentNode : ptr dowrd

mov eax , currentNode
mov eax , [eax]
mov [preNode] , eax

mov eax, 1
mov [currentNode] , eax

mov eax , currentNode
sub eax , offset bst
add eax , currentNode
add eax , 4

mov ebx , [eax]
cmp ebx , 1
jne traverseLeft

comeback:
mov eax , currentNode
sub eax , offset bst
add eax , currentNode
add eax , 8

mov ebx , [eax]
cmp ebx , 1
jne traverseRight
jmp final

traverseLeft:
invoke preOrder , currentNode , eax
jmp comeback

traverseRight:
invoke preOrder , currentNode , eax

final:
ret
preOrder endp
end main
