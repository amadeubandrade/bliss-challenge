//
//  DetailVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire
import ReachabilitySwift

class DetailsVC: UIViewController {
  
  // MARK: - PROPERTIES
  
  var questionID: Int!
  var questionRequest: Request?
  var imgRequest: Request?
  var question: Question?
  var reachability: Reachability!
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var questionTitleLbl: UILabel!
  @IBOutlet weak var questionDateLbl: UILabel!
  @IBOutlet weak var questionImgView: UIImageView!
  @IBOutlet weak var choice1Lbl: UILabel!
  @IBOutlet weak var choice2Lbl: UILabel!
  @IBOutlet weak var choice3Lbl: UILabel!
  @IBOutlet weak var choice4Lbl: UILabel!
  @IBOutlet weak var votes1Lbl: UILabel!
  @IBOutlet weak var votes2Lbl: UILabel!
  @IBOutlet weak var votes3Lbl: UILabel!
  @IBOutlet weak var votes4Lbl: UILabel!

  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Question ID: \(questionID)"
    // Set Share Button
    let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .Plain, target: self, action: #selector(DetailsVC.onShareBtnPressed))
    self.navigationItem.rightBarButtonItem = shareButton
    // Retrieve Question Info
    retrieveInformation()
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
    questionRequest?.cancel()
    imgRequest?.cancel()
    // Remove observers
    stopMonitoring()
  }
  

  // MARK: - IBACTIONS
  
  @IBAction func onUpdateQuestionVotesBtnPressed(sender: UIButton) {
    let APIRetrieveQuestionURL = "https://private-anon-d0ef2ee091-blissrecruitmentapi.apiary-mock.com/questions/\(questionID)?question_id=\(questionID)"
    
    if let quest = question {
      quest.updateVotes(sender.tag)
  
      let body = quest.buildQuestionDictionary()

      Alamofire.request(.PUT, APIRetrieveQuestionURL, parameters: body, encoding: .JSON, headers: nil).responseJSON(completionHandler: { (response: Response<AnyObject, NSError>) in
        if response.result.isFailure {
          self.showAlertWithDetailsVCProblems(title: "A problem occurred", message: "The app cannot download the information for this question. Please try again later.", buttonText: "Dismiss")
        } else if let result = response.result.value as? [String : AnyObject] {
          let question = Question(questionInfo: result)
          self.updateUIwithQuestion(question)
        } else {
          self.showAlertWithDetailsVCProblems(title: "A problem occurred", message: "The app cannot download the information for this question. Please try again later.", buttonText: "Dismiss")
        }
      })
    } else {
      self.showAlertWithDetailsVCProblems(title: "A problem occurred", message: "The app cannot download the information for this question. Please try again later.", buttonText: "Dismiss")
    }
  }
  
  
  // MARK: - FUNCTIONS
  
  // MARK: Share Button Pressed
  
  func onShareBtnPressed() {
    performSegueWithIdentifier("showShareVC", sender: questionID)
  }
  
  // MARK: Get question's info
  
  func retrieveInformation() {
    let APIRetrieveQuestionURL = "https://private-anon-d0ef2ee091-blissrecruitmentapi.apiary-mock.com/questions/\(questionID)?"
    
    let parametersToURL = [
      "question_id" : questionID
    ]
    questionRequest = Alamofire.request(.GET, APIRetrieveQuestionURL, parameters: parametersToURL, encoding: .URL, headers: nil).responseJSON { (response: Response<AnyObject, NSError>) in
      if let questionInfo = response.result.value as? [String: AnyObject] {
        self.question = Question(questionInfo: questionInfo)
        self.updateUIwithQuestion(self.question!)
      } else {
        self.showAlertWithDetailsVCProblems(title: "A problem occurred", message: "The app cannot download the information for this question. Please try again later.", buttonText: "Dismiss")
      }
    }
  }
  
  // MARK: Update UI
  
  func updateUIwithQuestion(question: Question) {
    if let title = question.questionDescription {
      self.questionTitleLbl.text = title
    }
    if let date = question.questionDate {
      self.questionDateLbl.text = date
    }
    if let imgURL = question.questionImageURL {
      imgRequest = Alamofire.request(.GET, imgURL).response(completionHandler: { (_: NSURLRequest?, _:NSHTTPURLResponse?, data: NSData?, error: NSError?) in
        if error != nil {
          self.questionImgView.hidden = true
        } else if let imgData = data {
          if let img = UIImage(data: imgData) {
            self.questionImgView.image = img
          } else {
            self.questionImgView.hidden = true
          }
        } else {
          self.questionImgView.hidden = true
        }
      })
    }
    if let choices = question.questionChoices {
      if let choiceName = choices[0]["choice"] as? String, let votes = choices[0]["votes"] as? Int {
          choice1Lbl.text = choiceName
          votes1Lbl.text = "\(votes)"
      } else {
        choice1Lbl.hidden = true
        votes1Lbl.hidden = true
      }
      if let choiceName = choices[1]["choice"] as? String, let votes = choices[1]["votes"] as? Int {
        choice2Lbl.text = choiceName
        votes2Lbl.text = "\(votes)"
      } else {
        choice2Lbl.hidden = true
        votes2Lbl.hidden = true
      }
      if let choiceName = choices[2]["choice"] as? String, let votes = choices[2]["votes"] as? Int {
        choice3Lbl.text = choiceName
        votes3Lbl.text = "\(votes)"
      } else {
        choice3Lbl.hidden = true
        votes3Lbl.hidden = true
      }
      if let choiceName = choices[3]["choice"] as? String, let votes = choices[3]["votes"] as? Int {
        choice4Lbl.text = choiceName
        votes4Lbl.text = "\(votes)"
      } else {
        choice4Lbl.hidden = true
        votes4Lbl.hidden = true
      }
    }
  }
  
  // MARK: Display Alert
  
  func showAlertWithDetailsVCProblems(title title: String, message: String, buttonText: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
    let action = UIAlertAction(title: buttonText, style: .Default, handler: nil)
    alert.addAction(action)
    self.presentViewController(alert, animated: true, completion: nil)
  }
  
  
  // MARK: - SEGUE
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showShareVC" {
      if let shareVC = segue.destinationViewController as? ShareVC {
        if let id = sender as? Int {
          shareVC.questionID = id
        }
      }
    }
  }


}