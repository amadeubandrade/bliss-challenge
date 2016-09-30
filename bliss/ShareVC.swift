//
//  ShareVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire
import ReachabilitySwift

class ShareVC: UIViewController {

  // MARK: - PROPERTIES
  
  var questionID: Int?
  var searchText: String?
  let baseURL = "https://private-anon-d0ef2ee091-blissrecruitmentapi.apiary-mock.com/share?"
  let URLSchemeForQuestionWithID = "blissrecruitment://questions?question_id="
  let URLSchemeForQuestionWithText = "blissrecruitment://questions?question_filter="
  var shareRequest: Request?
  var reachability: Reachability!
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var URLTextView: UITextView!
  @IBOutlet weak var shareStackView: UIStackView!
  @IBOutlet weak var sendEmailButton: UIButton!
  
  
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
    if let id = questionID {
      URLTextView.text = URLSchemeForQuestionWithID + "\(id)"
    } else if let text = searchText {
      URLTextView.text = URLSchemeForQuestionWithText + text
    } else {
      sendEmailButton.enabled = false
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    shareRequest?.cancel()
    // Remove observers
    stopMonitoring()
  }
  
  
  // MARK: - IBACTIONS
  
  @IBAction func onSendEmailBtnPressed(sender: RoundedButton) {
    if let email = emailField.text where email != "" {
      
      var urlStr: String!
      
      if let id = questionID {
        urlStr = URLSchemeForQuestionWithID + "\(id)"
      } else if let text = searchText {
        urlStr = URLSchemeForQuestionWithText + text
      }
      
      let parameters: [String: AnyObject] = [
        "destination_email" : email,
        "content_url": urlStr
      ]
      
      shareRequest = Alamofire.request(.POST, baseURL, parameters: parameters, encoding: .URL, headers: nil).responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in
        if response.result.isFailure {
          self.showAlert(title: "Error", message: "There was an error when sending the email. Please try again later.", buttonText: "Dismiss")
        } else if let result = response.result.value as? [String: AnyObject] {
          if let status = result["status"] as? String where status == "OK" {
            self.showAlert(title: "Email sent", message: "Your email has been sent with the following content:\n" + urlStr + ".", buttonText: "Ok")
          } else {
            self.showAlert(title: "Error", message: "There was an error when sending the email. Please try again later.", buttonText: "Dismiss")
          }
        }
      })
      
    } else {
      showAlert(title: "Mandatory Field", message: "Email field is mandatory. Please enter an email and try again.", buttonText: "Dismiss")
    }
  }
  
  
  // MARK: - FUNCTIONS
  
  // MARK: ERROR HANDLING
  
  func showAlert(title title: String, message: String, buttonText: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: buttonText, style: .Default, handler: nil)
    alert.addAction(action)
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  
  
}
