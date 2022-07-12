# Student Name:                             Brandan Tyler Lasley
# Student ID:                               1214587374 
# Class:			            CSE420
# Project:                                  1

.data
ret:  		.asciiz "The result of updateSum is "
array: 		.word 1,2,3,4,5 #!!!!! If you change the size of the array update array_len with the new size !!!
array_len:   	.byte 5

.text 
.globl main 
main:
	# $t1 is a pointer tmp
	# $t2 contains array len
	# $t3 contains THE sum
	# $t4 contains the pointer position
	# $t5 is temp working
	# $t6 contains 4
	
	xor $t6, $t6, $t6
	xor $t4, $t4, $t4
	addi $t6, $t6, 4
	
	# Load Array Len
	la $t1, array_len
	lb $t2, 0($t1)
	
	loop:
	la $t1, array
	mult $t4, $t6
	mflo $t5
	add $t1, $t1, $t5
	lw $t5, 0($t1)
	
	mult $t5, $t5
	mflo $t5
	add $t3, $t3, $t5
	
    	continue:
    	addi $t4, $t4, 1
	beq $t4, $t2, exit
    	j loop
    	
    	exit:
    	
    	la  $a0, ret  			# set 
    	addi $v0, $0, 4			# set
    	syscall				# call print
    	
    	addi $v0, $0, 1 		# set command to print integer $t0
    	add $a0, $0, $t3 		# load value of integer $t0
    	syscall 			# call print integer  
	
    	# Exit
    	li $v0, 10
    	syscall
