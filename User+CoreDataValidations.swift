//
//  User+CoreDataValidations.swift
//  MasterCoreData
//
//  Created by Philip Twal on 3/24/20.
//  Copyright © 2020 Philip Altwal. All rights reserved.
//

import Foundation
import CoreData

extension User {
    
    
    var errorDomain : String {
        
        get {
            return "UserErrorDomain"
        }
        
    }
    
    enum UserErrorType: Int {
        case InvalidUserSecondName
        case InvalidUserFirstOrSecondName
    }
    
    
    override public func validateForInsert() throws {
        try super.validateForInsert()
        
        guard let firstName = firstName else {throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [NSLocalizedDescriptionKey: "The user first or second name cannot nil. "])}
        
        guard let secondName = secondName else {throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [NSLocalizedDescriptionKey : "The user first or second name cannot be nil. "])}
        
        if firstName.count > 12 || secondName.count > 12 {
            throw NSError(domain: errorDomain, code: UserErrorType.InvalidUserFirstOrSecondName.rawValue, userInfo: [NSLocalizedDescriptionKey : "The user first or second name cannot be more than 12 characters. "])
        }
    }
    
    
    public override func validateValue(_ value: AutoreleasingUnsafeMutablePointer<AnyObject?>, forKey key: String) throws {
        
        if key == "secondName"{
            
            var error: NSError? = nil;
            
            if let first = value.pointee as? String{
                if first == "" {
                    let errorType = UserErrorType.InvalidUserSecondName
                    error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [ NSLocalizedDescriptionKey : "The user second name cannot be empty. "] )
                }else if first.count > 12 {
                    let errorType = UserErrorType.InvalidUserSecondName
                    error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey: "The user second name cannot be more than 12 characters. "])
                }
            }else{
                let errorType = UserErrorType.InvalidUserSecondName
                error = NSError(domain: errorDomain, code: errorType.rawValue, userInfo: [NSLocalizedDescriptionKey: "The user second name cannot be nil. "])
            }
            
            if let error = error{
                throw error
            }
        }
    }
    
}
