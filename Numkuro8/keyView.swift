//
//  keyView.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/23.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

// LoadNunkuroViewControllerの修正ができれば削除

import UIKit

class KeyView: UIButton {

    func viewTitleWith(tag: Int, viewStatus: NumkuroStatus) {
        let viewTitle: String
        switch tag {
        case _ where tag <= 9:
            viewTitle = tag.description
        case _ where tag == 10:
            viewTitle = viewStatus == .new ? "Clear All" : "Clear"
            setTitleColor(.orange, for: .normal)
        case _ where tag == 11:
            viewTitle = viewStatus == .new ? "Save" : "Save Answer"
            setTitleColor(.green, for: .normal)
        case _ where tag == 12:
            viewTitle = viewStatus == .new ? "Del": "Del"
            setTitleColor(.red, for: .normal)
        default:
            viewTitle = tag.description
        }
        setTitle(viewTitle, for: .normal)
    }

}
