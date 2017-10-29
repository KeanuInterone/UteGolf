//
//  ProfilePage.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/17/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class ProfilePage: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let profilePicView = UIImageView()
    let nameLabel = UILabel()
    let eventCollectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    let editProfileButton = UIButton()
    let user: User
    let isOwner: Bool
    
    init() {
        self.user = AppState.state.user!
        isOwner = true
        super.init(nibName: nil, bundle: nil)
    }
    
    init(user: User) {
        self.user = user
        isOwner = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.user = AppState.state.user!
        isOwner = true
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        edgesForExtendedLayout = []
        title = "Profile"

        view.backgroundColor = UIColor.white
        
        profilePicView.backgroundColor = UIColor.red
        profilePicView.contentMode = UIViewContentMode.scaleAspectFill
        profilePicView.layer.cornerRadius = 8
        profilePicView.clipsToBounds = true
        profilePicView.image = #imageLiteral(resourceName: "AndrewProfilePic")
        view.addSubview(profilePicView)
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.text = user.FirstName + " " + user.LastName
        view.addSubview(nameLabel)
        
        if(isOwner) {
            editProfileButton.setTitle("edit", for: .normal)
            editProfileButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            editProfileButton.backgroundColor = .lightGray
            editProfileButton.layer.cornerRadius = 8
            editProfileButton.clipsToBounds = true
            view.addSubview(editProfileButton)
        }
        
        eventCollectionView.backgroundColor = UIColor.clear
        eventCollectionView.register(EventCell.self, forCellWithReuseIdentifier: "CellID")
        eventCollectionView.dataSource = self
        eventCollectionView.delegate = self
        view.addSubview(eventCollectionView)
    }
    
    override func viewDidLayoutSubviews() {
        let padding = CGFloat(10)
        
        profilePicView.frame = CGRect(x: padding, y: padding, width: view.frame.width * (2.0/5.0), height: view.frame.width * (2.0/5.0))
        
        nameLabel.frame = CGRect(x: profilePicView.frame.maxX + padding, y: profilePicView.frame.minY, width: view.frame.width - (profilePicView.frame.maxX + padding), height: 30)
        
        editProfileButton.frame = CGRect(x: view.frame.width - padding - 40, y: profilePicView.frame.maxY - 20, width: 40, height: 20)
        
        eventCollectionView.frame = CGRect(x: profilePicView.frame.minX, y: profilePicView.frame.maxY + padding, width: view.frame.width - 2*padding, height: view.frame.height - (profilePicView.frame.maxY + 2*padding))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellID", for: indexPath) as! EventCell
        cell.imageView.image = #imageLiteral(resourceName: "GolfCourse")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 150)
    }
    
    
}

