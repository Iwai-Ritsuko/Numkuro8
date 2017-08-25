//
//  ViewController.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/06/23.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit

enum NumkuroStatus {
    case new
    case load
}

class ViewController: UIViewController {
    var numkuroContents = [NumkuroPanel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadNankuroContents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapNew() {
        openNewList()
    }

    @IBAction func tapLoad() {
        openLoadList()
    }

    // nankuroContents ダウンロード
    private func loadNankuroContents() {
        // ロード
//        guard let contents = NumkuroPanelManager.loadNumkuroData() else {
//            return
//        }
//        numkuroContents = NumkuroData.loadNumkuroData()
    }

    func openNewList() {
        let storyboard = self.storyboard
        let nextView = storyboard?.instantiateViewController(withIdentifier: "NewListViewController") as! NewListViewController
        nextView.delegate = self
        nextView.numkuroContents = numkuroContents
        present(nextView, animated: true, completion: nil)
    }

    func openLoadList() {
        let storyboard = self.storyboard
        let nextView = storyboard?.instantiateViewController(withIdentifier: "LoadListViewController") as! LoadListViewController
        nextView.delegate = self
        nextView.numkuroContents = numkuroContents
        present(nextView, animated: true, completion: nil)
    }

    func saveList() {
        NumkuroPanelManager.saveNumkuroData(numkuroContents: numkuroContents)
    }
}

extension ViewController: NewListDelegate {

    func saveNewNumkuro(contents: [NumkuroPanel]) {
        numkuroContents = contents
//        NumkuroData.updateNumkuroData(numkuroPanels: numkuroContents)
//        NumkuroPanelManager.saveNumkuroData(numkuroContents: numkuroContents)
    }

}

extension ViewController: LoadListDelegate {

    func saveLoadNumkuro(contents: [NumkuroPanel]) {
        numkuroContents = contents
        NumkuroPanelManager.saveNumkuroData(numkuroContents: numkuroContents)
    }

}
