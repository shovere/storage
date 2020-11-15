.section .data

input_x_prompt	:	.asciz	"Please enter x: "
input_y_prompt	:	.asciz	"Please enter y: "
input_spec	:	.asciz	"%d"
result		:	.asciz	"x^y = %d\n"

.section .text

.global main

main:
	ldr x0, =input_x_prompt
	bl printf
	bl getInput

	ldr x0, =input_y_prompt
	bl printf
	bl getInput

	ldrsw x0, [sp, 16]
	ldrsw x1, [sp, 0]
	add sp,sp,32

	bl pow

	mov x1, x2
	ldr x0, =result
	bl printf

	b exit

getInput:
	sub sp, sp, 8
	str x30, [sp]

	ldr x0, =input_spec
	sub sp, sp, 8
	mov x1, sp
	bl scanf

	ldr x30, [sp, 8]
	ret

pow:

	mov x2, 0

	subs x3, x0, 0
	b.eq GONE
	subs x3, x1, 0
	b.mi GONE
	mov x2, 1
	b.eq GONE

	sub sp, sp, 24
	str x30, [sp, 0]
	str x0, [sp, 8]
	str x1, [sp,16]

	sub x1, x1, 1
	bl pow
	ldr x30, [sp,0]
	ldrsw x0, [sp, 8]
	add sp,sp,24
	mul x2, x0, x2

	GONE: ret 


# branch to this label on program completion
exit:
	mov x0, 0
	mov x8, 93
	svc 0
	ret
