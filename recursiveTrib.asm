.data
	trib0Text: .asciiz "Enter tribonacci(0): "
	trib1Text: .asciiz "Enter tribonacci(1): "
	trib2Text: .asciiz "Enter tribonacci(2): "
	nTermText: .asciiz "Enter n: "
	tribNTextStart: .asciiz "tribonacci("
	tribNTextEnd: .asciiz "): "

.text

main:

#prompts user for tribonacci(0)
trib0:
li $v0, 4
la $a0, trib0Text
syscall

#takes and stores the user's input, the branch makes sure trib0 >= 0
li $v0, 5
syscall

move $s0, $v0

blt $s0, $zero, trib0

#prompts user for tribonacci(1)
trib1:
li $v0, 4
la $a0, trib1Text
syscall

#takes and stores the user's input, the branch makes sure trib1 >= 0
li $v0, 5
syscall

move $s1, $v0

blt $s1, $zero, trib1


#prompts user for tribonacci(2)
trib2:
li $v0, 4
la $a0, trib2Text
syscall

#takes and stores the user's input, the branch makes sure trib2 >= 0
li $v0, 5
syscall

move $s2, $v0

blt $s2, $zero, trib2


#prompts user for n
nTerm:
li $v0, 4
la $a0, nTermText
syscall

#takes and stores the user's input, the branch makes sure n >= 0
li $v0, 5
syscall

move $s3, $v0

blt $s3, $zero, nTerm




#calls trib function
#stores n in $a2 
add $a2, $s3, $zero


jal trib

#move the value of trib(n) to a1
move $a1, $s5

j end






#prints the results
end:

li $v0, 4
la $a0, tribNTextStart
syscall

li $v0, 1
move $a0, $s3
syscall

li $v0, 4
la $a0, tribNTextEnd
syscall

li $v0, 1
move $a0, $a1
syscall

#ends program
li $v0, 10
syscall 





trib:
#size of stack
addi $sp, $sp, -12

sw $ra, 0($sp) #stores address on stack
sw $s4, 4($sp) #current location of n
sw $s5, 8($sp) #value of trib(n)

#sets s4 equal to n
move $s4, $a2

beq $s4, 0, return0 #if n==0
beq $s4, 1, return1 #if n==1
beq $s4, 2, return2 #if n==2

#n = n - 1
addi $a2, $s4, -1

jal trib
#shifts stack down
addi $sp, $sp, -12

#n = n - 2
addi $a2, $s4, -2

jal trib
#shifts stack down
addi $sp, $sp, -12

#n = n - 3
addi $a2, $s4, -3


jal trib

#resets stack back to current position
addi $sp, $sp, 24

lw $t0, -4($sp) # t0 = n - 1
lw $t1, -16($sp) #t1 = n - 2
lw $t2, -28($sp) #t2 = n - 3


# t0 + t1 + t2
add $s5, $t0, $t1
add $s5, $t2, $s5

#stores s5
sw $s5, 8($sp)

exitTrib:

lw $ra, 0($sp)
lw $s4, 4($sp)
lw $s5, 8($sp)
addi $sp, $sp, 12
jr $ra


return0:
sw $s0, 8($sp)
j exitTrib

return1:
sw $s1, 8($sp)
j exitTrib

return2:
sw $s2, 8($sp)
j exitTrib

