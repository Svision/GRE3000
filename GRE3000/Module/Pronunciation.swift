//
//  Pronunciation.swift
//  GRE3000
//
//  Created by Changhao Song on 2022-01-19.
//

import AVFoundation

var player: AVAudioPlayer?

func pronunce(word: String) {
    guard let url = Bundle.main.url(forResource: word, withExtension: "wav") else { return }

    do {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)

        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

        guard let player = player else { return }

        player.play()

    } catch let error {
        print(error.localizedDescription)
    }
}
