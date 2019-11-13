INCLUDE Irvine32.inc 
insert proto  , left : dword , right: dword 
.data
bst dword 1000 dup(1)
array dword 4,5,6,8,9
multi dword 4
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

mov edx , tempIndex
add edx , 4

loop l1

mov ecx , 70
mov esi , 0

l2:
mov eax , bst[esi]
call writeDec
call crlf
add esi , 4
loop l2

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
cmp [left] , 1
je assignValueAtLeft

mov eax , left
mov edi , eax
sub eax , esi
mul multi
add left , eax 
add left , 4
add right , eax
add right , 8

invoke insert , left , right 
jmp final

assignValueAtLeft:
mov [left] , ebx
jmp final

rightNode:
cmp [right] ,1
je assignValueAtRight
mov eax , right
mov edi , eax
sub eax , esi
mul multi
add left , eax 
add left , 4
add right , eax
add right , 8

invoke insert , left , right
jmp final

assignValueAtRight:
mov [edi] , ebx
jmp final

assigValueAtRoot:
mov [edi] , ebx
jmp final

final:
ret

insert endp

traverseInOrder proc




traverseInOrder endp
end main