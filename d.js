let s = process.argv[2];
if ( s ) s = s.replaceAll('\n','')
if ( s ) s = s.replaceAll('\r','')
if ( !s ) {
  console.log( (new Date()).toISOString().substring(0,19).replace('T', ' ') )
} else if ( s.indexOf('-') >= 0 ) {
  if ( s.indexOf('Z') < 0 ) s += 'Z+0'
  console.log( new Date(s).getTime() )
} else {
  if ( s.length == 10 ) s += '000'
  console.log( (new Date(+s)).toISOString().substring(0,19).replace('T', ' ') )
  //let loc = (new Date(+s)).toLocaleString('en-gb')
  //console.log('LOC ' + loc.substring(6,10) + '-' + loc.substring(3,5) + '-' + loc.substring(0,2) + ' ' + loc.substring(12,20) )
}

