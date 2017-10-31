//
//  TabBarController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/29/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class ProfileTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileTab = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        profileTab.title = "Profile"
        let eventsTab = EventsCollectionViewController(nibName: "EventsCollectionViewController", bundle: nil)
        eventsTab.title = "Events"

        
        setViewControllers([profileTab, eventsTab], animated: true)
    }

}
