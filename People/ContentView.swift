//
//  ContentView.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State var persons: [Person]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(persons) { person in
                        NavigationLink(
                            destination: PersonView(person: person)) {
                            ZStack(alignment: .leading) {
                                Color.orange
                                    .cornerRadius(5.0)
                                HStack {
                                    Image(systemName: "person.crop.circle")
                                        .font(.largeTitle)
                                        
                                    VStack(alignment: .leading) {
                                        Text(person.name)
                                            .font(.title3)
                                        Text(person.company)
                                            .font(.caption)
                                    }
                                }
                                .foregroundColor(.white)
                                .padding()
                            }
                            .padding(EdgeInsets(top: 6, leading: 15, bottom: 9, trailing: 15))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationBarTitle("People")
            .onAppear(perform: {
                NetworkService().loadPersons { (persons) in
                    self.persons = persons
                }
            })
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(persons: [Person(id: UUID().uuidString, name: "John Doe", age: 99, company: "ACME", email: "some@email.com", address: "HOBO", about: "Unknown", registered: Date(), tags: ["tag"], friends: []),
                              Person(id: UUID().uuidString, name: "Jeine Doe", age: 99, company: "ACME", email: "some@email.com", address: "HOBO", about: "Unknown", registered: Date(), tags: ["tag"], friends: [])])
    }
}
