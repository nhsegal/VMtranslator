/*
To do: 
 unit test writeCall - particularly $ret counter
*/

if (process.argv.length < 3) {
  console.log('Usage: node ' + process.argv[1] + ' FILENAME');
  process.exit(1);
}

const fileOrDirName = process.argv[2];
const path = require('path');
const readline = require('readline');
const fs = require('fs');
const statsObj = fs.statSync(fileOrDirName);


const inputFilePath = fileOrDirName;
const outputFilePath = path.join(
  path.dirname(fileOrDirName), `${fileOrDirName.split('.')[0]}.asm`
);

let callerName = '';
let calleeName = '';
let started = false;
let totalFilesToProcess = 1;
let filesProcessed = 0;
let fileName = '';

function processFile(inputFilePath, outputFilePath, append) {
  console.log('processing file')
  fileName = path.basename(inputFilePath, '.vm')
  console.log(fileName)
  const writeOptions = { flags: append ? 'a' : 'w' }; 
  const fileStream = fs.createReadStream(inputFilePath);
  const writer = fs.createWriteStream(outputFilePath, writeOptions);
  const rl = readline.createInterface({
    input: fileStream,
    ctrlDelay: Infinity,
  });

  // {functionName, numberOfCalls}
  const listOfFunctions = []

  rl.on('line', (line) => {
    if (!started) {
      started = true;
      // Bootstrap code
      writer.write('@256\n')
      writer.write('D=A\n')
      writer.write('@SP\n')
      writer.write('M=D\n')
      //writer.write('call Sys.init\n')  
      writer.write(write3WordCmd('call Sys.init 0', listOfFunctions))
    }
    const strippedLine = removeComments(line);
    if (strippedLine) {
      writer.write(generateComment(strippedLine));
      writer.write(parse(strippedLine, listOfFunctions));
    }
  });
  rl.on('close', () => {
    console.log('Processing done');
    filesProcessed++;
    if (filesProcessed === totalFilesToProcess){
      writer.write('(END)\n');
      writer.write('@END\n');
      writer.write('0;JMP\n');
    }
    writer.end();
  });
}



function processDir(inputDirPath, outputFilePath) {
  fs.readdir(inputDirPath, (err, files) => {
    if (err) {
      console.log(err);
      process.exit(-1);
    } else {
      totalFilesToProcess = files.length;
      const append = totalFilesToProcess > 1;
      files.forEach((file) => {
       // console.log(path.extname(file) )
        if (path.extname(file) == '.vm'){
          const fullFilePath = path.join(inputDirPath, file);
          processFile(fullFilePath, outputFilePath, append);
        }
       
      })
    }
  })
}


if (statsObj.isFile()) {
  processFile(inputFilePath, outputFilePath, false); // Not appending for individual file
}

if (statsObj.isDirectory()) {
  processDir(inputFilePath, outputFilePath, true);
}

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

function parse(currentCmd, listOfFunctions) {
  const cmdArgs = currentCmd.split(' ');
  if (cmdArgs.length == 3) {
    return write3WordCmd(currentCmd, listOfFunctions);
  }
  if (cmdArgs.length == 2) {
    return write2WordCmd(currentCmd);
  }
  if (cmdArgs.length == 1) {
    return write1WordCmd(currentCmd);
  }
  return 'ERROR: Command length not recognized.\n';
}

function write3WordCmd(currentCmd, listOfFunctions) {
  const args = currentCmd.split(' ');
  if (args[0] == 'function') {
    return writeFunction(currentCmd);
  }
  if (args[0] == 'call') {
    // if listOfFunctions contains arg[1] increase its counter
    if (listOfFunctions.find(obj => obj.functionName == `${args[1]}`)){
      listOfFunctions.find(obj => obj.functionName == `${args[1]}`).callCount++
    }
    else {
      listOfFunctions.push({functionName: `${args[1]}`, callCount: 0})
    }
    console.log(listOfFunctions.find(obj => obj.functionName == `${args[1]}`).callCount)
    return writeCall(currentCmd, listOfFunctions.find(obj => obj.functionName == `${args[1]}`).callCount);
  }

  if (args[0] == 'push') {
    return writePush(currentCmd);
  }
  if (args[0] == 'pop') {
    return writePop(currentCmd);
  }
  return 'Error: unrecognized 3 word command.';
}

function writeFunction(currentCmd) {
  let output = '';
  const args = currentCmd.split(' ');
  callerName = args[1];
  const nArgs = args[2];
  // function entry label
  output += `(${fileName}.${callerName}$${calleeName})\n`;
  for (let i = 0; i < nArgs; i++) {
    output += writePush('push local 0');
  }
  return output;
}

function writeCall(currentCmd, i) {
  let output = '';
  const args = currentCmd.split(' ');
  // push return address XXX.foo$ret.i
  // where XXX is file name, foo is function name and i is call count 
  calleeName = args[1];
  const retLabel = `${fileName}.${callerName}$ret.${i}`
  output += `@${retLabel}\n`;
  output += 'D=A\n';
  output += `@SP\n`;
  output += 'A=M\n';
  output += 'M=D\n';
  output += '@SP\n'; 
  output += 'M=M+1\n';
 
  output += saveFrame();
  output += repositionArg(currentCmd);
  // LCL = SP
  output += '@SP\n';
  output += 'D=M\n';
  output += '@LCL\n';
  output += 'M=D\n';

  //write2WordCmd(`goto ${callerName}`);
  // goto retAdd
  output += '@R14\n';
  output += 'A=M\n';
  output += '0; JMP\n';
  output += `(${fileName}.${callerName}$ret.${i})\n`
  return output;
}

function saveFrame() {
  let output = '';
  output += saveSeg('@LCL');
  output += saveSeg('@ARG');
  output += saveSeg('@THIS');
  output += saveSeg('@THAT');
  return output;
}

function saveSeg(seg) {
  let output = '';
  output += `${seg}\n`;
  output += 'D=M\n';
  output += '@SP\n';
  output += 'A=M\n';
  output += 'M=D\n';
  output += '@SP\n';
  output += 'M=M+1\n';
  return output;
}

function repositionArg(currentCmd) {
  let output = '';
  const args = currentCmd.split(' ');
  output += '@SP\n';
  output += 'D=M\n';
  output += `@${args[2]}\n`;
  output += 'D=D-A\n';
  output += '@5\n';
  output += 'D=D-A\n';
  output += '@ARG\n';
  output += 'M=D\n';
  return output;
}

function writePush(currentCmd) {
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
  return output;
}

function writePop(currentCmd) {
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
  return output;
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
    output += 'AM=M-1\n';
    output += 'D=M\n';
    output += `@${args[1]}\n`;
    output += 'D; JNE\n';
    return output;
  }
  if (args[0] == 'label') {
    output += `(${args[1]})\n`;
    return output;
  }
  return `ERROR: unknown 2 word command: ${currentCmd}`;
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
  if (currentCmd == 'return') {
    output += writeReturn();
    return output;
  }
  return 'ERROR: Unknown one word command.';
}

function writeReturn() {
  let output = '';
  // frame = LCL
  output += '@LCL\n';
  output += 'D=M\n';
  output += '@R13\n'; //R13 is frame
  output += 'M=D\n';
  // retAddr = *(frame - 5)
  output += '@5\n'; // Exp with adding in nArgs
  output += 'D=D-A\n';
  output += 'A=D\n';
  output += 'D=M\n';
  output += '@R14\n';
  output += 'M=D\n';
  // *ARG = pop()
  output += '@SP\n';
  output += 'M=M-1\n';
  output += 'A=M\n';
  output += 'D=M\n';
  output += '@ARG\n';
  output += 'A=M\n';
  output += 'M=D\n';

  // SP = ARG + 1
  output += '@ARG\n';
  output += 'D=M+1\n';
  output += '@SP\n';
  output += 'M=D\n';
  // THAT = *(frame -1)
  output += '@R13\n';
  output += 'A=M-1\n';
  output += 'D=M\n';
  output += '@THAT\n';
  output += 'M=D\n';
  // THIS = *(frame -2)
  output += '@R13\n';
  output += 'A=M-1\n';
  output += 'A=A-1\n';
  output += 'D=M\n';
  output += '@THIS\n';
  output += 'M=D\n';
  // ARG = *(frame -3)
  output += '@R13\n';
  output += 'A=M-1\n';
  output += 'A=A-1\n';
  output += 'A=A-1\n';
  output += 'D=M\n';
  output += '@ARG\n';
  output += 'M=D\n';
  // LCL = *(frame -4)
  output += '@R13\n';
  output += 'A=M-1\n';
  output += 'A=A-1\n';
  output += 'A=A-1\n';
  output += 'A=A-1\n';
  output += 'D=M\n';
  output += '@LCL\n';
  output += 'M=D\n';
  // goto retAdd
  output += '@R14\n';
  output += 'A=M\n';
  output += '0; JMP\n';
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
    const varName = `${fileName.split('.')[0]}.${offset}`;
    return `@${varName}`;
  }
  if (seg == 'temp') {
    return '@5';
  }
}
