// push constant 3030 
@3030
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 0 
@SP
M=M-1
A=M
D=M
@THIS
M=D
// push constant 3040 
@3040
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop pointer 1 
@SP
M=M-1
A=M
D=M
@THAT
M=D
// push constant 32 
@32
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop this 2 
@SP
M=M-1
@2
D=A
@R13
M=D
@THIS
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// push constant 46 
@46
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop that 6 
@SP
M=M-1
@6
D=A
@R13
M=D
@THAT
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// push pointer 0 
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push pointer 1 
@THAT
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
// push this 2 
@2
D=A
@THIS
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
// push that 6 
@6
D=A
@THAT
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
(END)
@END
0;JMP
