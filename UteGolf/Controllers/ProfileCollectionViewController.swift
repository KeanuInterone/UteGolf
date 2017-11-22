//
//  ProfileCollectionViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 11/21/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProfileCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: cell ids
    let eventCellID = "EventCellID"
    let eventHeaderID = "EventHeaderID"
    let profileHeaderID = "ProfileHeaderID"
    
    // MARK: Event sections and event headers
    var eventTypes: [String] = []
    var events: [String: [Event]] = [:]
    
    // MARK: User object
    var user: User?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        user = AppState.state.user!
        
        // Set layout delegate to self
        collectionView?.delegate = self
        
        // Register cell classes
        // Profile header cell
        collectionView?.register(UINib(nibName: "ProfileHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: profileHeaderID)
        // Event cell
        collectionView!.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: eventCellID)
        // Event cell header
        collectionView!.register(UINib(nibName: "EventHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: eventHeaderID)
        loadEvents()

    }

    // MARK: Loads Events for uppcomming and Joined events
    // Loads Events for uppcomming and Joined events
    private func loadEvents() {
        Event.GetUpcomingAndJoinedEventsWithUserID(UserID: user!.UserID) { (loadedEvents, message) in
            if loadedEvents != nil {
                self.eventTypes = Array(loadedEvents!.keys)
                self.events = loadedEvents!
                self.collectionView?.reloadData()
            }
            else {
                print(message)
            }
        }
    }
    
    
    // Number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventTypes.count + 1 // Plus 1 if for the profile header
    }
    
    
    // Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // For section 0, return 0, because its just the header cell
        let index = section - 1
        if(index == -1) {
            return 0;
        }
        let eventType = eventTypes[index]
        return (events[eventType]?.count)!
    }
    
    
    // Gets gets the headers for the sections
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if(indexPath.section == 0) {
            let profileHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: profileHeaderID, for: indexPath) as! ProfileHeaderCollectionViewCell
            
            profileHeader.nameLabel.text = user!.FirstName + " " + user!.LastName
            profileHeader.pointsLabel.text = "Points: " + String(user!.UtePoints)
            User.loadProfilePicture(UserID: user!.UserID, completion: { (data) in
                let profileImage = UIImage(data: data)
                profileHeader.profileImageView.image = profileImage
            })
            return profileHeader
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: eventHeaderID, for: indexPath) as! EventHeaderCollectionViewCell
        
        header.headerLabel.text = eventTypes[indexPath.section - 1]
        
        return header
    }
    
    
    // Gets the event cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellID, for: indexPath) as! EventCollectionViewCell
        
        let eventType = eventTypes[indexPath.section - 1]
        let event = events[eventType]![indexPath.row]
        
        eventCell.eventLabel.text = event.EventName
        eventCell.eventImageView.image = #imageLiteral(resourceName: "GolfCourse")
        
        return eventCell
    }
    
    
    // Gets the size for the headers
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if(section == 0) {
            return CGSize(width: collectionView.frame.width, height: 150)
        }
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    // Gets the size for the event cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    // Event cell was selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventType = eventTypes[indexPath.section - 1]
        let event = events[eventType]![indexPath.row]
        
        let eventVC = EventViewController(nibName: "EventViewController", bundle: nil)
        eventVC.event = event
        
        if(eventType == "Past" || eventType == "Joined") {
            eventVC.hasJoined = true
        }
        
        
        AppState.state.nav!.pushViewController(eventVC, animated: true)
    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
