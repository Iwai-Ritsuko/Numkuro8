//
//  Numkuro+CoreDataClass.swift
//  Numkuro8
//
//  Created by Ritsuko Iwai on 2017/08/04.
//  Copyright © 2017年 Ritsuko Iwai. All rights reserved.
//

import Foundation
import CoreData

@objc(Numkuro)
public class Numkuro: NSManagedObject {

    func addPanels(value: Panel) {
        let items = mutableOrderedSetValue(forKey: "panels")
        items.add(value)
    }
}
