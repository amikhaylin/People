//
//  NetworkService.swift
//  People
//
//  Created by Andrey Mikhaylin on 16.04.2021.
//

import Foundation
import CoreData

struct NetworkService {
    func loadPersons(context: NSManagedObjectContext, completion: @escaping ([Person]) -> ()) {
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
                decoder.userInfo[CodingUserInfoKey.managedObjectContext] = context
                let decodedData = try decoder.decode([Person].self, from: data)
                
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print("Decode error \(error.localizedDescription)")
            }
        }.resume()
    }
}
