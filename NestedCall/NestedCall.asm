@256
D=A
@SP
M=D
// function Sys.init 0 
(Sys.Sys.init$)
// push constant 4000 
@4000
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
// push constant 5000 
@5000
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
// call Sys.main 0 
@Sys.Sys.init$ret.0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@0
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@R14
A=M
0; JMP
(Sys.Sys.init$ret.0)
// pop temp 1 
@SP
M=M-1
@1
D=A
@R13
M=D
@5
D=A
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// label LOOP 
(LOOP)
// goto LOOP 
@LOOP
0; JMP
// function Sys.main 5 
(Sys.Sys.main$Sys.main)
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
// push constant 4001 
@4001
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
// push constant 5001 
@5001
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
// push constant 200 
@200
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 1 
@SP
M=M-1
@1
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
// push constant 40 
@40
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 2 
@SP
M=M-1
@2
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
// push constant 6 
@6
D=A
@SP
A=M
M=D
@SP
M=M+1
// pop local 3 
@SP
M=M-1
@3
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
// push constant 123 
@123
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Sys.add12 1 
@Sys.Sys.main$ret.0
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@SP
D=M
@1
D=D-A
@5
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@R14
A=M
0; JMP
(Sys.Sys.main$ret.0)
// pop temp 0 
@SP
M=M-1
@0
D=A
@R13
M=D
@5
D=A
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
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
// push local 2 
@2
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 3 
@3
D=A
@LCL
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push local 4 
@4
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
// add 
@SP
AM=M-1
D=M
@SP
AM=M-1
MD=D+M
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
// add 
@SP
AM=M-1
D=M
@SP
AM=M-1
MD=D+M
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
// function Sys.add12 0 
(Sys.Sys.add12$Sys.add12)
// push constant 4002 
@4002
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
// push constant 5002 
@5002
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
// push constant 12 
@12
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
