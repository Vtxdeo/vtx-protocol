const fs = require('fs');
const assert = require('assert');
const { witPath, witDir } = require('./index');

function runIntegrityCheck() {
    console.log(`[INFO] Starting integrity check for path: ${witPath}`);

    try {
        fs.accessSync(witPath, fs.constants.R_OK);
    } catch (err) {
        console.error(`[FATAL] WIT file is not accessible at: ${witPath}`);
        console.error(`[FATAL] System Error: ${err.message}`);
        process.exit(1);
    }
    const content = fs.readFileSync(witPath, 'utf-8');

    try {
        assert.ok(
            content.includes('package vtx:api'),
            'WIT file content does not contain valid package signature'
        );
        console.log('[INFO] Content signature verified.');
    } catch (err) {
        console.error(`[FATAL] Content verification failed: ${err.message}`);
        process.exit(1);
    }

    console.log('[INFO] Integrity check passed.');
}

runIntegrityCheck();