//
//  AnalyzeNumber.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/10.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation

public class AnalyzeNumber: NSObject {

    public class func isDuplicated(number: Int, index: Int, tiles: [NumkuroTile]) -> Bool {
        guard let current = tiles.filter({ $0.index == index }).first else {
            return true
        }
        if isDuplicatedInRow(number: number, row: current.row, tiles: tiles) {
            return true
        }
        if isDuplicatedInColumn(number: number, column: current.column, tiles: tiles) {
            return true
        }
        if isDuplicatedInGroup(number: number, group: current.group, tiles: tiles) {
            return true
        }
        return false
    }

    public class func isDuplicatedInRow(number: Int, row: Int, tiles: [NumkuroTile]) -> Bool {
        return tiles.filter({ $0.row == row })
            .index(where: { $0.suji == number }) != nil
    }

    public class func isDuplicatedInColumn(number: Int, column: Int, tiles: [NumkuroTile]) -> Bool {
        return tiles.filter({ $0.column == column })
            .index(where: { $0.suji == number }) != nil
    }

    public class func isDuplicatedInGroup(number: Int, group: Int, tiles: [NumkuroTile]) -> Bool {
        return tiles.filter({ $0.group == group })
            .index(where: { $0.suji == number }) != nil
    }


    // 以下消す予定
    public class func isDuplicated(number: Int, current: NumkuroTile, nunkuros:[NumkuroTile]) -> Bool {
        // 行での重複確認
        if isDuplicatedInRow(number: number, current: current, nunkuros: nunkuros) {
            return true
        }

        // 列での重複確認
        if isDuplicatedInColumn(number: number, current: current, nunkuros: nunkuros) {
            return true
        }

        // グループでの重複確認
        if isDuplicatedInGroup(number: number, current: current, nunkuros: nunkuros) {
            return true
        }
        return false
    }



    public class func isDuplicatedInRow(number: Int, current: NumkuroTile, nunkuros:[NumkuroTile]) -> Bool {
        return nunkuros.filter({ $0.row == current.row })
            .index(where: { $0.suji == number }) != nil
    }

    public class func isDuplicatedInColumn(number: Int, current: NumkuroTile, nunkuros:[NumkuroTile]) -> Bool {
        return nunkuros.filter({ $0.column == current.column })
            .index(where: { $0.suji == number }) != nil
    }

    public class func isDuplicatedInGroup(number: Int, current: NumkuroTile, nunkuros:[NumkuroTile]) -> Bool {
        return nunkuros.filter({ $0.group == current.group })
            .index(where: { $0.suji == number }) != nil
    }

}
