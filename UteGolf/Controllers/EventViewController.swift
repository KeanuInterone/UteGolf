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
    var rounds: [Round] = []
    var event: Event? = nil
    
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventPayoutLabel: UILabel!
    @IBOutlet weak var roundsTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
        eventNameLabel.text = event?.EventName
        
        roundsTabelView.dataSource = self
        roundsTabelView.delegate = self
        roundsTabelView.register(UITableViewCell.self, forCellReuseIdentifier: roundCellID)
        loadRounds()
    }
    
    private func loadRounds() {
        Round.GetRoundsWithEventID(EventID: event!.EventID) { (loadedRounds, message) in
            if loadedRounds != nil {
                self.rounds = loadedRounds!
                self.roundsTabelView.reloadData()
            }
            else {
                print(message)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rounds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: roundCellID, for: indexPath)
        
        let round = rounds[indexPath.row]
        cell.textLabel?.text = round.RoundName
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let round = rounds[indexPath.row]
        
        let roundVC = RoundViewController(nibName: "RoundViewController", bundle: nil)
        roundVC.roundName = round.RoundName
        
        AppState.state.nav.pushViewController(roundVC, animated: true)
    }

}
