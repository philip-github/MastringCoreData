//
//  Task+CoreDataProperties.swift
//  MasterCoreData
//
//  Created by Philip Twal on 3/21/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var details: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var ofUser: User?

}
