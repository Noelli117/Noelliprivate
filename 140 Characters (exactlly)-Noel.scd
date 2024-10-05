{(BPF.ar(Impulse.ar(1.2), LFNoise0.kr(6).range(200, 1000).poll(10), 0.2)*5) + SinOsc.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4,1/4)*1+2,2,-40,40))}.play
