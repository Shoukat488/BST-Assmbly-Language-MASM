include Irvine32.inc

Get_frequencies proto , alphaTab : ptr byte, freqTab : dword
.data
target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
.code
main proc

INVOKE Get_frequencies, ADDR target, ADDR freqTable
exit
main endp
Get_frequencies proc , alphaTab : ptr byte, freqTab : dword

mov esi, alphaTab

mov ecx , lengthof alphaTab

l1:

mov al , [esi]
mov eax , al
add freqTab[eax] , 1
inc esi
loop l1

ret
Get_frequencies endp
end main