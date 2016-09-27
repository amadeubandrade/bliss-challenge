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
  var questions = [Question]()
  
  
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
  }
  

  
}
