INCLUDE Irvine32.inc 
insert proto  , left : dword , right: dword 
traverseInOrder proto , rootNode : ptr byte
.data
bst dword 1000 dup(1)
array dword 5,4,8,6,7,10,2,18,14,15
multi dword 4
dividend dword 4
tempIndex dword ?
.code
main PROC


mov edx , 0
mov eax , 0
mov ebx , 0
mov ecx , 0

mov esi , offset bst
mov ecx, lengthof array
mov edi , offset bst
l1:
mov ebx, array[edx]
mov tempIndex , edx

invoke insert  , addr [ bst + 4 ] , addr [ bst + 8 ] 
mov edi , offset bst
mov edx , tempIndex
add edx , 4

loop l1

call crlf

mov edx , 0
mov eax , 0
mov ebx , 0
mov ecx , 0

mov esi , offset bst
invoke traverseInOrder , addr bst

exit


main endp
insert proc , left : dword , right: dword 

cmp ebx , [edi]
je final

mov eax , [edi]
cmp eax , 1
je assigValueAtRoot

cmp  ebx , eax
jb leftNode
jmp rightNode

leftNode:
mov eax, [left]
mov eax , [eax]
cmp eax , 1
je assignValueAtLeft

mov eax , left
mov edi , eax
sub eax , esi
mul multi
mov edx , 0
div dividend
add left , eax 
add left , 4
add right , eax
add right , 8

invoke insert , left , right 
jmp final

assignValueAtLeft:
mov [left] , ebx
mov eax , [left]
call writeDec
call crlf
jmp final

rightNode:
mov eax, [right]
mov eax , [eax]
cmp eax ,1
je assignValueAtRight
mov eax , right
mov edi , eax
sub eax , esi
mul multi
mov edx , 0
div dividend
add left , eax 
add left , 4
add right , eax
add right , 8

invoke insert , left , right
jmp final

assignValueAtRight:
mov [right] , ebx
mov eax , [right]
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
ret

insert endp

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
end main