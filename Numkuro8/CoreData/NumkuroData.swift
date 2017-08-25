//
//  NumkuroData.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/08/02.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import UIKit
import CoreData
class NumkuroData {


    class func loadNumkuroData() -> [NumkuroPanel] {
        var panels = [NumkuroPanel]()
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            return panels
        }
        let viewContext = app.persistentContainer.viewContext
        let request:NSFetchRequest<Numkuro> = Numkuro.fetchRequest()

        do {
            let fetchResults = try viewContext.fetch(request)
            for result: AnyObject in fetchResults {
                guard let panel = result.value(forKey: "Panel") as? Panel,
                    let title = panel.title,
                    let difficulty = Difficulty(rawValue: Int(panel.difficulty)),
                    let tiles = panel.tiles else {
                    return [NumkuroPanel]()
                }
                let numkuroPanel = NumkuroPanel()
                numkuroPanel.title = title
                numkuroPanel.difficulty = difficulty
                var numkuroTiles = [NumkuroTile]()
                for tile in tiles {
                    guard let condition = NunkuroCondition(rawValue: tile.condition) else {
                        return [NumkuroPanel]()
                    }
                    let numkuroTile = NumkuroTile(suji: tile.suji, condition: condition)
                    numkuroTiles.append(numkuroTile)
                }
                numkuroPanel.tiles = numkuroTiles
                panels.append(numkuroPanel)
            }
        } catch {
        }
        return panels
    }

    class func updateNumkuroData(numkuroPanels:[NumkuroPanel]) {
        if numkuroPanels.isEmpty {
            return
        }
        guard let app = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let viewContext = app.persistentContainer.viewContext
        guard let numkuroEntity = NSEntityDescription.entity(forEntityName: "Panel", in: viewContext) else {
            return
        }
//        let numkuroEntity = NSFetchRequest<NSFetchRequestResult>(entityName: "Panel")
//        let numkuro = Panel(entity: numkuroEntity, insertInto: viewContext)

//        let numkuro = Numkuro(context: viewContext)
        var panels = [Panel]()
        for numkuroPanel in numkuroPanels {
            let panel = Panel(context: viewContext)
            panel.title = numkuroPanel.title
            panel.difficulty = Int16(numkuroPanel.difficulty.rawValue)
            var tiles = [Tile]()
            for numkuroTile in numkuroPanel.tiles {
                let tile = Tile(context: viewContext)
                tile.suji = numkuroTile.suji
                tile.condition = numkuroTile.condition.rawValue
                tiles.append(tile)
            }
            panel.tiles = tiles
            panels.append(panel)
        }
//        numkuro.panels = panels
        do {
            try viewContext.save()
        } catch {

        }
    }

}
