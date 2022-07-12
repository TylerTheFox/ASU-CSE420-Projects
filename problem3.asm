# Student Name:                             Brandan Tyler Lasley
# Student ID:                               1214587374 
# Class:			            CSE420
# Project:                                  1

.data
ret:  		.asciiz "The computed result is "
array: 		.word 5,4,3,2,1 #!!!!! If you change the size of the array update array_len with the new size !!!
array_len:   	.byte 5

# Below is the the C++14 code for the MIPS code below
# or at least what its based off of.

#include <stdio.h> 
#include <stdlib.h> // For exit() 

#int func(int* arr, int arr_len, int pos);

#int main()
#{
#    int arr[5] = { 6,4,3,6,1 };
#    int arr_len = 5;
#
#    int ret = func(&arr[0], arr_len, 0);
#
#    return 0;
#}

#int func(int* arr, int arr_len, int pos)
#{
#    if (pos == arr_len - 1)
#        return 0;
#
#    int val1 = arr[pos];
#    int val2 = arr[pos + 1];
#
#    return (val1 - val2) + func(arr, arr_len, pos+1);
#}

.text 
.globl main 
main:
	# Load Array
	la $t1, array_len
	lb $t2, 0($t1)
	la $t1, array # T1 is the array pointer

	xor $v0, $v0, $v0
		
	# Call func
	xor $a0, $a0, $a0
	xor $a1, $a1, $a1
	xor $a2, $a2, $a2 # $a2 can stay at 0.
	addi $a0, $t1, 0
	subi $a1, $t2, 1
	jal func
	
    	add $s2, $s2, $v0
	
    	la  $a0, ret  			# set 
    	addi $v0, $0, 4			# set
    	syscall				# call print

    	addi $v0, $0, 1 		# set command to print integer $t0
    	add $a0, $0, $s2 		# load value of integer $t0
    	syscall 			# call print integer  
	
    	# Exit
    	li $v0, 10
    	syscall
func:
	addi $sp, $sp, -12 
	sw   $ra, 0($sp)
	sw   $s0, 4($sp)
	beq $a2, $a1, exit
	
	
	# lol I don't feel like learning to init correctly.
	xor $t1, $t1, $t1
	xor $t2, $t2, $t2
	xor $t3, $t3, $t3
	xor $t4, $t4, $t4
	xor $t5, $t5, $t5
	xor $t6, $t6, $t6
	xor $t7, $t7, $t7
	xor $t0, $t0, $t0
	
	addi $t6, $t6, 4 # This is a waste but whatever
	
	# Arr[n]
	mult $a2, $t6 # pos * 4
	mflo $t2
	add $t1, $a0, $t2 # $t1 = array_ptr + (pos * 4)
	lw $t5, 0($t1) # Arr[n]

	# Arr[n+1]
	addi $t1, $a2, 1
	mult $t1, $t6 # pos * 4
	mflo $t2
	add $t1, $a0, $t2 # $t1 = array_ptr + (pos * 4)
	lw $t7, 0($t1) # Arr[n+1]
	
	xor $s0,$s0,$s0
	sub $s0, $t5, $t7
	sw  $s0, 8($sp)
	lw   $s0, 8($sp)
	addi $a2, $a2, 1
	jal func	
	lw   $s0, 8($sp)
	add $v0, $v0, $s0
exit:
        lw   $ra, 0($sp)        # read registers from stack
	lw   $s0, 4($sp)
        addi $sp, $sp, 12       # bring back stack pointer
	jr $ra