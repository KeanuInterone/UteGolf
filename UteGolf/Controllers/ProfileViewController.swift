//
//  ProfileViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/28/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var user: User? = nil
    var showingUser: Bool = false

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var utePointsLabel: UILabel!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    let eventCellID = "EventCellID"
    let eventHeaderID = "EventHeaderID"
    
    var eventTypes: [String] = []
    var events: [String: [Event]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If the user object was set we want to show that user
        if let showUser = user {
            nameLabel.text = showUser.FirstName + " " + showUser.LastName
            utePointsLabel.text = "Ute Points: " + String(showUser.UtePoints)
            showingUser = true
        }
        else {
            user = AppState.state.user
            nameLabel.text = user!.FirstName + " " + user!.LastName
            utePointsLabel.text = "Ute Points: " + String(user!.UtePoints)
        }
        
        profilePicView.contentMode = .scaleAspectFill
        profilePicView.layer.cornerRadius = 8
        profilePicView.clipsToBounds = true
        
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        // register event cell and header cell
        eventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: eventCellID)
        eventCollectionView.register(UINib(nibName: "EventHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: eventHeaderID)
        
        if(showingUser) {
            loadCompletedEvents()
        }
        else {
            loadEvents()
        }
        loadProfilePic(filename: String(user!.UserID) + ".jpg")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadEvents()
        utePointsLabel.text = "Ute Points: " + String(user!.UtePoints)
    }
    
    private func loadProfilePic(filename: String) {
        Alamofire.request("https://www.utahutegolf.com/images/profilepics/" + filename).responseData { response in
            let profilepic = UIImage(data: response.result.value!)
            self.profilePicView.image = profilepic
        }
    }
    
    
    
    // Loeads Events for uppcomming and Joined events
    private func loadEvents() {
        Event.GetUpcomingAndJoinedEventsWithUserID(UserID: user!.UserID) { (loadedEvents, message) in
            if loadedEvents != nil {
                self.eventTypes = Array(loadedEvents!.keys)
                self.events = loadedEvents!
                self.eventCollectionView.reloadData()
            }
            else {
                print(message)
            }
        }
    }
    
    private func loadCompletedEvents() {
        // this will get all of the completed events when showing a user
    }
    
    // Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventTypes.count
    }
    
    // Number of rows in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let eventType = eventTypes[section]
        return events[eventType]!.count
    }
    
    // Get the header for each section
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: eventHeaderID, for: indexPath) as! EventHeaderCollectionViewCell
        
        header.headerLabel.text = eventTypes[indexPath.section]
        
        return header
    }
    
    // Gets the event cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellID, for: indexPath) as! EventCollectionViewCell
        
        let eventType = eventTypes[indexPath.section]
        let event = events[eventType]![indexPath.row]
        
        eventCell.eventLabel.text = event.EventName
        
        return eventCell
    }
    
    // The size of the section header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    // The size of the event cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    // Event cell was selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventType = eventTypes[indexPath.section]
        let event = events[eventType]![indexPath.row]
        
        // we need to check here to see what state the event is in
        // from that we can present the correct 
        
        let eventVC = EventViewController(nibName: "EventViewController", bundle: nil)
        eventVC.event = event
        
        if(eventType == "Joined") {
            eventVC.hasJoined = true;
        }
        
        AppState.state.nav!.pushViewController(eventVC, animated: true)
    }
}
