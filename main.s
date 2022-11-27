	.intel_syntax noprefix
	.text
	.section	.rodata
.LC0:
	.string	"%lf"
	.text
	.globl	inputRead
	.type	inputRead, @function
inputRead:
	endbr64
	push	rbp
	mov	rbp, rsp # prologue
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi
	lea	rdx, -8[rbp]
	mov	rax, QWORD PTR -24[rbp]
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT #fscanf(f, "%lf", &tmp);
	movsd	xmm0, QWORD PTR -8[rbp]
	leave
	ret #return tmp;
	.size	inputRead, .-inputRead
	.globl	accuracy
	.type	accuracy, @function
accuracy:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -40[rbp], xmm0
	movsd	QWORD PTR -48[rbp], xmm1
	movsd	xmm0, QWORD PTR .LC1[rip]
	movsd	QWORD PTR -8[rbp], xmm0 #  double pi = 3.141592;
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -48[rbp] # pi * e
	movsd	xmm1, QWORD PTR .LC2[rip] # pi * e / 100
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -8[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0 # double upperbound = pi + pi * e / 100;
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -48[rbp] # pi * e
	movsd	xmm1, QWORD PTR .LC2[rip] #  e / 100
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0 # double lowerbound = pi - pi * e / 100;
	movsd	xmm0, QWORD PTR -40[rbp]
	comisd	xmm0, QWORD PTR -24[rbp]
	jbe	.L4
	movsd	xmm0, QWORD PTR -16[rbp]
	comisd	xmm0, QWORD PTR -40[rbp]
	jbe	.L4 #    if ((tmp > lowerbound) && (tmp < upperbound))
	mov	eax, 1
	jmp	.L7  #  return 1;
.L4:
	mov	eax, 0  # return 0;
.L7:
	pop	rbp
	ret
	.size	accuracy, .-accuracy
	.section	.rodata
.LC3:
	.string	"w"
.LC4:
	.string	"Error opening file"
	.text
	.globl	outputAns
	.type	outputAns, @function
outputAns:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	movsd	QWORD PTR -24[rbp], xmm0
	mov	QWORD PTR -32[rbp], rdi
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	jne	.L11 #     if ((out = fopen(outf, "w")) == NULL)
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT # printf("Error opening file");
	mov	eax, 0
	jmp	.L10
.L11:
	mov	rdx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC0[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT #  fprintf(out, "%lf", res);
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT # fclose(out);
.L10:
	leave
	ret
	.size	outputAns, .-outputAns
	.section	.rodata
.LC5:
	.string	"r"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 48
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi  # int main(int argc, char *argv[]) {
	mov	rax, QWORD PTR -48[rbp] # argv[1]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT # fopen(argv[1], "r"))
	mov	QWORD PTR -24[rbp], rax
	cmp	QWORD PTR -24[rbp], 0
	jne	.L14 # if ((in = fopen(argv[1], "r")) == NULL) {
	lea	rdi, .LC4[rip]
	mov	eax, 0
	call	printf@PLT # printf("Error opening file");
	mov	eax, 0
	jmp	.L15 # return 0;
.L14:
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	inputRead
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax # double eps = inputRead(in);
	mov	rax, QWORD PTR -24[rbp]
	mov	rdi, rax
	call	fclose@PLT # fclose(in);
	movsd	xmm0, QWORD PTR .LC6[rip]
	movsd	QWORD PTR -8[rbp], xmm0 # double res = 2;
	movsd	xmm0, QWORD PTR .LC7[rip]
	movsd	QWORD PTR -16[rbp], xmm0 # double an = sqrt(2);
	jmp	.L16 # while (!(accuracy(res, eps) == 1)) {
.L17:
	movsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, xmm0
	divsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -8[rbp], xmm0 # res = res * 2 / an;
	movsd	xmm1, QWORD PTR -16[rbp]
	movsd	xmm0, QWORD PTR .LC6[rip]
	addsd	xmm0, xmm1
	call	sqrt@PLT
	movq	rax, xmm0
	mov	QWORD PTR -16[rbp], rax # an = sqrt(2 + an);
.L16:
	movsd	xmm0, QWORD PTR -32[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	accuracy
	cmp	eax, 1
	jne	.L17 # while (!(accuracy(res, eps) == 1)) {
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR [rax]
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rdx
	movq	xmm0, rax
	call	outputAns # outputAns(res, argv[2]);
	mov	eax, 0
.L15:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	4236968058
	.long	1074340346
	.align 8
.LC2:
	.long	0
	.long	1079574528
	.align 8
.LC6:
	.long	0
	.long	1073741824
	.align 8
.LC7:
	.long	1719614413
	.long	1073127582
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
