//
//  RoundedButton.swift
//  bliss
//
//  Created by Amadeu Andrade on 29/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

  //MARK: - Layout
  
  override func awakeFromNib() {
    layer.cornerRadius = 5.0
    layer.borderWidth = 0.3
    layer.borderColor = UIColor.darkGrayColor().CGColor
  }

}
