	li $t0,0xFEDC5431
	li $t1,1
 	li $t3,0
	li $t2,8
start:
	bgt $t2, $zero, count
	j end
count:
	and $t4, $t0, $t1
	add $t3, $t3, $t4
	srl $t0, $t0, 4
	addi $t2, $t2, -1
	j start
end: