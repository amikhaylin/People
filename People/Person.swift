//
//  Person.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import Foundation

struct Person: Codable, Identifiable {
    struct Friend: Codable {
        let id: String
        let name: String
    }
    
    let id: String
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var formattedRegisteredDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: registered)
    }
}
