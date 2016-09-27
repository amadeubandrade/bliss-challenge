//
//  QuestionsVC+TableView.swift
//  bliss
//
//  Created by Amadeu Andrade on 27/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

extension QuestionsVC {
  
  // MARK: NUMBER OF SECTIONS
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  // MARK: NUMBER OF ROWS
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return questions.count
  }
  
  // MARK: CELL CONFIGURATION
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell") as? QuestionCell {
      let question = questions[indexPath.row]
      cell.thumbnailRequest?.cancel()
      cell.configureCell(question)
      return cell
    }
    
    return UITableViewCell()
  }
  
  // MARK: SELECT CELL
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print(indexPath.row)
  }
  

}