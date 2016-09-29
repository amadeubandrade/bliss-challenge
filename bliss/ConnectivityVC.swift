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
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      print("Unable to create Reachability")
      return
    }
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ConnectivityVC.reachabilityChanged), name: ReachabilityChangedNotification, object: reachability)
    do {
      try reachability.startNotifier()
    } catch {
      print("Unable to create Reachability")
      return
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    reachability.stopNotifier()
    NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
  }
  
  
  // MARK: - FUNCTIONS

  func reachabilityChanged(note: NSNotification) {
    let reachability = note.object as! Reachability
    if reachability.isReachable() {
      navigationController?.popViewControllerAnimated(true)
    }
  }

}
