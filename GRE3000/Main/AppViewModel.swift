//
//  AppViewModel.swift
//  GRE3000
//
//  Created by Changhao Song on 2022-01-18.
//

import Foundation
import CoreXLSX
import SwiftUI

class AppViewModel: ObservableObject {
    let userDefaults = UserDefaults.standard
    @Published var words: [String] = ["error"]
    @Published var phoneticses: [String] = ["[error]"]
    @Published var paraphrases: [String] = ["错误"]
    
    init () {
        if userDefaults.stringArray(forKey: "words") == nil
            || userDefaults.stringArray(forKey: "phoneticses") == nil
            || userDefaults.stringArray(forKey: "paraphrases") == nil {
            buildDB()
        }
        else {
            readDB()
        }
    }
    
    func buildDB() {
        print("First time running...")
        let filepath = Bundle.main.path(
            forResource: "3000",
            ofType: "xlsx"
        )
        guard let file = XLSXFile(filepath: filepath!) else {
            fatalError("XLSX file at \(filepath!) is corrupted or does not exist")
        }
        
        for wbk in try! file.parseWorkbooks() {
            for (name, path) in try! file.parseWorksheetPathsAndNames(workbook: wbk) {
                if name == "3000" {
                    let worksheet = try! file.parseWorksheet(at: path)
                    
                    if let sharedStrings = try! file.parseSharedStrings() {
                        words = worksheet.cells(atColumns: [ColumnReference("I")!])
                            .compactMap { $0.stringValue(sharedStrings) }
                        userDefaults.set(words, forKey: "words")
                        
                        phoneticses = worksheet.cells(atColumns: [ColumnReference("K")!])
                            .compactMap { $0.stringValue(sharedStrings) }
                        userDefaults.set(phoneticses, forKey: "phoneticses")
                        
                        paraphrases = worksheet.cells(atColumns: [ColumnReference("M")!])
                            .compactMap { $0.stringValue(sharedStrings) }
                        userDefaults.set(paraphrases, forKey: "paraphrases")
                        print("Finished saving.")
                    }
                }
            }
        }
    }
    
    func readDB () {
        print("Reading from memory...")
        words = userDefaults.stringArray(forKey: "words")!
        phoneticses = userDefaults.stringArray(forKey: "phoneticses")!
        paraphrases = userDefaults.stringArray(forKey: "paraphrases")!
        print("Reading completed.")
    }
}
