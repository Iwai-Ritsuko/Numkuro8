//
//  DifficultyCreator.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/25.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation
public class DifficultyCreator {
    class func createDifficulty(difficulty: Difficulty) -> String {
        switch difficulty {
        case .veryEasy:
            return "★☆☆☆☆"
        case .easy:
            return "★★☆☆☆"
        case .normal:
            return "★★★☆☆"
        case .hard:
            return "★★★★☆"
        case .veryHard:
            return "★★★★★"
        }
    }
}
