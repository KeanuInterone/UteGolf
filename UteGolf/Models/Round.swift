//
//  Round.swift
//  UteGolf
//
//  Created by Keanu Interone on 11/2/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import Foundation
import Alamofire

class Round {
    
    //RoundID, EventID, RoundName, RoundDate, Location
    var RoundID: Int
    var EventID: Int
    var RoundName: String
    var RoundDate: String
    var Location: String
    
    var ScoreID: Int? = nil
    var Score: Int? = nil
    
    init(RoundID: Int, EventID: Int, RoundName: String, RoundDate: String, Location: String) {
        self.RoundID = RoundID
        self.EventID = EventID
        self.RoundName = RoundName
        self.RoundDate = RoundDate
        self.Location = Location
    }
    
    public static func GetRoundsWithEventID(EventID: Int, UserID: Int, completion: @escaping ([Round]?, String) -> ()) {
        
        let parameters: Parameters = [
            "eventid": EventID,
            "userid": UserID
        ]
        
        Alamofire.request("https://www.utahutegolf.com/rounds/", method: .get, parameters: parameters).responseJSON { response in
            
            if(response.result.isSuccess) {
                if let result = response.result.value, let json = result as? [[String: String?]]{
                    var rounds: [Round] = []
                    for roundJson in json {
                        //r.RoundID, r.EventID, r.RoundName, r.RoundDate, r.Location, s.ScoreID, s.Score
                        // pull out event data
                        let roundID:Int = Int(roundJson["RoundID"]!!)!
                        let eventID:Int = Int(roundJson["EventID"]!!)!
                        let roundName:String = roundJson["RoundName"]!!
                        let roundDate:String = roundJson["RoundDate"]!!
                        let location:String = roundJson["Location"]!!
                        
                        // create round object
                        let round = Round(RoundID: roundID, EventID: eventID, RoundName: roundName, RoundDate: roundDate, Location: location)
                        
                        if let scoreIDString = roundJson["ScoreID"]!, let scoreString = roundJson["Score"]! {
                            round.ScoreID = Int(scoreIDString)
                            round.Score = Int(scoreString)
                        }
                        
                        rounds.append(round)
                    }
                    completion(rounds, "Success")
                }
                else {
                    completion(nil, "No rounds")
                }
            }
            else {
                completion(nil, (response.result.error?.localizedDescription)!)
            }
        }
    }
}

