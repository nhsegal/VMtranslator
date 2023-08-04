// push constant 10 
@10
D=A
@SP
A=M
M=D
@SP
M=M+1
// push static 10 
@10
D=A
@test1.10
D=M+D
@SP
M=M+1
