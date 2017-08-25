//
//  Panel+CoreDataProperties.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/08/04.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation
import CoreData


extension Panel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Panel> {
        return NSFetchRequest<Panel>(entityName: "Panel")
    }

    @NSManaged public var difficulty: Int16
    @NSManaged public var title: String?
    @NSManaged public var tiles: [Tile]?
//    @NSManaged public var numkuro: Numkuro?

}
