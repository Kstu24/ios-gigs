//
//  GigController.swift
//  Gig
//
//  Created by Kevin Stewart on 1/21/20.
//  Copyright © 2020 Kevin Stewart. All rights reserved.
//

import Foundation

class GigController {
    
    var bearer: Bearer?
    var baseURL: URL = URL(string: "https://github.com/LambdaSchool/ios-gigs/blob/master/APIDocumentation.md")!
    
    
    enum HTTPMethod: String {
           case get = "GET"
           case put = "PUT"
           case post = "POST"
           case delete = "DELETE"
       }
    
    // MARK: - Sign Up
    func signUp(with user: User, completion: @escaping (Error?) -> Void) {
        let signUpURL = baseURL.appendingPathComponent("user/signUp")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error in coding the user objection: \(error)")
            completion(error)
            return
        }
        
        
    URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse,
            response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
            
            completion(nil)
            
        }.resume()
        
        
    }
    
    // MARK: - Log In
    func logIn(with user: User, completion: @escaping (Error?) -> Void) {
        let logInURL = baseURL.appendingPathComponent("user/signUp")
        
        var request = URLRequest(url: logInURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(user)
            request.httpBody = jsonData
        } catch {
            print("Error in coding the user objection: \(error)")
            completion(error)
            return
        }
        
        
    URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse,
            response.statusCode != 200 {
                completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                return
            }
            
            if let error = error {
                completion(error)
                return
            }
     
             guard let data = data else {
                 completion(NSError())
                 return
             }
     
             let decoder = JSONDecoder()
     do {
         self.bearer = try decoder.decode(Bearer.self, from: data)
     } catch {
         print("Error decoding object: \(error)")
         completion(error)
         return
     }
            completion(nil)
            
        }.resume()
        
        
    }
}
