### Supercollider:
'
{(BPF.ar(Impulse.ar(1.2), LFNoise0.kr(6).range(200, 1000).poll(10), 0.3)*5) + SinOsc.ar(LFSaw.kr(LFPulse.kr(1/4,1/4,1/4,1/4)*9+2,2,-40,40))}.play
'

### Journal:
First I made a "beap" synth which is just a band pass filter on a noise oscillator."BPF" creates a Band Pass Filter (BPF) applied to an Impulse generator.And the filter's center frequency is modulated by a low frequency noise generator (LFNoise0) running at 6 Hz, ranging from 200 to 1000 Hz. I was not sure about what exactlly ".poll" so I searched online :The .poll(10) prints the current value of the LFNoise0 every 10 seconds. Then the filter's bandwidth is set to 0.3;the output is amplified by 5. 

In addition, I used a Sin oscillator to make a kick:the frequency of the sinosc is modulated by a complex control rate signal for whcih create a tone that rapidly changes in pitch following a complex pattern.:An LFPulse (low frequency pulse wave) at 1/4 Hz with specific duty cycle parameters(I actually copied this trick from the templete link provided in the repo),the parameters are: frequency, initial phase offset, duty cycle, and output range multiplier;This modulates an LFSaw (low frequency saw wave) running between -40 and 40 Hz and 2 is the phase.

# By the way my codes is exactlly 140 characters long without spaces. Hope I can get an 100. Thank you Rachel:)


