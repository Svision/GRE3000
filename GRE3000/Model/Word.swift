//
//  Word.swift
//  GRE3000
//
//  Created by Changhao Song on 2022-01-18.
//

import Foundation

class Word {
    let en: String
    let phonetics: String
    let ch: String
    
    var viewedCount: Int
    
    init (word: String, phonetics: String, paraphrase: String) {
        self.en = word
        self.phonetics = phonetics
        self.ch = paraphrase
        
        self.viewedCount = 0
    }
}
