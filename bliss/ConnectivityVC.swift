//
//  ConnectivityVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import ReachabilitySwift

class ConnectivityVC: UIViewController {

  // MARK: - PROPERTIES
  
  var reachability: Reachability!

  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Set Navigation Bar Back Button
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style: .Plain, target:nil, action:nil)
    // Setup network monitoring
    setupMonitoring()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    // Set observers
    initMonitoring()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    // Remove observers
    stopMonitoring()
  }
  

}
