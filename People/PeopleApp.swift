//
//  PeopleApp.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import SwiftUI
import CoreData

@main
struct PeopleApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, setupContext())
        }
    }
    
    func setupContext() -> NSManagedObjectContext {
        return persistenceController.container.viewContext
    }
}

extension CodingUserInfoKey {
  static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
