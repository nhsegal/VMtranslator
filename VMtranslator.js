if (process.argv.length < 3) {
  console.log('Usage: node ' + process.argv[1] + ' FILENAME');
  process.exit(1);
}

const filename = process.argv[2];
const path = require('path');
const readline = require('readline');
const fs = require('fs');
//const stackStart = 256;
//const localBase = 1015;
//let stackPointer = stackStart;

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
      writer.write(generateComment(strippedLine))
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
    return null
  }
  return line
}

function parse(line){
  const cmds = line.split(' ')
  if (cmds[0] == 'push') {
    return handlePush(line)
  }
  else if (cmds[0] == 'pop') {
    return ''//handlePop(line)
  }
  else if (cmds[0] == 'add') {
    return ''//handleAdd()
  }
  else if (cmds[0] == 'sub') {
    return''// handleSub()
  }
}

function handlePush(line) {
  let output = ''
  const args = line.split(' ');
  if (args[1] == 'constant') {  
    output = `@${args[2]}\n`  // @offset
    output += 'D=A\n'         // D gets offset
    output += '@SP\n'         // RAM[0]
    output += 'A=M\n'         // Go to where SP points
    output += 'M=D\n'         // RAM[SP] = D
    output += '@SP\n'         // Increment pointer
    output += 'M=M+1\n'
  }


  return output
}

function handlePop(line) {
  let output = ''
  const args = line.split(' ');
  const offset = args[3]
  if (args[1] == 'local') {
    // RAM[ RAM[1]+offset ] =  RAM[RAM[0]-1] 
    // RAM[0] = RAM[0]-1  Decrement the stack pointer   
    
    output = `@SP\n` // 
    // Check next line 
    output += `D=M-1\n` // D gets RAM[RAM[0]-1]
    output += `@temp\n` // store result in temp var
    output += `M=D\n` 

    output += `@${offset}\n`  // A get the offset
    output += `D=A\n`   // 
    output += `@LCL\n`  // Get local base address, stored in RAM[1]
    output += 'A=M\n'  // 





    output += `A=D+A\n`   // Prepare to write to RAM[base+offset]
    output += 'M=D\n'

    output += '@SP\n'
    output += 'M=M-11\n'
  }



}
function generateComment(line){
  return `// ${line} \n`
}