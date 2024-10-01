//
//  Tasks+CoreDataProperties.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 10.09.2024.
//
//

import Foundation
import CoreData


extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var title: String?
    @NSManaged public var details: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var id: String?
    @NSManaged public var category: Category?

}

extension Tasks : Identifiable {

    func updateTask(newTitle: String, newDetails: String?) {
        self.title = newTitle
        self.details = newDetails
        self.isCompleted = isCompleted
        
        try? managedObjectContext?.save()
    }
    
    func deleteTask(_ task: Tasks) {
        managedObjectContext?.delete(self)
        try? managedObjectContext?.save()
    }
    
    
}
