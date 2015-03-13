int notes[8];
<<<"process made">>>;
melody melody;
Math.random2(270, 500) => float melTime;
Std.atof(me.arg(0)) => float timbre;
Std.atoi(me.arg(1)) * (1000 / melTime) $ int => int lifetime;
for(0 => int x; x < notes.cap(); x++){
	Std.atoi(me.arg(2 + x)) => notes[x];
}
melody.play(notes, timbre, melTime::ms, lifetime);