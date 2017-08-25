//
//  Tile+CoreDataProperties.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/08/04.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation
import CoreData


extension Tile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tile> {
        return NSFetchRequest<Tile>(entityName: "Tile")
    }

    @NSManaged public var suji: Int
    @NSManaged public var condition: Int
    @NSManaged public var panel: Panel?

}
