//
//  ContentView.swift
//  GRE3000
//
//  Created by Changhao Song on 2022-01-18.
//

import SwiftUI
import CoreXLSX

struct ContentView: View {
    let userDefaults = UserDefaults.standard
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        let word = Word(word: viewModel.words[viewModel.num], phonetics: viewModel.phoneticses[viewModel.num], paraphrase: viewModel.paraphrases[viewModel.num])
        GeometryReader { proxy in
            ZStack {
                HStack(spacing: 0) {
                    Button {
                        if viewModel.num > 1 {
                            viewModel.num -= 1
                            userDefaults.set(viewModel.num, forKey: "num")
                        }
                        if viewModel.autoPronunce {
                            pronunce(word: viewModel.words[viewModel.num])
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                    }
                    Button {
                        if viewModel.num == 3000 {
                            viewModel.num = 0
                        }
                        viewModel.num += 1
                        userDefaults.set(viewModel.num, forKey: "num")
                        if viewModel.autoPronunce {
                            pronunce(word: viewModel.words[viewModel.num])
                        }
                    } label: {
                        Rectangle()
                            .foregroundColor(.clear)
                    }
                }
                
                VStack {
                    HStack {
                        Text("\(viewModel.num)")
                            .underline()
                            .padding()
                        Spacer()
                        Button {
                            viewModel.autoPronunce.toggle()
                            userDefaults.set(viewModel.autoPronunce, forKey: "autoPronunce")
                        } label: {
                            if viewModel.autoPronunce {
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
                    Spacer()
                }
            }
        }
    }
}
