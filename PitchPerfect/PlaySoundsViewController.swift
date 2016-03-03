//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Alexander Nelson on 2/6/16.
//  Copyright © 2016 Jetwolfe Labs. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    var receivedAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!
    var audioFile: AVAudioFile!
    
    let slowAudioRate: Float = 0.5
    let fastAudioRate: Float = 2.0
    let darthVaderPitch: Float = -999
    let chipmunkPitch: Float = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
    }
    
    func stopAndResetAudio() {
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.stop()
    }
    
    func playSoundWithRateOfSpeed(rate: Float) {
        stopAndResetAudio()
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        stopAndResetAudio()
        
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
    }

    @IBAction func playSoundSlowly(sender: UIButton) {
        playSoundWithRateOfSpeed(slowAudioRate)
    }

    @IBAction func playSoundFast(sender: UIButton) {
        playSoundWithRateOfSpeed(fastAudioRate)

    }


    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(chipmunkPitch)
    }


    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(darthVaderPitch)
    }

    @IBAction func stop(sender: UIButton) {
        audioPlayer?.stop()
    }
    



}
