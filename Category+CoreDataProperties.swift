//
//  Category+CoreDataProperties.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 10.09.2024.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var icon: String?
    @NSManaged public var tasks: NSSet?

}

extension Category : Identifiable {
    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Tasks)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Tasks)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)
}
