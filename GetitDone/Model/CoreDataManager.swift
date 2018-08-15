//
//  CoreDataManager.swift
//  GetitDone
//
//  Created by Alper on 14.08.2018.
//  Copyright © 2018 Alper. All rights reserved.
//

import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "GetitDone")
        container.loadPersistentStores(completionHandler: { (store, error) in
            if let error = error {
                fatalError("Loading of store failed: \(error)")
            }
        })
        
        return container
    }()
    
    func createToDo(id: Double,title: String,status: Bool){
        
        let context = persistentContainer.viewContext
        
        let toDo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: context)
        
        
        toDo.setValue(id, forKey: "id")
        toDo.setValue(title, forKey: "title")
        toDo.setValue(status, forKey: "status")
        
        do {
            try context.save()
        } catch let err {
            print("Failed to save context with new toDo: \(err)")
        }
    }
    func deleteToDo(id: Double) {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        do {
            
            let toDos = try context.fetch(fetchRequest)
            toDos.forEach { (fetchToDo) in
                if fetchToDo.id == id {
                    context.delete(fetchToDo)
                }
            }
        } catch let err {
            print("Failed to fetch or delete todo from context: \(err)")
            
        }
        
    }
    func fetchToDos() -> [ToDo] {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        do {
            
            let toDos = try context.fetch(fetchRequest)
            
            return toDos
        } catch let err {
            print("Failed to fetch context from context: \(err)")
            return []
        }
    }
    
    func fetchTodo(title: String) -> ToDo? {
        
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<ToDo>(entityName: "ToDo")
        
        var toDo: ToDo?
        
        do{
            let toDos = try context.fetch(fetchRequest)
            toDos.forEach { (fetchToDo) in
                if fetchToDo.title == title {
                    toDo = fetchToDo
                }
            }
        } catch let err {
            print("Failed to fetch todo to update \(err)")
        }
        
        return toDo
    }
    
    
    
    
}
