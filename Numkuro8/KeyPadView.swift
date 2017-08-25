//
//  KeyPadView.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/20.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol KeyPadViewDelegate {
    func place(number: Int)
}

class KeyPadView: UIView {
    var delegate: KeyPadViewDelegate!
    var selectedIndex = -1
    var viewStatus: NumkuroStatus = .load
    let tileHeight:CGFloat = 40.0

    func createKeyView(numkuroStatus: NumkuroStatus) {
        // 横置きの時のレイアウト要検討
        let viewSmallLen = UIApplication.shared.statusBarOrientation.isPortrait ? frame.size.width : frame.size.height
        let tileLen = viewSmallLen / 3
        let marge:CGFloat = (viewSmallLen - (tileLen * 3)) / 2
        var px:CGFloat = marge
        var py:CGFloat = 0.0
        for i in 1..<10 {
            let keyView = KeyView(type: .system)
            keyView.frame = CGRect(x: px, y: py, width: tileLen, height: tileHeight)
            if i % 3 == 0 {
                px = marge
                py += tileHeight
            } else {
                px += tileLen
            }
            keyView.viewTitleWith(tag: i, viewStatus: numkuroStatus)
            keyView.backgroundColor = UIColor.init(red: 0.87, green: 1.0, blue: 1.0, alpha: 1.0)
            keyView.layer.borderColor = UIColor.lightGray.cgColor
            keyView.layer.borderWidth = 1.0
            keyView.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
            keyView.tag = i

            viewStatus = numkuroStatus

            addSubview(keyView)
        }
    }

    func buttonTapped(sender: UIButton) {
        delegate?.place(number: sender.tag)
    }

}
