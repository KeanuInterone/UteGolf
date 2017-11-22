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
        
        navigationItem.title = "Home"
        
        let logoutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logout))
        navigationItem.setRightBarButton(logoutButton, animated: false)
        
//        let profileTab = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        let profileTab = ProfileCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        profileTab.title = "Profile"
        let eventsTab = EventsCollectionViewController(nibName: "EventsCollectionViewController", bundle: nil)
        eventsTab.title = "Events"

        
        setViewControllers([profileTab, eventsTab], animated: true)
    }
    
    @objc private func logout() {
        AppState.state.user = nil
        AppState.state.nav = nil
        self.present(LoginViewController(nibName: "LoginViewController", bundle: nil), animated: true, completion: nil)
    }

}
