//
//  DetailVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {
  
  // MARK: - PROPERTIES
  
  var questionID: Int!

  
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
    self.title = "ID: \(questionID)"
    // Set Share Button
    let shareButton = UIBarButtonItem(image: UIImage(named: "share"), style: .Plain, target: self, action: #selector(DetailsVC.onShareBtnPressed))
    self.navigationItem.rightBarButtonItem = shareButton
  }
  
//  {
//  "id": 1,
//  "question": "Favourite programming language?",
//  "image_url": "https://dummyimage.com/600x400/000/fff.png&text=question+1+image+(600x400)",
//  "thumb_url": "https://dummyimage.com/120x120/000/fff.png&text=question+1+image+(120x120)",
//  "published_at": "2015-08-05T08:40:51.620Z",
//  "choices": [
//  {
//  "choice": "Swift",
//  "votes": 2048
//  },
//  {
//  "choice": "Python",
//  "votes": 1024
//  },
//  {
//  "choice": "Objective-C",
//  "votes": 512
//  },
//  {
//  "choice": "Ruby",
//  "votes": 256
//  }
//  ]
//  }
  
  // MARK: - IBACTIONS
  
  @IBAction func onUpdateQuestionVotesBtnPressed(sender: UIButton) {
  
  }
  
  // MARK: - FUNCTIONS
  
  func onShareBtnPressed() {
    
  }


}
