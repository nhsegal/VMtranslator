@256
D=A
@SP
M=D
@1015
D=A
@LCL
M=D
// push constant 10 
@10
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
@R5
M=D
@LCL
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// push constant 21 
@21
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 22 
@22
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop argument 2 
@SP
M=M-1
@2
D=A
@R5
M=D
@ARG
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// pop argument 1 
@SP
M=M-1
@1
D=A
@R5
M=D
@ARG
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// push constant 36 
@36
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop this 6 
@SP
M=M-1
@6
D=A
@R5
M=D
@THIS
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// push constant 42 
@42
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 45 
@45
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop that 5 
@SP
M=M-1
@5
D=A
@R5
M=D
@THAT
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// pop that 2 
@SP
M=M-1
@2
D=A
@R5
M=D
@THAT
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// push constant 510 
@510
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop temp 6 
@SP
M=M-1
@6
D=A
@R5
M=D
@5
D=M
@R5
M=M+D
@SP
AD=M
@R5
AD=M
// push local 0 
@0
D=A
@LCL
D=M+D
@SP
M=M+1
// push that 5 
@5
D=A
@THAT
D=M+D
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
D=M+D
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
// push this 6 
@6
D=A
@THIS
D=M+D
@SP
M=M+1
// push this 6 
@6
D=A
@THIS
D=M+D
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
// sub 
@SP
AM=M-1
D=M
@SP
AM=M-1
MD=M-D
@SP
M=M+1
// push temp 6 
@6
D=A
@65
D=M+D
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