@256
D=A
@SP
M=D
// function SimpleFunction.test 2 
(SimpleFunction.SimpleFunction.test$)
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
// push local 1 
@1
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
// not 
@SP
AM=M-1
M=!M
@SP
M=M+1
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
// add 
@SP
AM=M-1
D=M
@SP
AM=M-1
MD=D+M
@SP
M=M+1
// push argument 1 
@1
D=A
@ARG
A=D+M
D=M
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
// return 
@LCL
D=M
@R13
M=D
@5
D=D-A
A=D
D=M
@R14
M=D
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
@ARG
D=M+1
@SP
M=D
@R13
A=M-1
D=M
@THAT
M=D
@R13
A=M-1
A=A-1
D=M
@THIS
M=D
@R13
A=M-1
A=A-1
A=A-1
D=M
@ARG
M=D
@R13
A=M-1
A=A-1
A=A-1
A=A-1
D=M
@LCL
M=D
@R14
A=M
0; JMP
