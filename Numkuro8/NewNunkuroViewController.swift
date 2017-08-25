//
//  NewNunkuroViewController.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/27.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol NewNunkuroDelegate {
    func saveNewNunkuro(numkuroPanel: NumkuroPanel)
}

class NewNunkuroViewController: UIViewController {
    var numkuroPanel =  NumkuroPanel()
    var delegate: NewNunkuroDelegate?

    @IBOutlet weak var numView: NumberTextView!
    @IBOutlet weak var padView: KeyPadView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var difficultyField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        padView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        numView.createNumberTextView(numkuros: numkuroPanel.tiles)
        padView.createKeyView(numkuroStatus: .new)
        titleField.text = numkuroPanel.title
        difficultyField.text = DifficultyCreator.createDifficulty(difficulty: numkuroPanel.difficulty)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveNunkuro() {
        numkuroPanel.tiles = numView.currentTiles()
        delegate?.saveNewNunkuro(numkuroPanel: numkuroPanel)
    }

    @IBAction func back(button: UIButton) {
        delegate?.saveNewNunkuro(numkuroPanel: numkuroPanel)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func duplicate(button: UIButton) {
        
    }

    @IBAction func clearAll(button: UIButton) {
        numView.clearAll()
    }

    @IBAction func del(button: UIButton) {
        numView.del()
    }

    @IBAction func save(button: UIButton) {
        saveNunkuro()
    }

}

    // MARK - 入力パッド　KeyPadViewDelegate
extension NewNunkuroViewController: KeyPadViewDelegate {

    func place(number: Int) {
        numView.place(number: number, condition: .defined)
    }

}
