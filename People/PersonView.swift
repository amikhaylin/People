//
//  PersonView.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import SwiftUI

struct PersonView: View {
    let person: Person
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10.0) {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text(person.name)
                    .font(.title)
                
                Text(person.company)
                    .font(.callout)
                
                Text(person.email)
                
                Text(person.address)
                
                Text(person.about)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                
          
                Text("Registered: \(person.formattedRegisteredDate)")
                    .font(.footnote)
                
                
                Spacer()
            }
            
            VStack(alignment: .leading) {
                ForEach(person.friends, id: \.id ) { friend in
                    HStack {
                        Image(systemName: "person.crop.circle")
                            .font(.largeTitle)
                            
                        VStack(alignment: .leading) {
                            Text(friend.name)
                                .font(.title3)
                        }
                    }
                }
                
                
                TagsView(tags: person.tags)
            }
        }
        .navigationBarTitle("Person", displayMode: .inline)
    }
    
    
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person(id: UUID().uuidString, name: "John Doe", age: 99, company: "ACME", email: "some@email.com", address: "HOBO", about: "Unknown", registered: Date(),
                                  tags: ["cillum", "consequat", "deserunt", "nostrud", "eiusmod", "minim", "tempor"], friends: []))
    }
}
