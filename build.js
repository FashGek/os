var fs = require('fs');
var path = require('path');
var assert = require('assert');

var boot = fs.readFileSync(path.join(__dirname, 'output/boot.bin'));

assert.equal(boot.length, 512);

var buf = new Buffer(1474560 - 512);
buf.fill(0);

var img = path.join(__dirname, 'output/nakupenda.img');
fs.writeFileSync(img, Buffer.concat([boot, buf]));

console.log('Output at: ' + path.relative(__dirname, img));
