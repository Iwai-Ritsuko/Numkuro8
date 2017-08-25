//
//  LoadAssistView.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/08/24.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol LoadAssistViewDelegate {
    func clearAll()
    func del()
    func save()
}

class LoadAssistView: UIView {
    var delegate: LoadAssistViewDelegate!

    @IBAction func clearAll() {
        delegate?.clearAll()
    }

    @IBAction func del() {
        delegate?.del()
    }

    @IBAction func save() {
        delegate?.save()
    }

}
