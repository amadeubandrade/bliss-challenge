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
  
  var questionID: Int!
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var emailField: UITextField!
  @IBOutlet weak var URLField: UITextField!
  @IBOutlet weak var shareStackView: UIStackView!
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
      super.viewDidLoad()

  }
  
  // MARK: - IBACTIONS
  
  @IBAction func onSendEmailBtnPressed(sender: RoundedButton) {
    print("SHARED")
  }

  
}
