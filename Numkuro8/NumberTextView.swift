//
//  NumberTextView.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/23.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

enum ManageType: Int {
    case up = 1
    case down = 2
    case left = 3
    case right = 4
    case del = 5
    case clearAll = 6
}

protocol NumberTextViewDelegate {
    func updateButtonStatus(up: Bool, down: Bool, left: Bool, right: Bool)
}

class NumberTextView: UIView {
    var delegate: NumberTextViewDelegate!
    var tileViews = [TileView]()
    var selectedIndex = 1

    func createNumberTextView(numkuros: [NumkuroTile]) {
        createFrameView()
        createGroupView()
        createTileView(numkuros: numkuros)
    }

    // フレーム
    private func createFrameView() {
        // 横置きの時のレイアウト要検討
        let viewSmallLen = UIApplication.shared.statusBarOrientation.isPortrait ? frame.size.width : frame.size.height
        let frameView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: viewSmallLen, height: viewSmallLen))
        frameView.layer.borderColor = UIColor.black.cgColor
        frameView.layer.borderWidth = 3.0
        addSubview(frameView)
    }

    // グループ
    private func createGroupView() {
        let viewSmallLen = frame.size.width < frame.size.height ? frame.size.width : frame.size.height
        let tileLen = viewSmallLen / 9
        var gx:CGFloat = 0.0
        var gy:CGFloat = 0.0
        for i in 0..<9 {
            let groupView = UIView(frame: CGRect(x: gx, y: gy, width: tileLen * 3, height: tileLen * 3))
            groupView.layer.borderColor = UIColor.blue.cgColor
            groupView.layer.borderWidth = 2.0
            groupView.backgroundColor = .clear
            addSubview(groupView)
            if i % 3 == 2 {
                gx = 0
                gy += tileLen * 3
            } else {
                gx += tileLen * 3
            }
        }
    }

    // タイル
    private func createTileView(numkuros: [NumkuroTile]) {
        let viewSmallLen = frame.size.width < frame.size.height ? frame.size.width : frame.size.height
        let tileLen = viewSmallLen / 9
        var x:CGFloat = 0.0
        var y:CGFloat = 0.0
        var tileCount = 0
        tileViews.removeAll()
        for numkuro in numkuros {
            let tile = TileView(frame: CGRect(x: x, y: y, width: tileLen, height: tileLen),
                                numkuroTile: numkuro.copy() as! NumkuroTile)
            tile.delegate = self
            addSubview(tile)
            tileViews.append(tile)
            if tileCount == 8 {
                tileCount = 0
                x = 0
                y += tileLen
            } else {
                tileCount += 1
                x += tileLen
            }
        }
    }

    func currentTiles() -> [NumkuroTile] {
        let tiles = tileViews.map { $0.tile }
        return tiles
    }

    // MARK - Manage Numkuro
    func manageNumkukroWith(type: ManageType) {
        switch type {
        case .up:
            up()
        case .down:
            down()
        case .left:
            left()
        case .right:
            right()
        case .del:
            del()
        case .clearAll:
            clearAll()
        }
    }

    private func up() {
        selectedIndex -= 9
        switchBoarders()
    }

    private func down() {
        selectedIndex += 9
        switchBoarders()
    }

    private func left() {
        selectedIndex -= 1
        switchBoarders()
    }

    private func right() {
        selectedIndex += 1
        switchBoarders()
    }

    func clearAll() {
        tileViews.forEach({
            $0.text = nil
            $0.tile.suji = 0
            $0.tile.condition = .initial
        })
        setNeedsDisplay()
    }

    func del() {
        if selectedIndex == -1 || selectedIndex >= tileViews.count {
            return
        }
        let tileView = tileViews[selectedIndex]
        tileView.text = nil
        tileView.tile.suji = 0
        tileView.tile.condition = .initial
    }

    func place(number: Int, condition: NunkuroCondition) {
        if selectedIndex == -1 || selectedIndex > tileViews.count {
            return
        }
        let tiles = tileViews.map { $0.tile }
        if AnalyzeNumber.isDuplicated(number: number, index: selectedIndex, tiles: tiles) {
            return
        }
        guard let tileView = tileViews.filter({ $0.tile.index == selectedIndex }).first else {
            return
        }
        tileView.update(number: number, condition:condition)
    }

    func switchBoarders() {
        for tileView in tileViews {
            tileView.switchBorder(selected: tileView.tile.index == selectedIndex)
        }
    }

    private func manageMove() {
        let isTopLine = selectedIndex <= 9
        let isBottmLine = selectedIndex >= 73
        let isLeftLine = selectedIndex % 9 == 1
        let isRightLine = selectedIndex % 9 == 0
        delegate?.updateButtonStatus(up: isTopLine,
                                     down: isBottmLine,
                                     left: isLeftLine,
                                     right: isRightLine)
    }

}

extension NumberTextView: TileViewDelegate {
    func forcused(index: Int) {
        selectedIndex = index
        switchBoarders()
    }
}
