//
//  NumkuroPanel.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/13.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation

enum Difficulty: Int {
    case veryEasy
    case easy
    case normal
    case hard
    case veryHard
}

public class NumkuroPanel: NSObject {
    var title = ""
    var difficulty:Difficulty = .easy
    var tiles:[NumkuroTile] = [NumkuroTile]()

}
