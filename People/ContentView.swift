//
//  ContentView.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var persons: [Person] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(persons) { person in
                        NavigationLink(
                            destination: Text("\(person.about)")) {
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
                            .padding(EdgeInsets(top: 7, leading: 15, bottom: 7, trailing: 15))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationBarTitle("People")
            .onAppear(perform: loadData)
            
        }
        
    }
    
    func loadData() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription)")
                return
            }
            
            //print("\(String(decoding: data, as: UTF8.self))")

            do {
                let formatter = DateFormatter()
                
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
                formatter.calendar = Calendar(identifier: .iso8601)
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                let decodedData = try decoder.decode([Person].self, from: data)
                persons = decodedData
            } catch {
                print("Decode error \(error.localizedDescription)")
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
