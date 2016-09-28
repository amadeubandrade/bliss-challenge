//
//  QuestionsScreenVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

class QuestionsVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

  // MARK: - PROPERTIES
  
  var actualOffset = 0
  var textToSearch: String?
  var searchIsActive = false
  var questions = [Question]()
  var questionsFiltered = [Question]()
  
  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.setHidesBackButton(true, animated:true)
    searchBar.delegate = self
    // Button to hide/show search bar
    let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: #selector(QuestionsVC.updateSearchBarVisibility))
    self.navigationItem.rightBarButtonItem = searchButton
    
    // Test data:
    let info = [
      "id": 10,
      "question": "Favourite programming language?",
      "image_url": "https://dummyimage.com/600x400/000/fff.png&text=question+1+image+(600x400)",
      "thumb_url": "https://dummyimage.com/120x120/000/fff.png&text=question+1+image+(120x120)",
      "published_at": "2015-08-05T08:40:51.620Z",
      "choices": [
        ["choice": "Swift","votes": 2048],
        ["choice": "Python","votes": 1024],
        ["choice": "Objective-C","votes": 512],
        ["choice": "Ruby","votes": 256]
      ]
    ]
    
    let info2 = [
      "id": 1,
      "question": "filter me",
      "image_url": "https://dummyimage.com/600x400/000/fff.png&text=question+1+image+(600x400)",
      "thumb_url": "https://dummyimage.com/120x120/000/fff.png&text=question+1+image+(120x120)",
      "published_at": "2015-08-05T08:40:51.620Z",
      "choices": [
        ["choice": "Swift","votes": 2048],
        ["choice": "Python","votes": 1024],
        ["choice": "Objective-C","votes": 512],
        ["choice": "Ruby","votes": 256]
      ]
    ]

    let q1 = Question(questionInfo: info)
    let q2 = Question(questionInfo: info)
    let q3 = Question(questionInfo: info)
    let q4 = Question(questionInfo: info2)
    questions.append(q1)
    questions.append(q2)
    questions.append(q3)
    questions.append(q4)
  }
  
  override func viewDidAppear(animated: Bool) {
    // Forces the search when the app is opened by a URL Scheme
    if let text = textToSearch {
      searchBar.text = text
      searchBar.delegate?.searchBar!(searchBar, textDidChange: text)
    }
  }
  

  
}
