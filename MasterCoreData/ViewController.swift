//
//  ViewController.swift
//  MasterCoreData
//
//  Created by Philip Twal on 3/21/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        addTodoTaskObjectOrientedWay()
//        addOneTodoTask()
//        deleteTaskFromCoreDataObjectOrientedWay()
//        fetchTaskFromCoreDataObejctOrientedWay()
//        fetchUserByNameUsingNSPredicte()
//        fetchUserByNameUsingSortDiscriptor()
//        fetchRequestWithDefaultType()
//        fetchRequestWithDictionaryType()
//        fetchRequestWithCountType()
        fetchRequestWithIDType()
    }
    
    func deleteTaskFromCoreDataObjectOrientedWay(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<User>.init(entityName: "User")
                
        do{
            let data = try managedContext.fetch(fetchRequest) as [NSManagedObject]
            
            for item in data{
                
                managedContext.delete(item)
            }
          
            do{
                try managedContext.save()
                print("Deleted")
            }catch{
                print(error.localizedDescription)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchRequestWithIDType(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<NSManagedObjectID>.init(entityName: "User")
        
        userFetchRequest.resultType = .managedObjectIDResultType
        
        do{
            
            let objectIDs = try managedContext.fetch(userFetchRequest)
            
            for id in objectIDs{
                print(id)
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func fetchRequestWithCountType(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<NSNumber>.init(entityName: "User")
        
        userFetchRequest.resultType = .countResultType
        
        do{
            let userCount = try managedContext.fetch(userFetchRequest)
            
            for count in userCount{
                print(count)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    func fetchRequestWithDictionaryType(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<NSDictionary>.init(entityName: "User")
        
        let sortByFirstName = NSSortDescriptor(key: "firstName", ascending: true)
        
        userFetchRequest.resultType = .dictionaryResultType
        
        userFetchRequest.sortDescriptors = [sortByFirstName]
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            for user in users{
                print(user)
                print("Name : \(user["firstName"]!) \(user["secondName"]!)")
            }
        }catch{
            
        }
        
    }
    
    
    
    func fetchRequestWithDefaultType(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        userFetchRequest.resultType = .managedObjectResultType
        
        userFetchRequest.returnsObjectsAsFaults = false
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            for user in users{
                print(user)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    func fetchUserByNameUsingSortDiscriptor(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        let sortByFirstName = NSSortDescriptor(key: "firstName", ascending: false)
        
        userFetchRequest.sortDescriptors = [sortByFirstName]
        do{
            let users = try managedContext.fetch(userFetchRequest)
            for user in users {
                print(user.firstName! as String)
            }
        }catch{
            
        }
    }
    
    
    func fetchUserByNameUsingNSPredicte(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        userFetchRequest.predicate = NSPredicate.init(format: "firstName == %@", "Philip")
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            for item in users {
                print(item.firstName! as String)
            }
        }catch{
            print(error)
        }
        
    }
    
    
    func fetchTaskFromCoreDataObejctOrientedWay(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            
            for user in users{
                print(user.value(forKey: "firstName") as! String)
                print(user.passport?.number ?? "NO Passport number")
                print(user.tasks?.value(forKey: "details") ?? "NO TASKS WAS MADE")
               
            }
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    func addOneTodoTask(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let task = Task(context: managedContext)
        
        task.name = "Deny Task"
        task.details = "Deny Description"
        task.id = 99
        
        
        let user = User(context: managedContext)
        user.firstName = "Omar from Jordan"
        user.secondName = "Jaradat"
        user.userId = 000
        
        user.tasks = NSSet.init(array: [task])
        
        
        if managedContext.hasChanges{
            do{
                try managedContext.save()
                print("Saved")
            }catch{
                print(error)
            }
        }
    }
    
    
    
    func addTodoTaskObjectOrientedWay(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
    
        let taskOne = Task(context: managedContext)
        taskOne.name = "First Item"
        taskOne.details = "First Item Description"
        taskOne.id = 1
        
        let taskSecond = Task(context: managedContext)
        taskSecond.name = "Second Item"
        taskSecond.details = "Second Item Description"
        taskSecond.id = 2
        
        let taskThird = Task(context: managedContext)
        taskThird.name = "Third Item"
        taskThird.details = "Third Item Description"
        taskThird.id = 3
        
        let userPassport = Passport(context: managedContext)
        userPassport.expiryDate = NSDate() as Date
        userPassport.number = "User Passport Number"
        
        let user = User(context: managedContext)
        user.firstName = "Philip"
        user.secondName = "Al-Twal"
        user.userId = 123
        user.tasks = NSSet.init(array: [taskOne,taskSecond,taskThird])
        user.passport = userPassport
        
        
        if managedContext.hasChanges{
            do{
                try managedContext.save()
                print("Saved")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
}
