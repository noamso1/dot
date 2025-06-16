#!/usr/bin/env node
"use strict";
const crypto = require('crypto')
const fs = require('fs')

global.cl = function( a ) {
  if ( typeof a == 'object' ) {
    console.log(JSON.stringify(a, null, 2))
  } else {
    console.log( a )
  }
}

global.ex = function( a ) {
  cl( a )
  process.exit()
}

global.jsonl = function( o ) {
  for ( let a of o ) console.log(JSON.stringify(a) + ',')
}

//-----------------------------------------
global.showDate = function(d) { // show local time string
  if (!d) d = new Date();
  let t, r = '';
  r += d.getFullYear();
  t = (d.getMonth() + 1); if (t.toString().length == 1) { t = '0' + t };
  r += '-' + t;
  t = d.getDate(); if (t.toString().length == 1) { t = '0' + t };
  r += '-' + t;
  t = d.getHours(); if (t.toString().length == 1) { t = '0' + t };
  r += ' ' + t;
  t = d.getMinutes(); if (t.toString().length == 1) { t = '0' + t };
  r += ':' + t;
  t = d.getSeconds(); if (t.toString().length == 1) { t = '0' + t };
  r += ':' + t;
  return r;
}

global.nowString = function() {
  return new Date().toISOString().substring(0, 19).replace('T', ' ')
}

global.dateAddSeconds = function(da, x) {
  let d = new Date(da);
  d = new Date(d.getTime() + x * 1000);
  return showDate(d);
}

global.dateDiff = function(d1, d2) {
  if (!isDate(d1) || !isDate(d2)) return 0;
  let t1 = new Date(d1).getTime();
  let t2 = new Date(d2).getTime();
  return ((t2 - t1) / 1000).toFixed()
}

global.isDate = function(s) {
  if (!isNaN(Date.parse(s))) { return true; } else { return false; }
}

global.isHour = function(s) {
  if (!s || typeof s != 'string' ) return false
  let h = s.substring(0,2)
  let m = s.substring(3,5)
  if ( s.length != 5 || s.substring(2,3) != ':' ) return false
  if ( Number(h) < 0 || Number(h) > 23 ) return false
  if ( Number(m) < 0 || Number(m) > 59 ) return false
  return true
}

global.isNumeric = function(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

//utcToLocal('2024-01-01 12:00', 'ISRAEL')
global.utcToLocal = function(date, timeZone) {
  if (!date) date = new Date()
  let loc = new Date(date).toLocaleString('en-GB', { timeZone: timeZone })
  let r = loc.substring(6,10) + '-' + loc.substring(3,5) + '-' + loc.substring(0,2) + loc.substring(11)
  return r
}

//localToUTC('2024-01-01 14:00+02:00')
global.localToUTC = function(d) {
  let now = new Date(d);
  let utc = new Date(now.getTime() + now.getTimezoneOffset() * 60000);
  utc = utc.toISOString()
  utc = utc.substring(0,10) + ' ' + utc.substring(11,19)
  return utc
}

// showLocalDate( new Date('2023-02-14 14:52'), 'America/New_York' )
global.showLocalDate = function( dateObject, literalTimeZone ) {
  let s = new Intl.DateTimeFormat('en-GB', { dateStyle: 'short', timeStyle: 'medium', timeZone: literalTimeZone }).format( dateObject )
  s = s.substring(6,10) + '-' + s.substring(3,5) + '-' + s.substring(0,2) + ' ' + s.substring(12,20)
  return s
}
// // convert string with literal time zone to actual date:
// const moment = require('moment-timezone');
// const dateString = '2022-03-01T12:00:00.000 America/New_York';
// const date = moment.tz(dateString, 'YYYY-MM-DDTHH:mm:ss.SSS z').toDate();
// console.log(date)

global.lastDay = function( d ) {
  let today = new Date(d);
  let last = new Date(today.getFullYear(), today.getMonth() + 1, 0);
  return last.getDate()
}

global.fetchJson = async function( params ) {
  let q = structuredClone(params); if ( typeof q == 'string' ) q = { url: q }
  // let res = await ( await fetch( 'https://hello.com', { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: '{}' } ) ).json()
  let res = await ( await fetch( q.url, { method: q.method, headers: q.headers, body: q.body } ) ).json()
  return res
}

global.fetchText = async function ( params ) {
  let q = structuredClone(params); if ( typeof q == 'string' ) q = { url: q }
  let res = await ( await fetch( q.url, { method: q.method, headers: q.headers, body: q.body } ) ).text()
  return res
}

global.randomString = function(length, chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890') {
  let pass = ''
  for (let x = 0; x < length; x++) {
    let i = Math.floor(Math.random() * chars.length)
    pass += chars[i]
  }
  return pass
}

//---------------------------------------CRYPTO
////supported hashes
//console.log(crypto.getHashes());
//console.log(crypto.getCiphers());

////create hash
//let hash = crypto.createHash('sha512').update('your message').digest('hex')
//console.log(hash);

global.enc = function(thetext, thepass) {
  let text = thetext
  let addition = crypto.randomBytes(Math.random() * 10 + 5).toString('base64')
  text += '.' + addition
  let pass = crypto.createHash('sha256').update(thepass).digest('buffer')
  let iv = crypto.randomBytes(16)
  let cipher = crypto.createCipheriv('aes-256-cbc', pass , iv);
  let encrypted = cipher.update(text, 'utf-8', 'base64');
  encrypted += cipher.final('base64');
  return encrypted + '.' + iv.toString('base64')
}

global.dec = function(thetext, thepass) {
  let text = thetext
  let pass = crypto.createHash('sha256').update(thepass).digest('buffer')
  try {
    let ivb = text.substring(text.lastIndexOf('.') + 1, text.length)
    let iv = Buffer.from(ivb, 'base64');
    text = text.substring(0, text.lastIndexOf('.'))
    let decipher = crypto.createDecipheriv('aes-256-cbc', pass, iv);
    let decrypted = decipher.update(text, 'base64', 'utf-8');
    decrypted += decipher.final('utf-8');
    decrypted = decrypted.substring(0, decrypted.lastIndexOf('.')) //remove addition
    return decrypted;
  } catch {
    return ''
  }
}

global.isEmail = function(e) {
  let r = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return r.test(String(e).toLowerCase());
}

global.getFromTo = function(a, start, f, t) {
  let x1 = a.indexOf(f, start); if (x1 == -1) return ''; x1 += f.length;
  let x2 = a.indexOf(t, x1); if (x2 == -1) return ''
  return a.substring(x1, x2);
}

global.replaceFromTo = function(a, start, f, t, rep, delf, delt) {
  let x0, x1, x2, x1a, x2a;
  x1 = a.indexOf(f, start); if (x1 == -1) return a;
  x1 += f.length;
  x2 = a.indexOf(t, x1); if (x2 == -1) return a;
  if (delf) x1 -= f.length
  if (delt) x2 += t.length
  return a.substring(0, x1) + rep + a.substring(x2, a.length);
}

global.sortBy = function( arr, key, desc ) {
  if ( desc ) {
    arr.sort( ( a, b ) => ( a[key] < b[key] || !a[key] ) ? 1 : -1) // undefined at the bottom
  } else {
    arr.sort( ( a, b ) => ( a[key] > b[key] || !b[key] ) ? 1 : -1) // undefined on top
  }
}

global.clone = function(obj) {
  return structuredClone(obj)
}

global.strFilter = function(string, okChars) {
  let r = '', s = string + ''
  for(let i = 0; i < s.length; i++) {
    if(okChars.indexOf(s[i]) >= 0) r += s[i]
  }
  return r
}

global.uniqueArray = function(array, includeUndefined) {
  if (! Array.isArray(array)) return []
  return array.filter((v, i, a) => a.indexOf(v) === i && ( v || includeUndefined ) )
}

global.uniqueArrayKey = function( aa, k, allowNull ) { // return new array of objects with unique key value
  let r = []
  for ( let i = 0; i < aa.length; i++ ) {
    let a = aa[i]
    if ( !allowNull && [ undefined, null ].includes(a[k]) ) continue
    let j = aa.findIndex( e => e[k] == a[k] )
    if ( i == j ) r.push(a)
  }
  return r
}

// -------------------hash
let hashSaltAdd = 'vjdDFG#^$421'
let hashPepperChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'

global.createHash = function(string, pepper) {
  if (!pepper) pepper = randomString(2, hashPepperChars)
  let t = string + hashSaltAdd + pepper
  return crypto.createHash('sha512').update(t).digest('hex')
}

global.validateHash = function(p, h) {
  for(let c of hashPepperChars) {
    for(let d of hashPepperChars) {
      if(createHash(p, c + d) == h) return true
    }
  }
  return false
}

global.passStrength = function(pass) {
  let pp = (pass + '').split('') , r = ''
  let lower = 'abcdefghijklmnopqrstuvwxyz'
  let upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  if ( pp.length < 8 ) r+= 'password must be at least 8 chars long. '
  if ( !pp.some( e => lower.includes(e) ) ) r+= 'password must include lower case letters. '
  if ( !pp.some( e => upper.includes(e) ) ) r+= 'password must include upper case letters. '
  if ( !pp.some( e => !(lower + upper).includes(e) ) ) r+= 'password must include numeric of symbol characters. '
  return r
}

global.addLog = function( f, s, createDir ) {
  if ( createDir ) {
    let p = ''
    const pp = f.split('/')
    for (let i = 0; i < pp.length - 1; i++) {
      p += pp[i] + '/'
      if ( !fs.existsSync(p) ) { fs.mkdirSync(p) }
    }
  }
  fs.appendFileSync(f, s + '\n', 'utf8')
}

global.addLog2 = function(f, s) {
  fs.appendFile( f, s, { encoding: 'utf8' }, function(e){} )
}

global.num = function(s) {
  if (isNumeric(s)) return Number(s)
  return 0
}

global.str = function( a ) {
  if ( a == undefined || a == null || typeof a == 'array' || typeof a == 'object' ) return ''
  return a + ''
}

//Response=000&tranmode=AK&notify_url_address=http%3A%2F%2Flocalhost%3A3333%2Ftz.html
global.url2json = function(s) {
  return Object.fromEntries(new URLSearchParams(s))
}

//delKeys(object, 'key1,key2')
global.delKeys = function(obj, keys) {
  let kk = keys.split(',')
  for ( let k of kk ) delete obj[k]
}

// load the arguments: node main.js db=kiki port=9999 ----> args = {"db": "kiki", "port": "9999"}
global.getArgs = function() {
  let args = {};
  for (let i = 2; i < 999; i++) {
    let a = process.argv[i]
    if ( !a ) break
    if ( a.indexOf('=') >= 0 ) {
      let k = a.substring(0, a.indexOf('='))
      let v = a.substring(a.indexOf('=') + 1, a.length)
      args[k] = v
    } else {
      args[a] = true
    }
  }
  return args
}

global.sortObjectKeys = function(obj) {
  const sorted = Object.keys(obj)
    .sort()
    .reduce((acc, key) => {
      if (typeof obj[key] === "object") {
        // recurse nested properties that are also objects
        if (obj[key] == null) {
          acc[key] = null
        } else if (Array.isArray(obj[key])) {
          acc[key] = obj[key].map((item) => {
            if (typeof item === "object") {
              return sortObjectKeys(item)
            } else {
              return item
            }
          })
        } else {
          acc[key] = sortObjectKeys(obj[key])
        }
      } else {
        acc[key] = obj[key]
      }
      return acc
    }, {})
  return sorted
}

global.isSame = function( a, b ) {
  let a_snap = JSON.stringify(sortObjectKeys(a))
  let b_snap = JSON.stringify(sortObjectKeys(b))
  if ( a_snap == b_snap ) return true
}

global.sleep = async function( ms ) {
  await new Promise((resolve) => setTimeout(resolve, ms))
}

global.rand = function(min, max) { // min and max included
  return Math.floor(Math.random() * (max - min + 1) + min)
}

global.hasMatch = function( aa, bb ) {
  if ( !Array.isArray(aa) || !Array.isArray(bb) ) return false
  for ( let a of aa ) if ( bb.includes(a) ) return true
  return false
}

global.bothMatch = function( aa, bb ) {
  const cc = []
  if ( !Array.isArray(aa) || !Array.isArray(bb) ) return cc
  for ( let a of aa ) if ( bb.includes(a) ) cc.push(a)
  return cc
}

global.isArrayFull = function(a) {
  if ( Array.isArray(a) && a.length > 0 ) return true
}

// let a
// while (true) {
//   a = func.firstLine('1.txt', f, a?.pos)
//   console.log(a.line.length, a.pos, a.eof)
//   if ( a.eof ) break
// }
global.firstLine = function( f, pos ) {
  if ( !fs.existsSync( f ) ) return ''
  if ( !pos ) pos = 0
  const size = fs.statSync(f).size
  const chunkSize = 4096
  const fd = fs.openSync(f, 'r')
  let line = '', eof
  while ( pos < size ) {
    let buf = Buffer.alloc(chunkSize)
    fs.readSync(fd, buf, 0, chunkSize, pos)
    let x = buf.indexOf(10)
    if ( x > -1 ) buf = buf.slice( 0, x )
    line += buf.toString('utf8')
    if ( x > -1 ) { pos += x; break }
    pos += buf.length
    if ( buf.length < chunkSize) break
  }
  if ( pos >= size ) eof = true
  fs.closeSync(fd)
  return { line, pos: pos + 1, eof}
}

// let a
// while (true) {
//   a = func.lastLine('1.txt', a?.pos)
//   console.log(a.line.length, a.pos )
//   if ( a.pos == 0 ) break
// }
global.lastLine = function( f, pos ) {
  if ( !fs.existsSync( f ) ) return { line: '', pos: 0 }
  const size = fs.statSync(f).size
  if ( pos == undefined ) pos = size
  if ( pos <= 0 ) return { line: '', pos: 0 }
  const chunkSize = 4096
  const fd = fs.openSync(f, 'r')
  let line = ''
  while ( pos <= size ) {
    let start = pos - chunkSize, ch = chunkSize
    if ( start < 0 ) { start = 0; ch = pos }
    if ( (start + ch) > size ) ch = size - start
    let buf = Buffer.alloc(ch)
    fs.readSync(fd, buf, 0, ch, start)
    let x = buf.lastIndexOf(10)
    if ( x > -1 ) buf = buf.slice( x + 1 )
    //console.log( { size, pos, start, ch, buf } )
    line = buf.toString('utf8') + line
    if ( x > -1 ) { pos = pos - ch + x; break }
    pos -= buf.length
    if ( pos <= 0 ) break
  }
  fs.closeSync(fd)
  return { line, pos: pos }
}

// // example of promise all tasks with chunks
// let tasks = [], aa = [ 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22 ]
// for ( let a of aa ) {
//   let u = 'http://localhost:8888/?s=' + a
//   tasks.push({ type: 'test', u, promise: fetchText(u) })
// }
// for ( let i = 0; i < tasks.length; i += 20 ) {
//   let results = await Promise.all(tasks.slice( i, i + 20 ).map((e) => e.promise))
//   for (let j = 0; j < results.length; j++) { tasks[i + j].result = results[j] }
// }
