//
//  NumkuroTile.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/23.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation

enum NunkuroCondition : Int {
    case initial = 0
    case difinishion = 1
    case defined = 2
    case suspense = 3
}

public class NumkuroTile: NSObject {
    var suji: Int
    var condition: NunkuroCondition
    var index: Int {
        didSet {
            row = index % 9
            column = index / 9
            group = row / 3 + (column / 3) * 3
        }
    }
    var row: Int
    var column: Int
    var group: Int

    init(suji:Int, condition:NunkuroCondition, index:Int = 0, row:Int = 0, column:Int = 0, group:Int = 0) {
        self.suji = suji
        self.condition = condition
        self.index = index
        self.row = row
        self.column = column
        self.group = 0
    }

    override public func copy() -> Any {
        let copy = NumkuroTile(suji: suji,
                               condition: condition,
                               index: index,
                               row: row,
                               column:column,
                               group:group)
        return copy
    }

}
