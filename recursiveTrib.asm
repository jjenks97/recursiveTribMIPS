.data
	trib0Text: .asciiz "Enter tribonacci(0): "
	trib1Text: .asciiz "Enter tribonacci(1): "
	trib2Text: .asciiz "Enter tribonacci(2): "
	nTermText: .asciiz "Enter n: "
	tribNTextStart: .asciiz "tribonacci("
	tribNTextEnd: .asciiz "): "

.text
#prompts user for tribonacci(0)
trib0:
li $v0, 4
la $a0, trib0Text
syscall

#takes and stores the user's input, the branch makes sure trib0 >= 0
li $v0, 5
syscall

move $t0, $v0

blt $t0, $zero, trib0

#prompts user for tribonacci(1)
trib1:
li $v0, 4
la $a0, trib1Text
syscall

#takes and stores the user's input, the branch makes sure trib1 >= 0
li $v0, 5
syscall

move $t1, $v0

blt $t1, $zero, trib1


#prompts user for tribonacci(2)
trib2:
li $v0, 4
la $a0, trib2Text
syscall

#takes and stores the user's input, the branch makes sure trib2 >= 0
li $v0, 5
syscall

move $t2, $v0

blt $t2, $zero, trib2


#prompts user for n
nTerm:
li $v0, 4
la $a0, nTermText
syscall

#takes and stores the user's input, the branch makes sure n >= 0
li $v0, 5
syscall

move $t3, $v0

blt $t3, $zero, nTerm

#in case the user sets n as 0, 1, or 2
ble $t3, 2, nLessThan3

#subtracts 3 from n
sub $t5, $t3, 3
tribAdd:
#adds trib 1, 2, and 3 and stores in $t4
add $t4, $t0, $t1
add $t4, $t4, $t2

#exit condition n == 0

beqz $t5, end

#sets trib0 = trib1, trib1 = trib2, and trib3 = $t4
add $t0, $t1, $zero
add $t1, $t2, $zero
add $t2, $t4, $zero

#n = n - 1
sub $t5, $t5, 1

#jumps to tribAdd
j tribAdd







#in case user enters a value for n that is less than 3
nLessThan3:
beq $t3, 2, nEquals2
beq $t3, 1, nEquals1
beq $t3, 0, nEquals0

nEquals2:
move $t4, $t2
b end

nEquals1:
move $t4, $t1
b end

nEquals0:
move $t4, $t0
b end



#prints the results
end:

li $v0, 4
la $a0, tribNTextStart
syscall

li $v0, 1
move $a0, $t3
syscall

li $v0, 4
la $a0, tribNTextEnd
syscall

li $v0, 1
move $a0, $t4
syscall





