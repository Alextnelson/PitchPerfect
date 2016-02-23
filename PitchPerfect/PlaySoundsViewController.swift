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

    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = try! AVAudioPlayer(contentsOfURL: receivedAudio.filePathURL)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receivedAudio.filePathURL)
    }

    @IBAction func playSoundSlowly(sender: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.rate = 0.5
        audioPlayer?.currentTime = 0.0
        audioPlayer?.play()
    }

    @IBAction func playSoundFast(sender: UIButton) {
        audioPlayer?.stop()
        audioPlayer?.rate = 2.0
        audioPlayer?.currentTime = 0.0
        audioPlayer?.play()
    }


    @IBAction func playChipmunkAudio(sender: UIButton) {
        playAudioWithVariablePitch(1000)
    }

    func playAudioWithVariablePitch(pitch: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()

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


    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-999)
    }

    @IBAction func stop(sender: UIButton) {
        audioPlayer?.stop()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
