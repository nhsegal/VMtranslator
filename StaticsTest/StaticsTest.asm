@256
// function Class2.set 0 
// function Class1.set 0 
D=A
@SP
M=D
@Sys.$ret.0
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
(Sys.$ret.0)
// function Sys.init 0 
(Sys.Sys.init$Sys.init)
// push constant 6 
@6
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
// call Class1.set 2 
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
@2
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
// push constant 23 
@23
D=A
@SP
A=M
M=D
@SP
M=M+1
// push constant 15 
@15
D=A
@SP
A=M
M=D
@SP
M=M+1
// call Class2.set 2 
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
@2
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
// call Class1.get 0 
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
// call Class2.get 0 
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
// label WHILE 
(WHILE)
// goto WHILE 
@WHILE
0; JMP
(Sys.Class2.set$Class2.get)
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
// pop static 0 
@SP
M=M-1
@0
D=A
@R13
M=D
@Sys.null
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
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
// pop static 1 
@SP
M=M-1
@1
D=A
@R13
M=D
@Sys.null
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// push constant 0 
@0
D=A
@SP
A=M
M=D
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
// function Class2.get 0 
(Sys.Class2.get$Class2.get)
// push static 0 
@0
D=A
@Sys.0
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1 
@1
D=A
@Sys.1
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
(Sys.Class1.set$Class2.get)
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
// pop static 0 
@SP
M=M-1
@0
D=A
@R13
M=D
@Sys.null
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
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
// pop static 1 
@SP
M=M-1
@1
D=A
@R13
M=D
@Sys.null
D=M
@R13
M=M+D
@SP
A=M
D=M
@R13
A=M
M=D
// push constant 0 
@0
D=A
@SP
A=M
M=D
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
// function Class1.get 0 
(Sys.Class1.get$Class2.get)
// push static 0 
@0
D=A
@Sys.0
A=D+M
D=M
@SP
A=M
M=D
@SP
M=M+1
// push static 1 
@1
D=A
@Sys.1
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
