if (process.argv.length < 3) {
  console.log('Usage: node ' + process.argv[1] + ' FILENAME');
  process.exit(1);
}

const filename = process.argv[2];
const path = require('path');
const readline = require('readline');
const fs = require('fs');

function processFile(inputFilePath, outputFilePath) {
  const fileStream = fs.createReadStream(inputFilePath);
  const writer = fs.createWriteStream(outputFilePath, { flags: 'w' });
  const rl = readline.createInterface({
    input: fileStream,
    ctrlDelay: Infinity,
  });

  let start = true;

  rl.on('line', (line) => {
    // Initialization - Comment out 
    
    if (start){
      start = false;
      /*
      writer.write('@256\n')
      writer.write('D=A\n')
      writer.write('@SP\n')
      writer.write('M=D\n')
      writer.write('@1015\n')
      writer.write('D=A\n')
      writer.write('@LCL\n')
      writer.write('M=D\n')
      */
    }

    const strippedLine = removeComments(line);
    if (strippedLine) {
      writer.write(generateComment(strippedLine));
      writer.write(parse(strippedLine));
    }
  });

  rl.on('close', () => {
    console.log('Processing done'); 
    writer.write('(END)\n')
    writer.write('@END\n')
    writer.write('0;JMP\n')
    writer.end();
  });
}

const inputFilePath = filename;
const outputFilePath = path.join(
  path.dirname(filename),
  path.basename(filename, path.extname(filename)) + '.asm'
);

processFile(inputFilePath, outputFilePath);

function removeComments(line) {
  if (line.startsWith('//') || line.trim() == '') {
    return null;
  }
  return line;
}

function generateComment(line) {
  return `// ${line} \n`;
}

function parse(currentCmd) {
  const cmdArgs = currentCmd.split(' ') 
  if (cmdArgs.length == 3) {
    return writePushPop(currentCmd);
  }
  if (cmdArgs.length == 2) {
    return writeLogic(currentCmd);
  }
  if (cmdArgs.length == 1) {
    return writeArithmetic(currentCmd);
  }
  return 'ERROR: NEITHER arith nor pushpop \n';
}


function writePushPop(currentCmd) {
  let output = '';
  const args = currentCmd.split(' ');

  if (args[0] == 'push') {
    /// NEED TO DO pointer
    if (args[1] == 'pointer') {
      output += 'NOT YET IMPLEMENTED POINTER\n';
    } else if (args[1] == 'constant') {
      output += `@${args[2]}\n`;
      output += 'D=A\n';
      output += `@SP\n`;
      output += 'A=M\n';
      output += 'M=D\n';
      output += '@SP\n'; // Increment stack pointer
      output += 'M=M+1\n';
    } else {
       // ISSUE with push
      output += `@${args[2]}\n`; // @offset
      output += 'D=A\n'; // D gets offset
      output += `${getSegment(args[1], args[2])}\n`; // A gets 1, M gets RAM[1]
      if (args[1] == 'temp'){
        output += `A=D+A\n`;
      } else {
        output += `A=D+M\n`;
      }
      
      //output += 'A=D+A\n'; 
      output += 'D=M\n'; 
      output += '@SP\n'; 
      output += 'A=M\n'; 
      output += 'M=D\n'; 
      output += '@SP\n'; // Increment stack pointer
      output += 'M=M+1\n';
    }
  }
  if (args[0] == 'pop') {
    /// NEED TO DO pointer
    if (args[1] == 'pointer') {
      output += 'NOT YET IMPLEMENTED POINTER\n';
    } else {
      output += '@SP\n';
      output += 'M=M-1\n';
      output += `@${args[2]}\n`;
      output += 'D=A\n';
      //R13 is temp var
      output += `@R13\n`;
      output += `M=D\n`;
      output += `${getSegment(args[1])}\n`;
      if (args[1] == 'temp'){
        output += `D=A\n`;
      } else {
        output += `D=M\n`;
      }
      output += `@R13\n`;
      output += 'M=M+D\n';
      output += '@SP\n';
      output += 'A=M\n';
      output += 'D=M\n';
      output += `@R13\n`;
      output += 'A=M\n';
      output += 'M=D\n';
    }
  }
  return output;
}

function writeLogic(currentCmd) {
  return ''
}

function writeArithmetic(currentCmd) {
  let output = '';
  if (currentCmd == 'add') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'MD=D+M\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'sub') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'MD=M-D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'neg') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'M=-M\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'eq') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    // R13, R14 temp vars
    output += '@R13\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@R14\n';
    output += 'M=D\n';
    output += '@R13\n';
    output += 'D=M\n';
    output += '@R14\n';
    output += 'D=M-D\n';

    output += '@IF_EQUALS\n';
    output += 'D; JEQ\n';

    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=0\n';
    output += '@END\n';
    output += '0;JMP\n';

    output += '(IF_EQUALS)\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=-1\n';

    output += '(END)\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'gt') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@R13\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@R14\n';
    output += 'M=D\n';

    output += '@R13\n';
    output += 'D=M\n';
    output += '@R14\n';
    output += 'D=M-D\n';

    output += '@IF_GT\n';
    output += 'D; JGT\n';

    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=0\n';
    output += '@END\n';
    output += '0;JMP\n';

    output += '(IF_GT)\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=-1\n';

    output += '(END)\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'lt') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@R13\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@R14\n';
    output += 'M=D\n';

    output += '@R13\n';
    output += 'D=M\n';
    output += '@R14\n';
    output += 'D=M-D\n';

    output += '@IF_LT\n';
    output += 'D; JLT\n';

    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=0\n';
    output += '@END\n';
    output += '0;JMP\n';

    output += '(IF_LT)\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=-1\n';

    output += '(END)\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'and') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'MD=D&M\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'or') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'MD=D|M\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'not') {
    output += '@SP\n';
    output += 'AM=M-1\n';
    output += 'M=!M\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }


  return output;
}

function getSegment(seg, offset = null) {
  if (seg == 'local') {
    return '@LCL';
  }
  if (seg == 'argument') {
    return '@ARG';
  }
  if (seg == 'this') {
    return '@THIS';
  }
  if (seg == 'that') {
    return '@THAT';
  }
  if (seg == 'static') {
    const varName = `${filename.split('.')[0]}.${offset}`;
    return `@${varName}`;
  }
  if (seg == 'temp') {
    // There might be a problem here
    //console.log('here')
    //console.log(offset)
    //const loc =  5; // Why not 5?
    //return `@${loc}`;
    return '@5'
  }
}



/*
function commandType(line) {
  if (
    line.includes('add') ||
    line.includes('sub') ||
    line.includes('neg') ||
    line.includes('eq') ||
    line.includes('gt') ||
    line.includes('lt') ||
    line.includes('and') ||
    line.includes('or') ||
    line.includes('not')
  ) {
    return 'C_ARITHMETIC';
  }
  if (line.includes('push')) {
    return 'C_PUSH';
  }
  if (line.includes('pop')) {
    return 'C_POP';
  }
  if (line.includes('label')) {
    return 'C_LABEL';
  }
  if (line.includes('goto')) {
    return 'C_GOTO';
  }
  if (line.includes('if')) {
    return 'C_IF';
  }
  if (line.includes('function')) {
    return 'C_FUNCTION';
  }
  if (line.includes('return')) {
    return 'C_RETURN';
  }
  if (line.includes('call')) {
    return 'C_CALL';
  }
}
*/