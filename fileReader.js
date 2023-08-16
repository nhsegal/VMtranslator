const fileOrDirName = process.argv[2];
const path = require('path');
const readline = require('readline');
const fs = require('fs');
const statsObj = fs.statSync(fileOrDirName);

function processFile(inputFilePath, outputFilePath) {
  const fileStream = fs.createReadStream(inputFilePath);
  const writer = fs.createWriteStream(outputFilePath, { flags: 'w' });
  const rl = readline.createInterface({
    input: fileStream,
    ctrlDelay: Infinity,
  });

  rl.on('line', (line) => {
    writer.write(line + '\n'); // Add newline character
  });

  rl.on('close', () => {
    console.log('Processing done');
    writer.end();
  });
}

const inputFilePath = fileOrDirName;
const outputFilePath = path.join(
  path.dirname(fileOrDirName), 'source.asm'
);

function processDir(inputDirPath, outputFilePath) {
  fs.readdir(inputDirPath, (err, files) => {
    if (err) {
      console.log(err);
      process.exit(-1);
    } else {
      files.forEach((file) => {
        const fullFilePath = path.join(inputDirPath, file);
        processFile(fullFilePath, outputFilePath);
      });
    }
  });
}

if (statsObj.isFile()) {
  processFile(inputFilePath, outputFilePath);
}

if (statsObj.isDirectory()) {
  processDir(inputFilePath, outputFilePath);
}
