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
//        addTwosUsersUsingMultithreadingOnMainThread()
//        managedObjectAccessOnDifferentThreadsERROR()
//        deleteTaskFromCoreDataObjectOrientedWay()
//        fetchTaskFromCoreDataObejctOrientedWay()
//        fetchUserByNameUsingNSPredicte()
//        fetchUserByNameUsingSortDiscriptor()
//        fetchRequestWithDefaultType()
//        fetchRequestWithDictionaryType()
//        fetchRequestWithCountType()
//        fetchRequestWithIDType()
//        fetchRequestWithFaultObjects()
//        fetchRequestForPropertyUsingDictionaryResultType()
//        fetchRequestForPropertyUsingManagedObjectResultType()
//        fetchRequestWithLimit()
//        add10000Object()
//        fetchRequestUsingLimitBatchingAndOffset()
//        addTwoUsersAndFetchingOnDifferentThreadsShouldGiveERROR()
        
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
    
    
    
    
    func fetchRequestUsingLimitBatchingAndOffset(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        var offset = 0
        userFetchRequest.fetchOffset = offset
        userFetchRequest.fetchLimit = 1000
        
        do{
            
            var users = try managedContext.fetch(userFetchRequest)
            
            while users.count > 0{
                offset = offset + users.count
                userFetchRequest.fetchOffset = offset
                users = try managedContext.fetch(userFetchRequest)
                print(users.count)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    
    func fetchRequestWithLimit(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        userFetchRequest.fetchLimit = 1
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            for user in users{
                print(user)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    func fetchRequestForPropertyUsingManagedObjectResultType(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        userFetchRequest.propertiesToFetch = ["firstName"]
        userFetchRequest.resultType = .managedObjectResultType
        userFetchRequest.returnsObjectsAsFaults = true
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            print(users[0]) // it will return a faulty object
            print(users[0].firstName!) // access the object
            print(users[0]) // also it will return faulty objects
            print(users[0].secondName!) // once accessed a property that is not in propertiesToFetch it will load the whole object in memory once called
            print(users[0]) // it will load the whole object in memory
            
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    
    func fetchRequestForPropertyUsingDictionaryResultType(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<NSDictionary>.init(entityName: "User")
        
        
        userFetchRequest.propertiesToFetch = ["firstName"]
        userFetchRequest.resultType = .dictionaryResultType
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            for user in users{
                print(user)
            }
            
        }catch{
            
        }
    }
    
    
    
    
    func fetchRequestWithFaultObjects(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        userFetchRequest.returnsObjectsAsFaults = true
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            
            for user in users{
                print(user) // return a faulty objects
            }
            
            for user in users{
                let _ = user.firstName // once access the objects
            }
            
            for user in users{
                print(user) // it will load complete objects in memory
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
    
    func managedObjectAccessOnDifferentThreadsERROR(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let mainQueueContext = appDelegate?.persistentContainer.viewContext else {return}
        
        guard let privateQueueContext = appDelegate?.persistentContainer.newBackgroundContext() else {return}
        
        let user = User(context: mainQueueContext)
        user.firstName = "main queue"
        user.secondName = "main queue"
        user.userId = Int64(111)
        
        
        let task = Task(context: privateQueueContext)
        task.name = "task name"
        task.details = "task name description"
        task.id = 1
        
        user.tasks = NSSet.init(array: [task])
        
        do{
            try mainQueueContext.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    
    
    func addTwosUsersUsingMultithreadingOnMainThread(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        DispatchQueue.global(qos: .background).async {
            
            
            print("\(Thread.current)")
            
            
            managedContext.perform {
                print("\n\n\n\n")
                print(Thread.current)
                
                let user = User(context: managedContext)
                user.firstName = "user first name"
                user.secondName = "user first last name"
                user.userId = Int64(333)
                
                
                let secUser = User(context: managedContext)
                secUser.firstName = "user second name"
                secUser.secondName = "user second last name"
                secUser.userId = Int64(444)
                
                
                if managedContext.hasChanges{
                    do{
                        try managedContext.save()
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    
    
    func addTwoUsersAndFetchingOnDifferentThreadsShouldGiveERROR(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let userFetchRequest = NSFetchRequest<User>.init(entityName: "User")
        
        do{
            let users = try managedContext.fetch(userFetchRequest)
            for user in users {
                print(user)
            }
        }catch{
            print(error.localizedDescription)
        }
        
        
        // adding another users
        DispatchQueue.global(qos: .background).async {
            
            let user = User(context: managedContext)
            user.firstName = "user first name"
            user.secondName = "user first last name"
            user.userId = Int64(333)
            
            
            let secUser = User(context: managedContext)
            secUser.firstName = "user second name"
            secUser.secondName = "user second last name"
            secUser.userId = Int64(444)
            
            
            if managedContext.hasChanges{
                do{
                    try managedContext.save()
                }catch{
                    print(error.localizedDescription)
                }
            }
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
    
    
    func add10000Object(){
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        for i in 0..<10000{
            let user = User(context: managedContext)
            user.firstName = "Philip #\(i)"
            user.secondName = "Al-Twal #\(i)"
            user.userId = Int64(i)
        }
        
        if managedContext.hasChanges{
            do{
                try managedContext.save()
            }catch{
                print(error.localizedDescription)
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
