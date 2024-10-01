//
//  CoreManager.swift
//  To Do List
//
//  Created by Гидаят Джанаева on 10.09.2024.
//

import Foundation
import CoreData

class CoreManager {
    static let shared = CoreManager()
    var tasks = [Tasks]()
    private init() {
        fetchAllNotes()
        
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "To_Do_List")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {

                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchAllNotes() {
        let req = Tasks.fetchRequest()
        if let tasks = try? persistentContainer.viewContext.fetch(req) {
            self.tasks = tasks
    
        }
    }
    
    
    func createCategory(name: String, icon: String) {
        let context = persistentContainer.viewContext
        let category = Category(context: context)
        category.name = name
        category.icon = icon
        
        saveContext()
        
    }
    
    func createTask(title: String, details: String, isCompleted: Bool, category: Category) {
        let context = persistentContainer.viewContext
        let task = Tasks(context: context)
        task.id = UUID().uuidString
        task.title = title
        task.details = details
        task.isCompleted = isCompleted
        task.category = category
        
        saveContext()
        fetchAllNotes()
        
    }
    
    func deleteCategory(_ category: Category) {
        let context = persistentContainer.viewContext
        context.delete(category)
        
        saveContext()
    }
    
    func initializeInitialData() {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Category> = Category.fetchRequest()
        
        do {
            let categories = try context.fetch(fetchRequest)
            if categories.isEmpty {
                // Добавляем начальные категории
                createCategory(name: "Day", icon: "dayIcon")
                createCategory(name: "Personal", icon: "personalIcon")
                createCategory(name: "Work", icon: "workIcon")
                createCategory(name: "Shopping", icon: "shoppingIcon")
                
            }
        } catch {
            print("Failed to fetch categories: \(error)")
        }
    }
    
    

}
    
