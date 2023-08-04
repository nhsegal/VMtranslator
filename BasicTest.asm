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
@temp
M=D
@LCL
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
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
@temp
M=D
@ARG
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
// pop argument 1 
@SP
M=M-1
@1
D=A
@temp
M=D
@ARG
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
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
@temp
M=D
@THIS
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
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
@temp
M=D
@THAT
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
// pop that 2 
@SP
M=M-1
@2
D=A
@temp
M=D
@THAT
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
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
@temp
M=D
undefined
D=M
@temp
M=M+D
@SP
A=M
D=M
@temp
A=M
D=M
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
D=D+A
// push argument 1 
@1
D=A
@ARG
D=M+D
@SP
M=M+1
// sub 
D=D-A
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
D=D+A
// sub 
D=D-A
// push temp 6 
@6
D=A
undefined
D=M+D
@SP
M=M+1
// add 
D=D+A
