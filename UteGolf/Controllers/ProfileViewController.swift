//
//  ProfileViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/28/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profilePicView: UIImageView!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    
    let eventCellID = "EventCell"
    let eventHeaderID = "EventHeader"
    
    let eventTypes: [String] = ["Upcomming", "Joined"]
    let events: [String: [String]] = ["Upcomming": ["practice", "provo invite", "utah champs"], "Joined": ["practice 2", "chicago cup"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        eventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: eventCellID)
        eventCollectionView.register(UINib(nibName: "EventHeaderCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: eventHeaderID)
    }
    
    // Number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return eventTypes.count
    }
    
    // Number of rows in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let eventType = eventTypes[section]
        return (events[eventType]?.count)!
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
        let eventName = events[eventType]![indexPath.row]
        
        eventCell.eventLabel.text = eventName
        
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
        let eventName = events[eventType]![indexPath.row]
        
        let eventVC = EventViewController(nibName: "EventViewController", bundle: nil)
        eventVC.eventName = eventName
        
        AppState.state.nav.pushViewController(eventVC, animated: true)
    }
}
