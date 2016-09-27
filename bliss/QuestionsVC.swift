//
//  QuestionsScreenVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController {

  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.setHidesBackButton(true, animated:true)
  }
  
  
  // MARK: - IBACTIONS
  
  @IBAction func teste() {
    performSegueWithIdentifier("showDetailsVC", sender: nil)
  }
  

}
