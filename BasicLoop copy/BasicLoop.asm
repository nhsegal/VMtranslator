// push constant 0 
@0
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 0 
@SP
M=M-1
@0
D=A
@R13
M=D
@LCL
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// label LOOP_START 
(LOOP_START)
// push argument 0 
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 0 
@0
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// add 
@SP
AM=M-1
D=M
@SP
AM=M-1
MD=D+M
@SP
M=M+1
// pop local 0 
@SP
M=M-1
@0
D=A
@R13
M=D
@LCL
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// push argument 0 
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push constant 1 
@1
D=A
@SP
A=M
M=D
@SP
M=M+1
// sub 
@SP
AM=M-1
D=M
@SP
AM=M-1
MD=M-D
@SP
M=M+1
// pop argument 0 
@SP
M=M-1
@0
D=A
@R13
M=D
@ARG
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// push argument 0 
@0
D=A
@ARG
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// if-goto LOOP_START 
@SP
A=M-1
D=M
D; JNE
@SP
M=M-1
// push local 0 
@0
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
(END)
@END
0;JMP
