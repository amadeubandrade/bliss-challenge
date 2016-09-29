//
//  Question.swift
//  bliss
//
//  Created by Amadeu Andrade on 27/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import Foundation

class Question {

  // MARK: - PROPERTIES
  
  private var _questionID: Int?
  private var _questionDescription: String?
  private var _questionImageURL: String?
  private var _questionThumbURL: String?
  private var _questionDate: String?
  private var _questionChoices: [[String:AnyObject]]?
  
  
  // MARK: - GETTERS
  
  var questionID: Int? {
    return _questionID
  }
  
  var questionDescription: String? {
    return _questionDescription
  }
  
  var questionImageURL: String? {
    return _questionImageURL
  }
  
  var questionThumbURL: String? {
    return _questionThumbURL
  }
  
  var questionDate: String? {
    return _questionDate
  }
  
  var questionChoices: [[String: AnyObject]]? {
    return _questionChoices
  }
  
  
  // MARK: - INITIALIZER
  
  init(questionInfo: [String: AnyObject]) {
    if let id = questionInfo["id"] as? Int {
      _questionID = id
    }
    if let question = questionInfo["question"] as? String {
      _questionDescription = question
    }
    if let imageURL = questionInfo["image_url"] as? String {
      _questionImageURL = imageURL
    }
    if let thumbURL = questionInfo["thumb_url"] as? String {
      _questionThumbURL = thumbURL
    }
    if let date = questionInfo["published_at"] as? String {
      _questionDate = date
    }
    if let choices = questionInfo["choices"] as? [[String: AnyObject]] {
      _questionChoices = choices
    }
  }
  
  
  // MARK: - FUNCTIONS
  
  // MARK: Question to Dictionary
  
  func buildQuestionDictionary() -> [String:AnyObject] {
    var result = [String:AnyObject]()
    
    if let id = _questionID {
      result["id"] = id
    }
    if let question = _questionDescription {
      result["question"] = question
    }
    if let imageURL = _questionImageURL {
      result["image_url"] = imageURL
    }
    if let thumbURL = _questionThumbURL {
      result["thumb_url"] = thumbURL
    }
    if let date = _questionDate {
      result["published_at"] = date
    }
    if let choices = _questionChoices {
      result["choices"] = choices
    }
    
    return result
  }
  
  // MARK: Update question votes
  
  func updateVotes(choice: Int) {
    if _questionChoices != nil {
      let oldValue = _questionChoices![choice]["votes"] as! Int
      _questionChoices![choice]["votes"] = oldValue + 1
    }
  }


}