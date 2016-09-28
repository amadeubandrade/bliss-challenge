//
//  ShareVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class ShareVC: UIViewController {

  // MARK: - PROPERTIES
  
  var questionID: Int!
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var teste: UILabel!
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
      super.viewDidLoad()
    teste.text = "\(questionID)"
  }

  
}
