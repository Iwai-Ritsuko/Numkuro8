//
//  NumkuroPanelManager.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/24.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation

class NumkuroPanelManager: NSObject {

    class func loadNumkuroData() -> [NumkuroPanel]? {
        let manager = FileManager.default
        guard let documentURL = manager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }
        let url = documentURL.appendingPathComponent("NumkuroData")

        guard let result = try? Data(contentsOf: url) else { return nil }
        guard let panels = NSKeyedUnarchiver.unarchiveObject(with: result) as? [String] else {
//        guard let panels = NSKeyedUnarchiver.unarchiveObject(with: result) as? [NumkuroPanel] else {
            return nil
        }
        print("panels = \(panels)")
//        return panels
        return [NumkuroPanel]()

    }

    class func saveNumkuroData(numkuroContents: [NumkuroPanel]) {
        let manager = FileManager.default
        guard let documentURL = manager.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return
        }
        // すでにファイルがあれば一旦削除
        let url = documentURL.appendingPathComponent("NumkuroData")
        if manager.fileExists(atPath: url.path) {
            // DeleteFile
            try? manager.removeItem(at: url)
        }

        // ファイル書き込み
        let titles = numkuroContents.map({ $0.title })
        NSKeyedArchiver.archiveRootObject(titles, toFile: url.path)
        let data = NSData(bytes: titles, length: titles.count)
//        NSKeyedArchiver.archiveRootObject(numkuroContents, toFile: url.path)
//        let data = NSKeyedArchiver.archivedData(withRootObject: numkuroContents)
        try? data.write(to: url)
    }

}
