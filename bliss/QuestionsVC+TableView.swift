//
//  QuestionsVC+TableView.swift
//  bliss
//
//  Created by Amadeu Andrade on 27/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

extension QuestionsVC {
  
  // MARK: NUMBER OF SECTIONS
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  // MARK: NUMBER OF ROWS
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if searchIsActive {
      return questionsFiltered.count
    }
    return questions.count
  }
  
  // MARK: CELL CONFIGURATION
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    if let cell = tableView.dequeueReusableCellWithIdentifier("QuestionCell") as? QuestionCell {
      
      var question: Question!
      
      if searchIsActive {
        question = questionsFiltered[indexPath.row]
      } else {
        question = questions[indexPath.row]
      }
        
      if indexPath.row == questions.count - 1 {
        // Last cell. Download more questions.
        grabQuestionsFromAPI()
      }
      
      cell.thumbnailRequest?.cancel()
      cell.configureCell(question)
      return cell
    }
    
    return UITableViewCell()
  }
  
  // MARK: SELECT CELL
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var question: Question!
    if searchIsActive {
      question = questionsFiltered[indexPath.row]
    } else {
      question = questions[indexPath.row]
    }
    if let id = question.questionID {
        performSegueWithIdentifier("showDetailsVC", sender: id)
    } else {
      let alert = UIAlertController(title: "A problem occurred", message: "The question does not have an ID. Please try again later.", preferredStyle: .Alert)
      let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
      alert.addAction(action)
      self.presentViewController(alert, animated: true, completion: nil)
    }
  }
  

}