var osc = require('node-osc');
var crypto = require('crypto');
var exec = require('child_process').exec;
var WebSocketServer = require('ws').Server;
var wsport = 7447;
var outport = 6450;
var wss = new WebSocketServer({port: wsport});
var client = new osc.Client('localhost', outport);
var notes = [0, 72, 74, 76, 77, 79, 81, 83, 84, 86, 88, 89, 91, 93, 95, 96, 98];

wss.on('connection', function connection(ws){
  ws.on('message', function incoming(message){
    console.log(message);
    message = JSON.parse(message);
    if(message.event == 'comet' && message.melody){
      crypto.randomBytes(18, function(ex, buf){
        var id = buf.toString('hex');
        var timbre = (message.color.r + message.color.g + message.color.b) % 1;
        var arg = 'chuck + callmelody.ck:' + String(timbre) + ':' + String(message.lifespan);
        var melLength = Math.min(8, message.melody.length);
        for(var x = 0; x < melLength; x++){
          arg += ':' + message.melody[x];
        }
		for( ; x < 8; x++){
			arg += ':0'
		}
        exec(arg, function(err){
			console.log('process created');
		});
      });
    }
  });
});