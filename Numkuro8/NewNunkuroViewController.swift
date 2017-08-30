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
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        padView.delegate = self
        numView.delegate = self
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

    func saveNumkuro() {
        numkuroPanel.tiles = numView.currentTiles()
        delegate?.saveNewNunkuro(numkuroPanel: numkuroPanel)
    }

    @IBAction func back(button: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func duplicate(button: UIButton) {

    }

    @IBAction func save(button: UIButton) {
        saveNumkuro()
    }

    @IBAction func assist(button: UIButton) {
        numView.manageNumkukroWith(type: ManageType(rawValue: button.tag)!)
    }

}

// MARK - 入力パッド　KeyPadViewDelegate
extension NewNunkuroViewController: KeyPadViewDelegate {

    func place(number: Int) {
        numView.place(number: number, condition: .defined)
    }
    
}

// MARK -
extension NewNunkuroViewController: NumberTextViewDelegate {

    func updateButtonStatus(up: Bool, down: Bool, left: Bool, right: Bool) {
        upButton.isEnabled = up
        downButton.isEnabled = down
        leftButton.isEnabled = left
        rightButton.isEnabled = right
    }
}
