//
//  QuestionsScreenVC.swift
//  bliss
//
//  Created by Amadeu Andrade on 26/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit
import Alamofire

class QuestionsVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

  // MARK: - PROPERTIES
  
  var currentOffsetParameter = 0
  let limitParameter = 10
  let APIBaseURL = "https://private-anon-d0ef2ee091-blissrecruitmentapi.apiary-mock.com/questions?"
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
    // Grab the first questions
    grabQuestionsFromAPI()
  }
  
  override func viewDidAppear(animated: Bool) {
    // Forces the search when the app is opened by a URL Scheme
    if let text = textToSearch {
      searchBar.text = text
      searchBar.delegate?.searchBar!(searchBar, textDidChange: text)
    }
  }
  
  
  // MARK: - FUNCTIONS
  
  func grabQuestionsFromAPI() {
    let parametersToURL = [
      "limit": limitParameter,
      "offset": currentOffsetParameter
    ]

    Alamofire.request(.GET, APIBaseURL, parameters: parametersToURL, encoding: ParameterEncoding.URL, headers: nil).responseJSON { (response: Response<AnyObject, NSError>) in
      if let result = response.result.value as? [[String: AnyObject]] {
        for questionEntry in result {
          let question = Question(questionInfo: questionEntry)
          self.questions.append(question)
        }
        self.tableView.reloadData()
        self.currentOffsetParameter += self.limitParameter
      } else {
        let alert = UIAlertController(title: "A problem occurred", message: "The app cannot download the questions. Please try again later.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Dismiss", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(self, animated: true, completion: nil)
      }
    }
  }
  
  
  // MARK: - SEGUE
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetailsVC" {
      if let detailsVC = segue.destinationViewController as? DetailsVC {
        if let questionID = sender as? Int {
          detailsVC.testText = questionID
        }
      }
    }
  }

  
}
