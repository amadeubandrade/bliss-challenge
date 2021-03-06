//
//  QuestionCell.swift
//  bliss
//
//  Created by Amadeu Andrade on 27/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class QuestionCell: UITableViewCell {

  // MARK: - PROPERTIES
  
  var thumbnailRequest: Request?
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var thumbImageView: UIImageView!
  @IBOutlet weak var IDLbl: UILabel!
  @IBOutlet weak var questionLbl: UILabel!
  @IBOutlet weak var dateLbl: UILabel!
  @IBOutlet weak var spinIndicator: UIActivityIndicatorView!
  @IBOutlet weak var hourLbl: UILabel!
  
  
  // MARK: - INITIALIZER
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  

  // MARK: - CELL CONFIGURATION
  
  func configureCell(question: Question) {
    spinIndicator.startAnimating()
    if let thumbnailURL = question.questionThumbURL {
      thumbnailRequest = Alamofire.request(.GET, thumbnailURL).response(completionHandler: { (_: NSURLRequest?, _: NSHTTPURLResponse?, data: NSData?, error: NSError?) in
        if error != nil {
          // No image
          self.spinIndicator.stopAnimating()
        } else if let imgData = data {
          if let thumbnail = UIImage(data: imgData) {
            self.spinIndicator.stopAnimating()
            self.thumbImageView.image = thumbnail
          } else {
            // No image
            self.spinIndicator.stopAnimating()
          }
        } else {
          // No image
          self.spinIndicator.stopAnimating()
        }
      })
    }
    if let id = question.questionID {
      IDLbl.text = "\(id) )"
    }
    if let question = question.questionDescription {
      questionLbl.text = question
    }
    if let dateHour = question.questionDate {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.zzzZ"
      let dateAndHour = dateFormatter.dateFromString(dateHour)!
      let calendar = NSCalendar.currentCalendar()
      let dateComponents = calendar.components([NSCalendarUnit.Day, NSCalendarUnit.Month, NSCalendarUnit.Year, NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second], fromDate: dateAndHour)
      dateLbl.text = "\(dateComponents.year)-\(dateComponents.month)-\(dateComponents.day)"
      hourLbl.text = "\(dateComponents.hour):\(dateComponents.minute):\(dateComponents.second)"
    }
  }

}
