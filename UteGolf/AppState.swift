//
//  AppState.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/23/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import Foundation
import UIKit

class AppState {
    
    public var nav: UINavigationController?
    public var user: User?
    
    static let state: AppState = AppState()
    
    private init() {
    }
    
}
