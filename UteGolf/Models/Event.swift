//
//  Event.swift
//  UteGolf
//
//  Created by Keanu Interone on 11/1/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import Foundation
import Alamofire

class Event {
    
    public var EventID : Int
    public var IsOpen: Bool
    public var EventName : String
    public var EntryFee : Double
    
    init(EventID: Int, IsOpen: Bool, EventName: String, EntryFee: Double) {
        self.EventID = EventID
        self.IsOpen = IsOpen
        self.EventName = EventName
        self.EntryFee = EntryFee
    }
    
    public static func GetUpcomingAndJoinedEventsWithUserID(UserID: Int, completion: @escaping ([String: [Event]]?, String) -> ()) {
        
        let parameters: Parameters = [
            "userid": UserID,
            "upcomingandjoined": "true"
        ]
        
        Alamofire.request("https://www.utahutegolf.com/events/", method: .get, parameters: parameters).responseJSON { response in
            
            if(response.result.isSuccess) {
                if let result = response.result.value {
                    let json = result as! [[String: String?]]
                    
                    var events: [String: [Event]] = ["Joined": [], "Upcomming": []]
                    for eventJson in json {
                        // pull out event data
                        let eventID:Int = Int(eventJson["EventID"]!!)!
                        let isOpenInt = Int(eventJson["IsOpen"]!!)
                        var isOpen = false
                        if isOpenInt == 1 {
                            isOpen = true
                        }
                        let eventName: String = eventJson["EventName"]!!
                        let entryFee: Double = Double(eventJson["EntryFee"]!!)!
                        
                        // create event object
                        let event = Event(EventID: eventID, IsOpen: isOpen, EventName: eventName, EntryFee: entryFee)
                        
                        // if userid is present then put into Joined section
                        if eventJson["HasCompleted"]! != nil {
                            events["Joined"]!.append(event)
                        }
                        else {
                            events["Upcomming"]!.append(event)
                        }
                    }
                    completion(events, "Success")
                }
                else {
                    completion(nil, "No events")
                }
            }
            else {
                completion(nil, (response.result.error?.localizedDescription)!)
            }
        }
    }
    
    public static func GetAllEventsWithUserID(UserID: Int, completion: @escaping ([String: [Event]]?, String) -> ()) {
        
        let parameters: Parameters = [
            "userid": UserID,
            "allevents": "true"
        ]
        
        Alamofire.request("https://www.utahutegolf.com/events/", method: .get, parameters: parameters).responseJSON { response in
            
            if(response.result.isSuccess) {
                if let result = response.result.value {
                    let json = result as! [[String: String?]]
                    
                    var events: [String: [Event]] = ["Joined": [], "Upcomming": [], "Past": []]
                    for eventJson in json {
                        // pull out event data
                        let eventID:Int = Int(eventJson["EventID"]!!)!
                        let isOpenInt = Int(eventJson["IsOpen"]!!)
                        var isOpen = false
                        if isOpenInt == 1 {
                            isOpen = true
                        }
                        let eventName: String = eventJson["EventName"]!!
                        let entryFee: Double = Double(eventJson["EntryFee"]!!)!
                        
                        // create event object
                        let event = Event(EventID: eventID, IsOpen: isOpen, EventName: eventName, EntryFee: entryFee)
                        
                        // if hascompleted is present then put into Joined section
                        if eventJson["HasCompleted"]! != nil {
                            let hasCompletedInt: Int = Int(eventJson["HasCompleted"]!!)!
                            var hasCompleted = false
                            if hasCompletedInt == 1 {
                                hasCompleted = true
                            }
                            if(hasCompleted) {
                                events["Past"]!.append(event)
                            }
                            else {
                                events["Joined"]!.append(event)
                            }
                        }
                        else {
                            if(event.IsOpen) {
                                events["Upcomming"]!.append(event)
                            }
                            else {
                                events["Past"]!.append(event)
                            }
                        }
                    }
                    completion(events, "Success")
                }
                else {
                    completion(nil, "No events")
                }
            }
            else {
                completion(nil, (response.result.error?.localizedDescription)!)
            }
        }
    }
    
    public static func GetCompletedEventsWithUserID(UserID: Int, completion: @escaping ([Event]?, String) -> ()) {
        
        let parameters: Parameters = [
            "userid": UserID,
            "completed": "true"
        ]
        
        Alamofire.request("https://www.utahutegolf.com/events/", method: .get, parameters: parameters).responseJSON { response in
            
            if(response.result.isSuccess) {
                if let result = response.result.value {
                    let json = result as! [[String: String?]]
                    
                    var events: [Event] = [];
                    for eventJson in json {
                        // pull out event data
                        let eventID:Int = Int(eventJson["EventID"]!!)!
                        let isOpenInt = Int(eventJson["IsOpen"]!!)
                        var isOpen = false
                        if isOpenInt == 1 {
                            isOpen = true
                        }
                        let eventName: String = eventJson["EventName"]!!
                        let entryFee: Double = Double(eventJson["EntryFee"]!!)!
                        
                        // create event object
                        let event = Event(EventID: eventID, IsOpen: isOpen, EventName: eventName, EntryFee: entryFee)
                        events.append(event)
                    }
                    completion(events, "Success")
                }
                else {
                    completion(nil, "No events")
                }
            }
            else {
                completion(nil, (response.result.error?.localizedDescription)!)
            }
        }
    }
    
    public static func joinEvent(userID: Int, eventID: Int, completion: @escaping (Bool) -> ()) {
        
        let parameters: Parameters = [
            "userid": userID,
            "eventid": eventID
        ]
        
        Alamofire.request("https://www.utahutegolf.com/events/", method: .post, parameters: parameters).responseString { (message) in
            if(message.result.value == "Success") {
                completion(true)
            }
            else {
                completion(false)
            }
        }
        
    }
}
