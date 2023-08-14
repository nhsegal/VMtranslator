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
    if (start) {
      start = false;
      // Initialization - Comment out
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
    writer.write('(END)\n');
    writer.write('@END\n');
    writer.write('0;JMP\n');
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
  let trimmed = line.split('//')[0].trim();
  if (trimmed == '') {
    return null;
  }
  return trimmed;
}

function generateComment(line) {
  return `// ${line} \n`;
}

function parse(currentCmd) {
  const cmdArgs = currentCmd.split(' ');
  if (cmdArgs.length == 3) {
   return write3WordCmd(currentCmd);
  }
  if (cmdArgs.length == 2) {
    return write2WordCmd(currentCmd);
  }
  if (cmdArgs.length == 1) {
    return write1WordCmd(currentCmd);
  }
  return 'ERROR: Command length not recognized.\n';
}

function write3WordCmd(currentCmd) {
  const args = currentCmd.split(' ');
  if (args[0] == 'function') {
    return writeFunction(currentCmd);
  }
  if (args[0] == 'call') {
    return writeCall(currentCmd)
  }

  if (args[0] == 'push') {
    return writePush(currentCmd)   
  }
  if (args[0] == 'pop') {
    return writePop(currentCmd)
  }
  return 'Error: unrecognized 3 word command.';
}

function writeFunction(currentCmd){
  let output = '';
  const args = currentCmd.split(' ');
  return output
}

function writeCall(currentCmd){
  let output = '';
  const args = currentCmd.split(' ');
      // save caller's frame
    //???? push return address
    output += '@SP\n';
    output += 'A=M\n';
    output += `(${args[1].label})\n`;
    // save LCL
    output += '@LCL\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    // save ARG
    output += '@ARG\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    // saved THIS
    output += '@THIS\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    // saved THAT
    output += '@THAT\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    //  reposition arg
    output += '@SP\n';
    output += 'D=M\n';
    output += `@${args[2]}\n`;
    output += 'D=D-A\n';
    output += 'D=D-5\n';
    output += '@ARG\n';
    output += 'M=D\n';
    // LCL = SP
    output += '@SP\n';
    output += 'D=M\n';
    output += '@LCL\n';
    output += 'M=D\n';
    // goto foo
    output += `@${args[1]}\n`;
    output += '0;JMP\n';

    output += `(${returnAddress})`;

    //*output += `(${args[1]}$ret.${})\n`;

    return output;
 
}

function writePush(currentCmd){
  let output = '';
  const args = currentCmd.split(' ');
  if (args[1] == 'pointer') {
    if (args[2] == 0) {
      output += '@THIS\n';
    }
    if (args[2] == 1) {
      output += '@THAT\n';
    }
    output += 'D=M\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n'; // Increment stack pointer
    output += 'M=M+1\n';
  } else if (args[1] == 'constant') {
    output += `@${args[2]}\n`;
    output += 'D=A\n';
    output += `@SP\n`;
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n'; // Increment stack pointer
    output += 'M=M+1\n';
  } else {
    output += `@${args[2]}\n`; // @offset
    output += 'D=A\n'; // D gets offset
    output += `${getSegment(args[1], args[2])}\n`; // A gets 1, M gets RAM[1]
    if (args[1] == 'temp') {
      output += `A=D+A\n`;
    } else {
      output += `A=D+M\n`;
    }
    output += 'D=M\n';
    output += '@SP\n';
    output += 'A=M\n';
    output += 'M=D\n';
    output += '@SP\n'; // Increment stack pointer
    output += 'M=M+1\n';
  }
  return output
}

function writePop(currentCmd){
  let output = '';
  const args = currentCmd.split(' ');
  if (args[1] == 'pointer') {
    output += '@SP\n';
    output += 'M=M-1\n';
    output += 'A=M\n';
    output += 'D=M\n';

    if (args[2] == 0) {
      output += '@THIS\n';
    }
    if (args[2] == 1) {
      output += '@THAT\n';
    }

    output += `M=D\n`;
  } else {
    output += '@SP\n';
    output += 'M=M-1\n';
    output += `@${args[2]}\n`;
    output += 'D=A\n';
    //R13 is temp var
    output += `@R13\n`;
    output += `M=D\n`;
    output += `${getSegment(args[1])}\n`;
    if (args[1] == 'temp') {
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
  return output
}






function write2WordCmd(currentCmd) {
  let output = '';
  const args = currentCmd.split(' ');
  if (args[0] == 'goto') {
    output += `@${args[1]}\n`;
    output += '0; JMP\n';
    return output;
  }
  if (args[0] == 'if-goto') {
    output += `@SP\n`;
    output += 'A=M-1\n';
    output += 'D=M\n';
    output += 'D; JNE\n';
    output += `@SP\n`;
    output += 'M=M-1\n';
    return output;
  }
  if (args[0] == 'label') {
    output += `(${args[1]})\n`;
    return output;
  }

  return 'ERROR: unknown command\n';
}

function write1WordCmd(currentCmd) {
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
    return '@5';
  }
}
