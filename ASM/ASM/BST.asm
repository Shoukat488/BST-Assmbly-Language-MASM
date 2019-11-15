INCLUDE Irvine32.inc 
traverseInOrder proto , rootNode : ptr byte
searchInTree proto , rootNode : ptr byte , value : dword
.data
array dword 5,4,8,6,7,10,2,3,11,14,13,12,26
multi dword 4
dividend dword 4
tempIndex dword ?
p1 byte "Inserting values : ",0
p2 byte "Traversing binray Tree in order",0
p3 byte "Enter value to search in tree : ",0
foundString byte "Value found in tree ",0
nFoundString byte "Value not found in tree ",0
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
jmp final

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
mul multi
mov edx , 0
div dividend
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
mul multi
mov edx , 0
div dividend
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
traverseInOrder proc , rootNode : ptr byte

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

searchInTree proc , rootNode : ptr byte , value : dword

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
end main