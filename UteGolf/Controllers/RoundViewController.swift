//
//  RoundViewController.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/31/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class RoundViewController: UIViewController {
    
    var roundName: String? = ""

    @IBOutlet weak var roundNameLabel: UILabel!
    @IBOutlet weak var scoreField: UITextField!
    @IBOutlet weak var birdiesField: UITextField!
    @IBOutlet weak var parsField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Score"
        
        // Tap to dismiss keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        roundNameLabel.text = "Score For: " + roundName!
    }

    @IBAction func recordScoreButtonClicked(_ sender: Any) {
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
