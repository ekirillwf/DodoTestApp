//
//  DBManager.swift
//  DodoTestApp
//
//  Created by Кирилл Елсуфьев on 04.03.2021.
//

import UIKit
import CoreData
import SwiftyJSON

class DBManager {
    
    private let container: NSPersistentContainer
    
    public let viewContext: NSManagedObjectContext
    public let backgroundContext: NSManagedObjectContext
    
    private init() {
        let container = NSPersistentContainer(name: "DodoTestApp")
        self.container = container
        self.viewContext = container.viewContext
        self.viewContext.automaticallyMergesChangesFromParent = true
        self.backgroundContext = container.newBackgroundContext()
    }
    
    func loadPersistentStores() {
        self.container.loadPersistentStores { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    static let shared = DBManager()
    
    func saveDish(json: [JSON]) {
        
        for item in json {
            
            let dishMO = DishMO(context: self.viewContext)
           
            dishMO.idCategory = item["idCategory"].int32Value
            dishMO.strCategory = item["strCategory"].stringValue
            dishMO.strCategoryThumb = item["strCategoryThumb"].stringValue
            dishMO.strCategoryDescription = item["strCategoryDescription"].stringValue

        }
        
        saveMainContext()
        
    }
    
    func showEntities<T: NSManagedObject>(entityName: T.Type, predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil, in context: NSManagedObjectContext? = nil) -> [T]? {
        
        let ctx = context == nil ? self.viewContext : context!
        
        var entities: [T]?
        
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityName))
        
        if let sortDescriptors = sortDescriptors {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        do {
            entities = try ctx.fetch(fetchRequest) //as? [T]
        } catch {
            print("Storage reading error!")
        }
        
        return entities
        
    }
    
    func clearEntitiesFromMemoryAndDB<T: NSManagedObject>(entityName: T.Type, predicate: NSPredicate? = nil) {
        
        if let entities = self.showEntities(entityName: entityName, predicate: predicate) {
            entities.forEach { self.clearEntity(entity: $0, isSaveRightNow: false) }
            saveMainContext()
        }
        
    }
    
    func clearEntities<T: NSManagedObject>(entityName: T.Type, predicate: NSPredicate? = nil) {
        
        let context = self.viewContext
        
        let fetchRequest = entityName.fetchRequest()
        fetchRequest.predicate = predicate
        
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Storage reading error!")
        }
        
    }
    
    func clearEntity(entity: NSManagedObject, isSaveRightNow: Bool = true) {
        
        let context = self.viewContext
        
        context.delete(entity)
        
        if isSaveRightNow {
            saveMainContext()
        }
        
    }
    
    
    func saveContext(context: NSManagedObjectContext) {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
    }
    
    func saveMainContext() {
        
        let context = self.viewContext
        
        saveContext(context: context)
    }
    
    func findOne<T: NSManagedObject>(entityName: T.Type, context: NSManagedObjectContext? = nil, predicate: NSPredicate) -> T? {
        
        let ctx = context == nil ? self.viewContext : context!
        
        let fetchRequest = NSFetchRequest<T>(entityName: String(describing: entityName))
        fetchRequest.predicate = predicate
        fetchRequest.fetchLimit = 1
        
        do {
            return try ctx.fetch(fetchRequest).last
        } catch {
            print("Storage reading error!")
            return nil
        }
        
    }
    
}

