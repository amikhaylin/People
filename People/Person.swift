//
//  Person.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import Foundation
import CoreData

// TODO: Clean this
//struct PersonZ: Codable, Identifiable {
//    struct Friend: Codable {
//        let id: String
//        let name: String
//    }
//
//    let id: String
//    let name: String
//    let age: Int
//    let company: String
//    let email: String
//    let address: String
//    let about: String
//    let registered: Date
//    let tags: [String]
//    let friends: [Friend]
//
//    var formattedRegisteredDate: String {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        return formatter.string(from: registered)
//    }
//}

enum DecoderConfigurationError: Error {
  case missingManagedObjectContext
}

@objc(Person)
public class Person: NSManagedObject, Identifiable, Codable {
    struct FriendZ: Codable {
            let id: String
            let name: String
    }
        
    enum CodingKeys: CodingKey {
        case id, name, age, company, email, address, about, registered, tags, friends
    }
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: [String]?
    @NSManaged public var friends: NSSet?
    
    public var friendsArray: [Friend] {
        let set = friends as? Set<Friend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    var formattedRegisteredDate: String {
        if let date = registered {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: date)
        } else {
            return "N/A"
        }
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.managedObjectContext] as? NSManagedObjectContext else {
            throw  DecoderConfigurationError.missingManagedObjectContext
        }

        self.init(context: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        about = try container.decode(String.self, forKey: .about)
        registered = try container.decode(Date.self, forKey: .registered)
        tags = try container.decode([String].self, forKey: .tags)
        let friendz: [FriendZ]
        friendz = try container.decode([FriendZ].self, forKey: .friends)

        for item in friendz {
            let friend = Friend(context: context)
            friend.id = item.id
            friend.name = item.name
            
            addToFriends(friend)
        }
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}

// MARK: Generated accessors for friends
extension Person {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: Friend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: Friend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}



