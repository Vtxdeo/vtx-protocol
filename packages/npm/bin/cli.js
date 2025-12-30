#!/usr/bin/env node

const { Command } = require('commander');
const { resolve } = require('path');
const { spawn } = require('child_process');
const { witPath } = require('../index.js');

const program = new Command();

program
    .name('vtx-protocol')
    .description('VTX Protocol SDK & Build Tool')
    .version(require('../package.json').version);

program
    .command('build')
    .description('Compile a JavaScript source file into a VTX-compatible Wasm component')
    .argument('<source>', 'The JavaScript source file (e.g., app.js)')
    .option('-o, --out <path>', 'Output Wasm file path', 'plugin.wasm')
    .action(async (source, options) => {
        console.log(`🔨 Building VTX Plugin...`);
        console.log(`   Source: ${source}`);
        console.log(`   Protocol: ${witPath}`);

        const args = [
            'componentize',
            source,
            '--wit', witPath,
            '--world', 'plugin',
            '--out', options.out
        ];

        const jcoPath = resolve(__dirname, '../node_modules/.bin/jco');

        const child = spawn(jcoPath, args, { stdio: 'inherit' });

        child.on('close', (code) => {
            if (code === 0) {
                console.log(`✅ Build successful: ${options.out}`);
            } else {
                console.error(`❌ Build failed with exit code ${code}`);
                process.exit(code);
            }
        });
    });

program.parse();