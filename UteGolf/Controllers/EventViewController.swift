//
//  EventViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/30/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let roundCellID = "RoundCellID"
    let rounds: [String] = ["Round1", "Round2", "Round3", "Round4"]
    var eventName: String = ""
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventPayoutLabel: UILabel!
    @IBOutlet weak var roundsTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        eventNameLabel.text = eventName
        
        roundsTabelView.dataSource = self
        roundsTabelView.delegate = self
        roundsTabelView.register(UITableViewCell.self, forCellReuseIdentifier: roundCellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: roundCellID, for: indexPath)
        
        let roundName = rounds[indexPath.row]
        cell.textLabel?.text = roundName
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roundName = rounds[indexPath.row]
        
        let roundVC = RoundViewController(nibName: "RoundViewController", bundle: nil)
        roundVC.roundName = roundName
        
        AppState.state.nav.pushViewController(roundVC, animated: true)
    }

}
