var osc = require('node-osc');
var crypto = require('crypto');
var WebSocketServer = require('ws').Server;
var wsport = 7447;
var outport = 6449;
var wss = new WebSocketServer({port: wsport});
var client = new osc.Client('localhost', outport);
var oscServer = new osc.Server(6452, 'localhost');
var notes = [0, 72, 74, 76, 77, 79, 81, 83, 84, 86, 88, 89, 91, 93, 95, 96, 98];

wss.on('connection', function connection(ws){
  ws.on('message', function incoming(message){
    console.log(message);
    message = JSON.parse(message);
    if(message.event == 'comet' && message.melody){
      crypto.randomBytes(18, function(ex, buf){
        var id = buf.toString('hex');
        var timbre = (message.color.r * 0.6 + message.color.g * 0.8 + message.color.b * 0.5) % 1;
        args = [timbre, message.lifespan];
        var melLength = Math.min(8, message.melody.length);
        for(var x = 0; x < melLength; x++){
          args = args.concat(notes[parseInt(message.melody[x])]);
        }
        args = args.concat(message.id);
        console.log(args);
        for(var x = 0; x < 1; x++){
          client.send('/timbre/lifetime/n1/n2/n3/n4/n5/n6/n7/n8/id', args);
        }
      });
    }
  });
  oscServer.on('message', function(msg, rinfo){
    console.log(msg[1]);
    ws.send(String(msg[1]));
  });
});