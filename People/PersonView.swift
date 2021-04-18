//
//  PersonView.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import SwiftUI
import CoreData

struct PersonView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let person: Person
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10.0) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text(person.name ?? "Unknown")
                    .font(.title)
                
                Text(person.company ?? "Unknown")
                    .font(.callout)
                
                Text(person.email ?? "N/A")
                
                Text(person.address ?? "N/A")
                
                Text(person.about ?? "N/A")
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                
          
                Text("Registered: \(person.formattedRegisteredDate)")
                    .font(.footnote)
                
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                ForEach(person.friendsArray, id: \.id ) { friend in
                    NavigationLink(
                        destination: PersonView(person: getFriend(with: friend.wrappedId))) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                                
                            VStack(alignment: .leading) {
                                Text(friend.wrappedName)
                                    .font(.title3)
                            }
                        }
                    }
                }
                
                
                TagsView(tags: person.wrappedTags)
            }
        }
        .navigationBarTitle("Person", displayMode: .inline)
    }
    
    func getFriend(with id: String) -> Person {
        let fetchRequest = NSFetchRequest<Person>(entityName: "Person")
        let predicate = NSPredicate(format: "id == %@", id)
        fetchRequest.predicate = predicate
        let persons: [Person]
        do {
            persons = try viewContext.fetch(fetchRequest)
        } catch {
            fatalError("Fetch faults \(error.localizedDescription)")
        }
        
        if let friend = persons.first(where: { $0.id == id }) {
            return friend
        } else {
            fatalError("Friend does not exist")
        }
    }
}

struct PersonView_Previews: PreviewProvider {
    let person: Person = {
        let person = Person()
        person.id = UUID().uuidString
        person.name = "John Doe"
        person.age = 99
        person.company = "ACME"
        person.email = "some@email.com"
        person.address = "HOBO"
        person.about = "Unknown"
        person.registered = Date()
        person.tags = ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"]
        
        return person
    }()
    
    static var previews: some View {
        PersonView(person: Person())
        
    }
}
