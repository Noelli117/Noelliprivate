(
SynthDef(\kick, {
	var snd;
	snd = SinOsc.ar(50 * (1 + (9 * Env.perc(0.001, 0.05).ar) + (2 * Env.perc(0.001, 0.3).ar)));
	snd = snd + (SinOsc.ar(200 * (1 + (3 * Env.perc(0.001, 0.05).ar))) * Env.perc(0.001, 0.05).ar);
	snd = snd + (Hasher.ar(Sweep.ar) * Env.perc(0.001, 0.01).ar);
	snd = snd.tanh;
	snd = snd * Env.perc(0.001, 1.0).ar(Done.freeSelf);
	snd = snd ! 2;
	snd = snd * \amp.kr(0.1);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\snare, {
	var snd, freq;
	freq = 210 * (1 + (Env.perc(0.001, 0.03).ar * 2));
	snd = SinOsc.ar(freq + (200 * SinOsc.ar(freq * 1.6))) * Env.perc(0.001, 0.2).ar;
	snd = snd + (BPF.ar(Hasher.ar(Sweep.ar), 3130, 0.3) * Env.perc(0.1, 0.3).ar);
	snd = snd.tanh;
	snd = snd * Env.perc(0.001, 0.3).ar(Done.freeSelf);
	snd = snd ! 2;
	snd = snd * \amp.kr(0.1);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\clap, {
	var snd, freq;
	snd = BPF.ar(Hasher.ar(Sweep.ar), [1520, 1200, 1720] * 0.9, 0.1) * 20.dbamp;
	snd = snd * Env.perc(0.001, 0.3).delay([0, 0.01, 0.02]).ar;
	snd = Splay.ar(snd, 0.2);
	snd = snd * Env.perc(0, \decay.kr(0.5)).ar(Done.freeSelf);
	snd = snd * \amp.kr(0.1);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\glitch, {
	var snd, freq, n, dry;
	n = (1..16);
	snd = (SinOsc.ar(LFNoise2.kr(3).linexp(-1, 1, 100, 12000) * n * (1 + (n * TRand.ar(-1, 1, Dust.ar(18)) * 1))) / n).sum;
	snd = snd * Env.linen(0.002, 0.06, 0.001).ar;
	dry = snd;
	snd = snd + LocalIn.ar(1);
	snd = HPF.ar(snd, 300);
	snd = PitchShift.ar(snd, 0.5, 4);
	snd = LPF.ar(snd, 3000);
	LocalOut.ar(snd);
	snd = snd + dry;
	snd = snd * Env.linen(0.001, \dur.kr(1), 0.001).ar(Done.freeSelf);
	snd = Pan2.ar(snd, LFNoise2.kr(0.6));
	snd = snd * \amp.kr(0.07);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\bass, {
	var snd;
	snd = Saw.ar(\freq.kr(110) * (2 ** TIRand.ar(-1, 1, Dust.ar(1))));
	// https://nathan.ho.name/posts/moisture-bass/
	snd = BHiShelf.ar(snd, 2000, 1.0, 10.0);
	snd = BPF.ar(snd, (0..31).linexp(0, 31, 100, 8000), 0.05).sum;
	snd = (snd * 3).tanh;
	snd = MoogFF.ar(snd, LFNoise2.kr(3).linexp(-1, 1, 100, 6000), 0);
	snd = snd ! 2;
	snd = snd * Env.asr(0.01, 1, 0.01).ar(Done.freeSelf, \gate.kr(1));
	snd = snd * \amp.kr(0.1);
	Out.ar(\out.kr(0), snd);
}).add;

SynthDef(\fx, {
	var snd;
	snd = In.ar(\out.kr(0), 2);
	snd = PitchShift.ar(snd, 0.15, TExpRand.ar(0.5, 2, Dust.ar(3))) * 10.dbamp;
	snd = SelectX.ar(ToggleFF.ar(Dust.ar(8)).lag(0.03), [snd, DelayC.ar(snd, 0.2, LFNoise2.kr(3). range(0, 0.2))]);
	snd = snd * \amp.kr(1);
	Out.ar(\out.kr(0), snd);
}).add;

)

Synth(\kick);
Synth(\snare);
Synth(\clap);
Synth(\glitch);
Synth(\bass);

(
var s;
s = Server.default;

Synth.tail(s, \fx);

Routine {
	loop {
		s.makeBundle(s.latency, {
			Synth([\kick, \snare, \clap, \glitch, \bass].choose, [pan: rrand(-0.2, 0.2)]);
		});
		if (0.1.coin, { rrand(0.5, 3.0) }, {rrand(0.04, 0.3) }).wait;
	};
}.play;
)
