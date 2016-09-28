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
  
  var testText: Int?

  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var testLbl: UILabel!
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let text = testText {
      testLbl.text = "\(text)"
    }
  }


}
