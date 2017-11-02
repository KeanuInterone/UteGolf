//
//  EventsCollectionViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/29/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class EventsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let eventCellID = "EventCellID"
    let eventHeaderID = "EventHeaderId"
    
    var eventTypes: [String] = []
    var events: [String: [Event]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: eventCellID)
        self.collectionView!.register(UINib(nibName: "EventHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: eventHeaderID)
        loadEvents()
    }
    
    // Loeads Events for uppcomming and Joined events
    private func loadEvents() {
        let user = AppState.state.user
        Event.GetAllEventsWithUserID(UserID: user!.UserID) { (loadedEvents, message) in
            if loadedEvents != nil {
                self.eventTypes = Array(loadedEvents!.keys)
                self.events = loadedEvents!
                self.collectionView!.reloadData()
            }
            else {
                print(message)
            }
        }
    }

    // Number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventTypes.count
    }

    // Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let eventType = eventTypes[section]
        return (events[eventType]?.count)!
    }

    // Gets gets the headers for the sections
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: eventHeaderID, for: indexPath) as! EventHeaderCollectionViewCell
        
        header.headerLabel.text = eventTypes[indexPath.section]
        
        return header
    }
    
    // Gets the event cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let eventCell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellID, for: indexPath) as! EventCollectionViewCell
        
        let eventType = eventTypes[indexPath.section]
        let event = events[eventType]![indexPath.row]
        
        eventCell.eventLabel.text = event.EventName
        
        return eventCell
    }
    
    // Gets the size for the headers
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    // Gets the size for the event cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    // Event cell was selected
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let eventType = eventTypes[indexPath.section]
        let event = events[eventType]![indexPath.row]
        
        let eventVC = EventViewController(nibName: "EventViewController", bundle: nil)
        eventVC.event = event
        
        AppState.state.nav.pushViewController(eventVC, animated: true)
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
