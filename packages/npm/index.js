const path = require('path');

module.exports = {
    // 返回 wit 文件的绝对路径
    witPath: path.join(__dirname, 'wit', 'vtx.wit'),
    // 返回 wit 目录路径
    witDir: path.join(__dirname, 'wit')
};
