//
//  TileView.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/20.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol TileViewDelegate {
    func forcused(index: Int)
}

class TileView: UILabel {
    var tile = NumkuroTile(suji: 0, condition: .initial)
    var delegate: TileViewDelegate!

    init(frame: CGRect, numkuroTile: NumkuroTile) {
        super.init(frame: frame)
        tile = numkuroTile
        isUserInteractionEnabled = true
        textAlignment = .center
        backgroundColor = .clear
        layer.borderWidth = 1.0
        prepareTileView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func prepareTileView() {
        if tile.suji > 0 {
            text = tile.suji.description
        }
        switchBorder(selected: false)
    }

    func switchBorder(selected: Bool) {
        if (selected) {
            layer.borderColor = UIColor.red.cgColor
        } else {
            layer.borderColor = UIColor.lightGray.cgColor
        }
    }

    func update(number: Int, condition: NunkuroCondition) {
        text = number.description
        tile.suji = number
        tile.condition = condition
        switch condition {
        case .initial, .difinishion:
            textColor = .black
        case .defined:
            textColor = .blue
        case .suspense:
            textColor = .orange
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.forcused(index: tile.index)
    }

}
