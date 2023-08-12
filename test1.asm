@256
D=A
@SP
M=D
@1015
D=A
@LCL
M=D
// push constant 12 
@12
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 5 
@5
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 2 
@SP
MD=M-1
@2
D=A
@R5
M=D
@LCL
D=M
@R5
M=M+D
A=M
M=D
