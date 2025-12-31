// alias jwte='node ~/dot/jwt.js e'
// alias jwtd='node ~/dot/jwt.js d'
// jwte '{"head":123}' '{"payload":1}' '111'
// jwtd eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImhlYWQiOjEyM30.eyJwYXlsb2FkIjoxLCJpYXQiOjE3NjcxODY0NTZ9.r_ZYwhqfjqLgz0AKmMzQuxA0OStHO_arN-46P1xAZwQ 111

const jwt = require('jsonwebtoken');

const [,, command, ...args] = process.argv;

function encode(headerStr, payloadStr, secret) {
  try {
    const header = JSON.parse(headerStr);
    const payload = JSON.parse(payloadStr);
    // Algorithm is set in the header object for the sign function
    const token = jwt.sign(payload, secret, {
      header: header,
      algorithm: header.alg || 'HS256'
    });
    console.log(token);
  } catch (e) {
    console.error("Encoding Error:", e.message);
  }
}

function decode(token, secret = null) {
  const decoded = jwt.decode(token, { complete: true });

  if (!decoded) {
    console.error("Invalid JWT format.");
    return;
  }
  //console.log(JSON.stringify(decoded.header, null, 2));
  console.log(JSON.stringify(decoded.payload, null, 2));

  if (secret) {
    try {
      jwt.verify(token, secret);
      console.log("✅ Signature Verified");
    } catch (e) {
      console.log("❌ Signature Verification Failed:", e.message);
    }
  } else {
    console.log("⚠️  No secret provided: Signature not checked.");
  }
}

if (command === 'e') {
  if ( !args[2] ) { console.log( 'jwte headString payloadString secret' ); process.exit() }
  encode(args[0], args[1], args[2]);
} else if (command === 'd') {
  if ( !args[0] ) { console.log( 'jwtd jwtString secret' ); process.exit() }
  decode(args[0], args[1]);
}

