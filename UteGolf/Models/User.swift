//
//  User.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/23/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import Foundation
import Alamofire

class User {
    
    public var UserID : Int
    public var FirstName : String
    public var LastName : String
    public var IsAdmin : String
    public var Login : String
    public var UtePoints : Double
    
    init(UserID: Int, FirstName: String, LastName: String, IsAdmin : String, Login : String, UtePoints : Double) {
        self.UserID = UserID
        self.FirstName = FirstName
        self.LastName = LastName
        self.IsAdmin = IsAdmin
        self.Login = Login
        self.UtePoints = UtePoints
    }
    
    public static func Login(Username: String, Password: String, completion: @escaping (User?, String) -> ()) {
        
        let parameters: Parameters = [
            "username": Username,
            "password": Password
        ]
        
        // All three of these calls are equivalent
        Alamofire.request("https://www.utahutegolf.com/Users/", method: .post, parameters: parameters).responseJSON { response in
            
            if(response.result.isSuccess) {
                if let json = response.result.value as? [String: String] {
                    
                    let userID = Int(json["UserID"]!)
                    let firstName = json["FirstName"]!
                    let lastName = json["LastName"]!
                    let isAdmin = json["IsAdmin"]!
                    let login = json["Login"]!
                    let utePoints = Double(json["UtePoints"]!)
                    
                    let user = User(UserID: userID!, FirstName: firstName, LastName: lastName, IsAdmin: isAdmin, Login: login, UtePoints: utePoints!)
                    
                    completion(user, "Success")
                }
                else {
                    completion(nil, "Username or password was incorrect")
                }
            }
            else {
                completion(nil, (response.result.error?.localizedDescription)!)
            }
            
        }
    }
    
}