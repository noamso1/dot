const JSON5 = require('json5')
const fs = require("fs");
const stdinBuffer = fs.readFileSync(0)
const s = stdinBuffer.toString()
const j = JSON5.parse(s)
console.log(JSON.stringify(j, null, 2))
