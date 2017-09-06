//
//  LoadViewController.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/27.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol LoadViewDelegate {
    func saveLoadNumkuro(numkuroPanel: NumkuroPanel)
}

class LoadViewController: UIViewController {
    var numkuroPanel = NumkuroPanel()
    var delegate: LoadViewDelegate?

    @IBOutlet weak var numView: NumberTextView!
    @IBOutlet weak var padView: KeyPadView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        padView.delegate = self
    }

    override func viewDidLayoutSubviews() {
        numView.createNumberTextView(numkuros: numkuroPanel.tiles)
        padView.createKeyView(numkuroStatus: .load)
        titleLabel.text = numkuroPanel.title
        difficultyLabel.text = DifficultyCreator.createDifficulty(difficulty: numkuroPanel.difficulty)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func saveNunkuro() {
        numkuroPanel.tiles = numView.currentTiles()
        delegate?.saveLoadNumkuro(numkuroPanel: numkuroPanel)
    }

    @IBAction func backButtonDidTapped(button: UIButton) {
        saveNunkuro()
        delegate?.saveLoadNumkuro(numkuroPanel: numkuroPanel)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func clearAll(button: UIButton) {
        numView.clearAll()
    }

    @IBAction func del(button: UIButton) {
        numView.del()
    }

    @IBAction func save() {
        saveNunkuro()
    }
    
}

extension LoadViewController: KeyPadViewDelegate {

    func place(number: Int) {
        numView.place(number: number, condition: .difinishion)
    }

}
