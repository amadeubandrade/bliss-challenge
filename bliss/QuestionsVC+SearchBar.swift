//
//  QuestionsVC+SearchBar.swift
//  bliss
//
//  Created by Amadeu Andrade on 27/09/16.
//  Copyright © 2016 Amadeu Andrade. All rights reserved.
//

import UIKit

extension QuestionsVC {
  
  // MARK: SHOW/HIDE 
  
  func updateSearchBarVisibility() {
    if searchBarHeightConstraint.constant == 44 {
      self.searchBarHeightConstraint.constant = 0
    } else {
      self.searchBarHeightConstraint.constant = 44
    }
  }

  
  // MARK: - DELEGATE
  
  func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText != "" {
      searchBar.showsCancelButton = true
      searchIsActive = true
      let text = searchText.lowercaseString
      questionsFiltered = questions.filter({$0.questionDescription?.lowercaseString.rangeOfString(text) != nil})
      tableView.reloadData()
    } else {
      searchBar.showsCancelButton = false
      searchIsActive = false
      view.endEditing(true)
      tableView.reloadData()
    }
  }
  
  func searchBarSearchButtonClicked(searchBar: UISearchBar) {
    view.endEditing(false)
  }
  
  func searchBarCancelButtonClicked(searchBar: UISearchBar) {
    searchBar.showsCancelButton = false
    searchBar.text = ""
    searchIsActive = false
    view.endEditing(true)
    questionsFiltered = []
    tableView.reloadData()
  }

  
}