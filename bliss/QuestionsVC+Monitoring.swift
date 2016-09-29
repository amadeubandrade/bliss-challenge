//
//  QuestionsVC+Monitoring.swift
//  bliss
//
//  Created by Amadeu Andrade on 29/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation
import ReachabilitySwift

extension QuestionsVC {

  // MARK: - SETUP MONITORING
  
  func setupMonitoring() {
    do {
      reachability = try Reachability.reachabilityForInternetConnection()
    } catch {
      return
    }
  }
  
  
  // MARK: - INIT MONITORING
  
  func initMonitoring() {
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(QuestionsVC.reachabilityChanged), name: ReachabilityChangedNotification, object: reachability)
    do {
      try reachability.startNotifier()
    } catch {
      return
    }
  }
  
  
  // MARK: - STOP MONITORING
  
  func stopMonitoring() {
    reachability.stopNotifier()
    NSNotificationCenter.defaultCenter().removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
  }
  
  
  // MARK: - HANDLE CHANGES
  
  func reachabilityChanged(note: NSNotification) {
    let reachability = note.object as! Reachability
    if reachability.isReachable() {
      // Do nothing
    } else {
      performSegueWithIdentifier("showConnectivityVC", sender: nil)
    }
  }
  

}