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

  rl.on('line', (line) => {
    const strippedLine = removeComments(line);
    if (strippedLine) {
      writer.write(generateComment(strippedLine));
      writer.write(parse(strippedLine));
    }
  });

  rl.on('close', () => {
    console.log('Processing done');
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
  const cmdType = commandType(currentCmd);
  if (cmdType === 'C_ARITHMETIC') {
    return writeArithmetic(currentCmd);
  }
  if (cmdType === 'C_PUSH' || cmdType === 'C_POP') {
    return writePushPop(currentCmd);
  }
  return 'ERROR: NEITHER arith nor pushpop \n';
}

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

function writePushPop(currentCmd) {
  let output = '';
  const args = currentCmd.split(' ');

  if (args[0] == 'push') {
    /// NEED TO DO pointer
    if (args[1] == 'pointer') {
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
      output += 'D=M+D\n'; //  M gets RAM[1] + D
      output += '@SP\n'; // Increment stack pointer
      output += 'M=M+1\n';
    }
  }
  if (args[0] == 'pop') {
    /// NEED TO DO pointer
    if (args[1] == 'pointer') {
    } else {
      output += '@SP\n';
      output += 'M=M-1\n';
      output += `@${args[2]}\n`;
      output += 'D=A\n';
      output += `@temp\n`;
      output += `M=D\n`;
      output += `${getSegment(args[1])}\n`;
      output += `D=M\n`;
      output += `@temp\n`;
      output += 'M=M+D\n';
      output += '@SP\n';
      output += 'A=M\n';
      output += 'D=M\n';
      output += `@temp\n`;
      output += 'A=M\n';
      output += 'D=M\n';
    }
  }
  return output;
}

function writeArithmetic(currentCmd) {
  let output = '';
  if (currentCmd == 'add') {
    output += '@SP\n';
    output += 'M=M-1\n';
    output += 'A=M\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'M=M-1\n';
    output += 'A=M\n';
    output += 'D=D+M\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'sub') {
    output += '@SP\n';
    output += 'M=M-1\n';
    output += 'A=M\n';
    output += 'D=M\n';
    output += '@SP\n';
    output += 'M=M-1\n';
    output += 'A=M\n';
    output += 'D=M-D\n';
    output += 'M=D\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'neg') {
    output += '@SP\n';
    output += 'M=M-1\n';
    output += 'A=M\n';
    output += 'M=-M\n';
    output += '@SP\n';
    output += 'M=M+1\n';
    return output;
  }
  if (currentCmd == 'eq') {
    
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
    const loc = offset + 5;
    return `@${loc}`;
  }
}
