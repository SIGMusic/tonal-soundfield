var osc = require('node-osc');

var oscServer = new osc.Server(6449, 'localhost');

oscServer.on('message', function(msg, rinfo){
	console.log(msg);
});