//
//  Numkuro+CoreDataProperties.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/08/04.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation
import CoreData


extension Numkuro {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Numkuro> {
        return NSFetchRequest<Numkuro>(entityName: "Numkuro")
    }

    @NSManaged public var panels: [Panel]?

}
