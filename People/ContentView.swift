//
//  ContentView.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Person.entity(), sortDescriptors: []) var persons: FetchedResults<Person>
    
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
                                        Text(person.name ?? "Unknown")
                                            .font(.title3)
                                        Text(person.company ?? "Unknown")
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
            .navigationBarItems(trailing: Button(action: {
                NetworkService().loadPersons(context: viewContext) { (persons) in
//                    self.persons = persons
                }
            }, label: {
                Image(systemName: "arrow.triangle.2.circlepath")
            }))
            .onAppear(perform: {
                //TODO: Here will be loading from core data
            })
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
