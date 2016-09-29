//
//  ShareVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class ShareVC: UIViewController {

  // MARK: - PROPERTIES
  
  var questionID: Int?
  var searchText: String?
  let baseURL = "https://private-anon-d0ef2ee091-blissrecruitmentapi.apiary-mock.com/share?"
  let URLSchemeForQuestionWithID = "blissrecruitment://questions?question_id="
  let URLSchemeForQuestionWithText = "blissrecruitment://questions?question_filter="
  var shareRequest: Request?
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var URLField: UITextField!
  @IBOutlet weak var shareStackView: UIStackView!
  @IBOutlet weak var sendEmailButton: UIButton!
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    if let id = questionID {
      URLField.text = URLSchemeForQuestionWithID + "\(id)"
    } else if let text = searchText {
      URLField.text = URLSchemeForQuestionWithText + text
    } else {
      sendEmailButton.enabled = false
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    shareRequest?.cancel()
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
          let alert = UIAlertController(title: "Error", message: "There was an error when sending the email. Please try again later.", preferredStyle: .Alert)
          let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
          alert.addAction(action)
          self.presentViewController(alert, animated: true, completion: nil)
        } else if let result = response.result.value as? [String: AnyObject] {
          if let status = result["status"] as? String where status == "OK" {
            let alert = UIAlertController(title: "Email sent", message: "Your email has been sent with the following content:\n" + urlStr + ".", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
          } else {
            let alert = UIAlertController(title: "Error", message: "There was an error when sending the email. Please try again later.", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
          }
        }
      })
    } else {
      let alert = UIAlertController(title: "Mandatory Field", message: "Email field is mandatory. Please enter an email and try again.", preferredStyle: .Alert)
      let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  
  
  
}
