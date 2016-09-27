//
//  ViewBorderShadow.swift
//  bliss
//
//  Created by Amadeu Andrade on 27/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class ViewBorderShadow: UIView {

  //MARK: - LAYOUT
  
  override func awakeFromNib() {
    layer.cornerRadius = 5.0
    layer.shadowColor = UIColor(red: 157.0/255.0, green: 157.0/255.0, blue: 157.0/255.0, alpha: 0.5).CGColor
    layer.shadowOpacity = 0.8
    layer.shadowRadius = 5.0
    layer.shadowOffset = CGSizeMake(0.0, 2.0)
  }

}
