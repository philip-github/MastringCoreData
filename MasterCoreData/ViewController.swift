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
//        deleteTaskFromCoreDataObjectOrientedWay()
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
        user.firstName = "Philip"
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
