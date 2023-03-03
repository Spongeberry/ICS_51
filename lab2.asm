#                                           ICS 51, Lab #2
# 
#                                          IMPORTANT NOTES:
# 
#                       Write your assembly code only in the marked blocks.
# 
#                       DO NOT change anything outside the marked blocks.
#
#

###############################################################
#                           Text Section
.text

###############################################################
###############################################################
###############################################################
#                            PART 1 (Fibonacci)
#
# 	The Fibonacci Sequence is the series of integer numbers:
#
#		0, 1, 1, 2, 3, 5, 8, 13, 21, 34, ...

#	The next number is found by adding up the two numbers before it.
	
#	The `2` is found by adding the two numbers before it (1+1)
#	The `3` is found by adding the two numbers before it (1+2),
#	And the `5` is (2+3),
#	and so on!
#
# You should compute N ($a0) number of elements of fibonacci and put
# in array, named fib_array.
# 
fibonacci:
# $a0: Number of elements. 
# fib_array: The destination array.
################## Part 1: your code begins here ###############

la $s1, fib_array
li $t9, 0
sw $t9, 0($s1)
li $t8, 1
sw $t8, 4($s1)
addi $s1, $s1, 8
subi $a0, $a0, 2
start:
bgtz $a0, loop
j end
loop:
lw $t0, -8($s1)
lw $t1, -4($s1)
add $t2, $t0, $t1
sw $t2, 0($s1)
addi $s1, $s1, 4
subi $a0, $a0, 1
j start

end:
############################## Part 1: your code ends here   ###
jr $ra

###############################################################
###############################################################
###############################################################
#                  PART 2 (local maximum points)
# Write a function in MIPS assembly that takes an array of 
# integers and finds local maximum points. i.e., points that if 
# the input entry is larger than both adjacent entries. The 
# output is an array of the same size of the input array. The 
# output point is 1 if the corresponding input entry is a 
# relative maximum, otherwise 0. (You should ignore the output
# array's boundary items, set to 0.) 
# 
# For example,
# 
# the input array of integers is {1, 3, 2, 4, 6, 5, 7, 8}. Then,
# the output array of integers should be {0, 1, 0, 0, 1, 0, 0, 0}
# 
# (Note: The first/last entry of the output array is always 0
#  since it's ignored, never be a local maximum.)
# $a0: The base address of the input array
# $a1: The base address of the output array with local maximum points
# $a2: Size of array
find_local_maxima:
############################ Part 2: your code begins here ###
subi $a2, $a2, 2
addi $a0, $a0, 4
#sw $0, 0($a1) 
addi $a1, $a1, 4

start1:
bgtz $a2, loop1
j end1
loop1:
lw $t0, 0($a0)
lw $t1, -4($a0)
lw $t2, 4($a0)
li $t3, 0
sgt $t4, $t0, $t1
add $t3, $t3, $t4
sgt $t6, $t0, $t2
add $t3, $t3, $t6
li $t5, 1
li $t7, 2
beq $t3, $t7, set1
sw $0, 0($a1)
j skip
set1:
sw $t5, 0($a1)
skip:
addi $a0, $a0, 4
addi $a1, $a1, 4
subi $a2, $a2, 1

j start1
end1:
#sw $0, 0($s1)
############################ Part 2: your code ends here ###
jr $ra

###############################################################
###############################################################
###############################################################
#                       PART 3 (Change Case)
# Complete the change_case function that takes a Null-terminated
# string and converts the lowercase characters (a-z) to 
# uppercase and convert the uppercase ones (A-Z) to lower case. 
# Your function should also ignore non-alphabetical characters. 
# For example, "L!A##b@@3" should be converted to "laB". 
# In null-terminated strings, end of the string is specified 
# by a special null character (i.e., value of 0).

#a0: The base address of the input array
#a1: The base address of the output array
###############################################################
change_case:
############################## Part 3: your code begins here ###
loop2:
lb $t0, 0($a0)
beqz $t0, end2
li $t1, 65
bltu $t0, $t1, ignore
li $t2, 122
bgtu $t0, $t2, ignore
li $t3, 91
bltu $t0, $t3, codown
li $t4, 96
bgtu $t0, $t4, coup
j ignore
codown:
addi $t0, $t0, 32
sb $t0, 0($a1)
addi $a1, $a1, 1
j ignore
coup:
subi $t0, $t0, 32
sb $t0, 0($a1)
addi $a1, $a1, 1
j ignore
ignore:
addi $a0, $a0, 1
j loop2
end2:
sb $0, 0($a1)
############################## Part 3: your code ends here ###
jr $ra
