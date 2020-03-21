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
        addTodoTaskObjectOrientedWay()
        deleteTaskFromCoreDataObjectOrientedWay()
        fetchTaskFromCoreDataObejctOrientedWay()
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
    
    
    
    func fetchTaskFromCoreDataObejctOrientedWay(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        let passportFetchRequest = NSFetchRequest<Passport>.init(entityName: "Passport")
        let taskFetchRequest = NSFetchRequest<Task>.init(entityName: "Task")
        do{
            let users = try managedContext.fetch(userFetchRequest) as [NSManagedObject]
            let passports = try managedContext.fetch(passportFetchRequest) as [NSManagedObject]
            let tasks = try managedContext.fetch(taskFetchRequest) as [NSManagedObject]
            
            for user in users{
                print(user.value(forKey: "firstName") as! String)
            }
            for pass in passports{
                print(pass.value(forKey: "number") as! String)
            }
            for task in tasks{
                print(task.value(forKey: "details") as! String)
            }
        }catch{
            print(error.localizedDescription)
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
        
        
        let userPassport = Passport(context: managedContext)
        userPassport.expiryDate = NSDate() as Date
        userPassport.number = "User Passport Number two"
        
        let user = User(context: managedContext)
        user.firstName = "Fadi"
        user.secondName = "Al-Twal"
        user.userId = 123
        user.tasks = NSSet.init(array: [taskOne,taskSecond])
        user.passport = userPassport
        
        
        if managedContext.hasChanges{
            do{
                try managedContext.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }

}
