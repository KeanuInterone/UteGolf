//
//  EventViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/30/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

// the event view controller can be shown in a few states
// 1.) user has not joined the event and the event is open
//      - show a "Join Event" button
// 2.) the use has joined the event and the event is open
//      - lets the user see what scores they got on rounds
// 3.) the event is closed
//      - shows the results of the event (the leader board)
//      - shows what scores they got on the rounds if they completed it

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var event: Event? = nil
    var hasJoined: Bool = false
    
    let roundCellID = "RoundCellID"
    var rounds: [Round] = []
    
    
    @IBOutlet weak var joinEventButton: UIButton!
    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventPayoutLabel: UILabel!
    @IBOutlet weak var roundsTabelView: UITableView!
    
    override func viewDidLoad() {
        
        navigationItem.title = "Event"
        
        super.viewDidLoad()
        edgesForExtendedLayout = []
        eventNameLabel.text = event?.EventName
        
        // either we need to show a join event button or show tableview of rounds
        if(hasJoined) {
            joinEventButton.isHidden = true;
        }
        else {
            roundsTabelView.isHidden = true;
        }
        
        roundsTabelView.dataSource = self
        roundsTabelView.delegate = self
        roundsTabelView.register(UITableViewCell.self, forCellReuseIdentifier: roundCellID)
        if(hasJoined) {
            loadRounds()
        }
    }
    
    private func loadRounds() {
        Round.GetRoundsWithEventID(EventID: event!.EventID, UserID: AppState.state.user!.UserID) { (loadedRounds, message) in
            if loadedRounds != nil {
                self.rounds = loadedRounds!
                self.roundsTabelView.reloadData()
            }
            else {
                print(message)
            }
        }
    }
    
    @IBAction func joinEventButtonPressed(_ sender: Any) {
        joinEventButton.isEnabled = false
        
        // check if user has enough utepoints
        if(AppState.state.user!.UtePoints < event!.EntryFee) {
            // show alert
            let alert = UIAlertController(title: "Not enough points", message: "You don't have enough points to join this event", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: {
                self.joinEventButton.isEnabled = true;
            })
        }
        else {
            Event.joinEvent(userID: AppState.state.user!.UserID, eventID: event!.EventID, completion: { (success) in
                if(success) {
                    AppState.state.user!.UtePoints -= self.event!.EntryFee
                    self.joinEventButton.isHidden = true
                    self.roundsTabelView.isHidden = false
                    self.loadRounds()
                }
            })
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
        
        AppState.state.nav!.pushViewController(roundVC, animated: true)
    }

}
