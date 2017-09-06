//
//  LoadListViewController.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/07/11.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol LoadListDelegate {
    func saveLoadNumkuro(contents: [NumkuroPanel])
}

class LoadListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var numkuroContents = [NumkuroPanel]()
    var selectedIndex = -1
    var delegate: LoadListDelegate?
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numkuroContents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NunkuroCell(style: .subtitle, reuseIdentifier: "NunkuroCell")
        let numkuroPanel = numkuroContents[indexPath.row]
        cell.textLabel?.text = numkuroPanel.title
        cell.detailTextLabel?.text = DifficultyCreator.createDifficulty(difficulty: numkuroPanel.difficulty)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        let numkuroPanel = numkuroContents[indexPath.row]
        createLoadNankuroView(numkuroPanel: numkuroPanel)
    }

    func createLoadNankuroView(numkuroPanel: NumkuroPanel) {
        let storyboard = UIStoryboard(name: "LoadViewController", bundle: Bundle.main)
        guard let nextView = storyboard.instantiateInitialViewController() as? LoadViewController else {
            return
        }
        nextView.delegate = self
        nextView.numkuroPanel = numkuroPanel
        present(nextView, animated: true, completion: nil)
    }

    @IBAction func goGack() {
        delegate?.saveLoadNumkuro(contents: numkuroContents)
        dismiss(animated: true, completion: nil)
    }

//    func saveLoadNumkuro(numkuroPanel: NumkuroPanel) {
//        if selectedIndex < numkuroContents.count {
//            numkuroContents[selectedIndex] = numkuroPanel
//            tableView.reloadData()
//        }
//    }
}

extension LoadListViewController: LoadViewDelegate {
    func saveLoadNumkuro(numkuroPanel: NumkuroPanel) {
//        if selectedIndex < numkuroContents.count {
//            numkuroContents[selectedIndex] = numkuroPanel
//            tableView.reloadData()
//        }
//        saveLoadNumkuro(numkuroPanel: numkuroPanel)
    }
}
