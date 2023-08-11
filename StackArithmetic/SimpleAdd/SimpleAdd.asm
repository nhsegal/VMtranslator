@256
D=A
@SP
M=D
@1015
D=A
@LCL
M=D
// push constant 7 
@7
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 8 
@8
D=A
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
