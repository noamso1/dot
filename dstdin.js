const fs = require("fs");
const buf = fs.readFileSync(0)
let s = buf.toString()
s = s.replaceAll('\n','')
s = s.replaceAll('\r','')
if ( !s ) {
  console.log( (new Date()).toISOString().substring(0,19).replace('T', ' ') )
} else if ( s.indexOf('-') >= 0 ) {
  if ( s.indexOf('Z') < 0 ) s += 'Z+0'
  console.log( new Date(s).getTime() )
} else {
  if ( s.length == 10 ) s += '000'
  console.log( (new Date(+s)).toISOString().substring(0,19).replace('T', ' ') )
}

