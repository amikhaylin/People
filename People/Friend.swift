//
//  Friend.swift
//  People
//
//  Created by Andrey Mikhaylin on 17.04.2021.
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Identifiable {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var person: Person?

    var wrappedName: String {
        name ?? "Unknown"
    }
    
    var wrappedId: String {
        id ?? UUID().uuidString
    }
}
