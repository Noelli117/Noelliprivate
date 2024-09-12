#include "RtMidi.h"
#include <vector>
#include <thread>
#include <chrono>

int main() {
    RtMidiOut midiout;

    // Check available ports.
    unsigned int nPorts = midiout.getPortCount();
    if (nPorts == 0) {
        std::cout << "No ports available!\n";
        return 0;
    }

    // Open first available port.
    midiout.openPort(0);

    // Define a MIDI sequence.
    std::vector<std::vector<unsigned char>> sequence = {
        {0x90, 60, 127},  // Note on: 60 = C4, 127 = max velocity
        {0x80, 60, 0}    // Note off: 60 = C4
    };

    // Play the sequence.
    for (auto& message : sequence) {
        midiout.sendMessage(&message);
        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    return 0;
}