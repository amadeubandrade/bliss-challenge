//
//  ViewController.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class LoadingVC: UIViewController {
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var loadingProgressBar: UIProgressView!
  @IBOutlet weak var loadingLbl: UILabel!
  
  
  // MARK: - PROPERTIES
  
  let url = "https://private-anon-d0ef2ee091-blissrecruitmentapi.apiary-mock.com/health"
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkHealthStatus()
  }

  
  // MARK: - FUNCTIONS
  
  func checkHealthStatus() {
    Alamofire.request(.GET, url).progress { bytesRead, totalBytesRead, totalBytesExpectedToRead in
      dispatch_async(dispatch_get_main_queue()) {
        self.updateProgressBar(Float(totalBytesRead), totalBytesExpectedToRead: Float(totalBytesExpectedToRead))
      }
    }.response { (_: NSURLRequest?, response: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
      if error != nil {
        self.tryAgain()
      } else if let _ = response, let _ = data {
        self.performSegueWithIdentifier("showQuestionsVC", sender: nil)
      } else {
        self.tryAgain()
      }
    }
  }
  
  func tryAgain() {
    let alert = UIAlertController(title: "Health Status", message: "There was a problem with the Health Status. Please try again.", preferredStyle: .Alert)
    let tryAgainAction = UIAlertAction(title: "Try Again", style: .Default, handler: { (_: UIAlertAction) in
      self.loadingProgressBar.progress = 0.0
      self.checkHealthStatus()
    })
    alert.addAction(tryAgainAction)
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  func updateProgressBar(totalBytesRead: Float, totalBytesExpectedToRead: Float) {
    loadingProgressBar.setProgress(totalBytesRead/totalBytesExpectedToRead, animated: true)
  }

}

