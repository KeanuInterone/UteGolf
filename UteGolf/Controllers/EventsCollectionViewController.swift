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
    
    let eventTypes: [String] = ["Upcomming", "Joined", "Completed"]
    let events: [String: [String]] = ["Upcomming": ["practice", "provo invite", "utah champs"], "Joined": ["practice 2", "chicago cup"], "Completed": ["Provo Invite", "World series", "Supper Bowl"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        self.collectionView!.backgroundColor = .white
        // Register cell classes
        self.collectionView!.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: eventCellID)
        self.collectionView!.register(UINib(nibName: "EventHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: eventHeaderID)
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventTypes.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let eventType = eventTypes[section]
        return (events[eventType]?.count)!
    }

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: eventHeaderID, for: indexPath) as! EventHeaderCollectionViewCell
        
        header.headerLabel.text = eventTypes[indexPath.section]
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: eventCellID, for: indexPath) as! EventCollectionViewCell
    
        let eventType = eventTypes[indexPath.section]
        let eventName = events[eventType]![indexPath.row]
        cell.eventLabel.text = eventName
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
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
