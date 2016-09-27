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

  
  // MARK: - IBOUTLETS
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBarHeightConstraint: NSLayoutConstraint!
  
  
  // MARK: - VIEW LIFE CYCLE
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "Bliss Challenge"
    self.navigationItem.setHidesBackButton(true, animated:true)
    searchBar.delegate = self
    
    let searchButton = UIBarButtonItem(image: UIImage(named: "search"), style: .Plain, target: self, action: #selector(QuestionsVC.updateSearchBarVisibility))
    self.navigationItem.rightBarButtonItem = searchButton
  }
  
  
  // MARK: - IBACTIONS
  
  func updateSearchBarVisibility() {
    if searchBarHeightConstraint.constant == 44 {
      self.searchBarHeightConstraint.constant = 0
    } else {
      self.searchBarHeightConstraint.constant = 44
    }
  }

  
}
