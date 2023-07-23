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
    output = `@${args[2]}\n`
    output += 'D=A\n'
    output += '@SP\n'
    output += 'A=M\n'
    output += 'M=D\n'
    output += '@SP\n'
    output += 'M=M+1\n'
  }


  return output
}

function handlePop(line) {
  let output = ''
  const args = line.split(' ');
  if (args[1] == 'local') {
    output = `@${args[2]}\n`
    output += 'D=A\n'
    output += '@SP\n'
    output += 'A=M\n'
    output += 'M=D\n'
    output += '@SP\n'
    output += 'M=M+1\n'
  }



}
function generateComment(line){
  return `// ${line} \n`
}