//
//  NewListViewController.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/28.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

protocol NewListDelegate {
    func saveNewNumkuro(contents: [NumkuroPanel])
}

class NewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewNunkuroDelegate {
    var numkuroContents = [NumkuroPanel]()
    var selectedIndex = -1
    var delegate: NewListDelegate?
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
        createNewNankuroView(numkuroPanel: numkuroPanel)
    }

    @IBAction func createNewNankuro() {
        selectedIndex = numkuroContents.count
        let numkuroPanel = NumkuroPanel()
        var nunkuroTiles = [NumkuroTile]()
        for i in 0..<81 {
            let tile = NumkuroTile(suji: 0, condition: .initial)
            tile.index = i
            nunkuroTiles.append(tile)
        }
        numkuroPanel.tiles = nunkuroTiles
        numkuroPanel.title = createTitle()
        numkuroPanel.difficulty = .easy
        createNewNankuroView(numkuroPanel: numkuroPanel)
    }

    func createTitle() -> String {
        var i = 1
        var notExist = true
        while notExist {
            let numTitle = "Numkuro " + i.description
            if numkuroContents.flatMap({ $0.title })
                                 .contains(numTitle) {
                i += 1
            } else {
                notExist = false
            }
        }
        return "Numkuro " + i.description
    }

    func createNewNankuroView(numkuroPanel: NumkuroPanel) {
        let storyboard = self.storyboard
        let nextView = storyboard?.instantiateViewController(withIdentifier: "NewNumkuro") as! NewNunkuroViewController
        nextView.delegate = self
        nextView.numkuroPanel = numkuroPanel
        present(nextView, animated: true, completion: nil)
    }

    @IBAction func goGack() {
        dismiss(animated: true, completion: nil)
    }

    // MARK - NewNunkuroDelegate
    func saveNewNunkuro(numkuroPanel: NumkuroPanel) {
        if selectedIndex < numkuroContents.count {
            numkuroContents[selectedIndex] = numkuroPanel
        } else {
            numkuroContents.append(numkuroPanel)
        }
        self.delegate?.saveNewNumkuro(contents: numkuroContents)
        tableView.reloadData()
    }

}
