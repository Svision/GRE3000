//
//  ContentView.swift
//  GRE3000
//
//  Created by Changhao Song on 2022-01-18.
//

import SwiftUI
import CoreXLSX

struct ContentView: View {
    @State var num: Int = 1
    @State var enableAutoPronunce = true
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        let word = Word(word: viewModel.words[num], phonetics: viewModel.phoneticses[num], paraphrase: viewModel.paraphrases[num])
        GeometryReader { proxy in
            ZStack {
                HStack(spacing: 0) {
                    Button {
                        if num > 1 {
                            num -= 1
                        }
                        if enableAutoPronunce {
                            pronunce(word: viewModel.words[num])
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                    }
                    Button {
                        if num == 3000 {
                            num = 0
                        }
                        num += 1
                        if enableAutoPronunce {
                            pronunce(word: viewModel.words[num])
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                    }
                }
                
                VStack {
                    HStack {
                        Text("\(num)")
                            .underline()
                            .padding()
                        Spacer()
                        Button {
                            enableAutoPronunce.toggle()
                        } label: {
                            if enableAutoPronunce {
                                Image(systemName: "speaker.wave.3")
                            }
                            else {
                                Image(systemName: "speaker.slash")
                            }
                        }
                        .font(.title3)
                        .padding()
                        .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    Group {
                        Text(word.en)
                            .font(.system(size: 32.0))
                            .padding()
//                        Text(word.phonetics)
//                            .font(.system(size: 22.0))
                        Text(word.ch)
                            .font(.system(size: 22.0))
                            .frame(maxWidth: proxy.size.width / 1.5)
                            .multilineTextAlignment(.center)
                    }
                    .onTapGesture {
                        pronunce(word: word.en)
                    }
                    Spacer()
                }
            }
        }
    }
}
