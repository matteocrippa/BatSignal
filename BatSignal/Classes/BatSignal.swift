//
//  BatSignal.swift
//  Pods
//
//  Created by Matteo Crippa on 04/06/2016.
//
//

import AudioKit
import Chronos
import Foundation

struct BatSignalSampler {
    var base = 19000
    var sampleRate = 44100
    var windowSize = 1024
    var transmitLength = 200
    var step: Int {
        return Int(sampleRate / windowSize)
    }
    var baseBin: Int {
        return Int(base / step)
    }
}

private var batSampler = BatSignalSampler()

public class BatSignal {

    let batTranslator = BatSignalTranslator()
    let batSender = BatSignalSender()
    let batReceiver = BatSignalReceiver()

    public init() {}

    public func send(string: String) {

        AudioKit.stop()

        for c in string.utf8 {
            let freq = batTranslator.generateFrequency(forChar: c)
            batSender.tone()
            batSender.tone(freq)
        }
    }

    public func listen(completion: (String?) -> Void ) {

        AudioKit.stop()

        batReceiver.start() {
            msg in
            print(msg)
            completion(msg)
        }
    }

}

class BatSignalSender {

    let oscillator = AKOscillator()

    public func tone(freq: Double = Double(batSampler.base), forLength: Int = batSampler.transmitLength) {

        AudioKit.output = oscillator
        AudioKit.start()

        oscillator.frequency = freq
        oscillator.amplitude = 1

        oscillator.start()
        print("playing \(freq)")

        let future = NSDate(timeIntervalSinceNow: batSampler.transmitLength / 1000)
        NSThread.sleepUntilDate(future)

        AudioKit.stop()

    }
}

protocol BatSignalReceived {
    func didReceive()
}

class BatSignalReceiver {

    private let bat = BatSignalSampler()
    private let microphone = AKMicrophone()

    private var timer = NSTimer()
    private var tracker: AKFrequencyTracker?


    public init() {
        timer = NSTimer.scheduledTimerWithTimeInterval(batSampler.transmitLength / 1000, target: self, selector: #selector(measureFrequency), userInfo: nil, repeats: true)
    }

    public func start(completion: (String?) -> Void) {

        AudioKit.stop()

        tracker = AKFrequencyTracker(microphone, minimumFrequency: 19000, maximumFrequency: 26000)

        AudioKit.output = tracker!
        AudioKit.start()

        microphone.start()
        tracker?.start()

    }

    public func stop() {
        microphone.stop()
        AudioKit.stop()
    }

    @objc internal func measureFrequency() {
        print("microphone is on: \(microphone.isStarted)")

        if let frequency = tracker?.frequency {
            print("get frequency: \(frequency)")
        } else {
            print("problem")
        }
    }
}

// MARK: - Translator character 2 frequency
class BatSignalTranslator {

    private var bat = BatSignalSampler()

    public func generateFrequency(forChar c: UInt8) -> Double {
        let freq = Double((Int(c) * bat.step) + bat.base)
        return freq
    }

    public func getChar(forBin b: Int) -> Character {
        var char = 0
        if b == bat.baseBin {
            char = 1
        } else if b > bat.baseBin {
            char = (b - bat.baseBin)
        }
        return Character(UnicodeScalar(char))
    }
}
