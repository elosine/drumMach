SerialPort.listDevices;


(
s.waitForBoot{
~ino = ArduinoSMS("/dev/tty.usbserial-AE015LPT", 9600);
~kbs = {Bus.control(s)}!50;
//~hits = SoundFile.collectIntoBuffers( "/Volumes/MEDIA/JAM4/drumMach-master/drsamps/"  ++ "*");
~hits = SoundFile.collectIntoBuffers(  "/Users/jyang/GitHub/drumMach/drsamps/" ++ "*");
};
)
(
~ino.action = {
	arg msg;
	var msgs, datasplit, data;
	msgs = msg.asString.split($;);
	data = Array.newClear(msgs.size);
	msgs.do{
		arg it, ix;
		datasplit = it.split($:);

		if(datasplit[0] == "dr1", {
			~kbs[0].set( datasplit[1].asInteger );
		});

		if(datasplit[0] == "dr2", {
			~kbs[1].set( datasplit[1].asInteger );
		});

		if(datasplit[0] == "dr3", {
			~kbs[2].set( datasplit[1].asInteger );
		});

		if(datasplit[0] == "dr4", {
			~kbs[3].set( datasplit[1].asInteger );
		});

	};
};

SynthDef(\samp, {
	arg buf, trig = 1;
	var synth;
	synth = PlayBuf.ar( 1, buf, \spd.kr(1.0, 0), trigger:trig );
	Out.ar(0, synth);
}).add;


)

~dr[0].set(\trig, 1);
s.meter
(
~dr = [
	Synth(\samp, [\buf, ~hits[0] ]),
	Synth(\samp, [\buf, ~hits[1] ]),
	Synth(\samp, [\buf, ~hits[2] ]),
	Synth(\samp, [\buf, ~hits[3] ])
];
~dr[0].map(\trig, ~kbs[0]);
~dr[1].map(\trig, ~kbs[1]);
~dr[2].map(\trig, ~kbs[2]);
~dr[3].map(\trig, ~kbs[3]);
)
~kbs[0].get;
