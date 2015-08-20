//
//  InviteFriendVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 7/29/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

class InviteFriendVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating, SelfiemeCellDelegate {
    
    
    /// Prepare data source
    var friends: [Friend]!
    
    var resultFilter: [Friend]!
    
    /// Result friend vc
    var resultFriendVC: ResultFriendVC!
    
    /// Search controller
    var searchController: UISearchController!
    
    ///
    var arrayFiltered = Array<Friend>()

    
    /// Friend table view
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Invite Friend"
        let revealController = self.revealViewController()
        addBackButton(self, target: revealController)
        
        tableView.registerNib(UINib(nibName: "SelfiemeCell", bundle: nil), forCellReuseIdentifier: "SelfiemeCell")
        
        // Get data
        friends = DataController.getFriendList()
        resultFriendVC = ResultFriendVC()
        
        searchController = UISearchController(searchResultsController: resultFriendVC)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar

        resultFriendVC.tableView.delegate = self
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false

        definesPresentationContext = true
    }
    
    
    // MARK: - Table view data sources
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelfiemeCell", forIndexPath: indexPath) as! SelfiemeCell
        let friend = friends[indexPath.row] as Friend
        cell.bindingDataToCell(friend)
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! SelfiemeCell
        print(cell.isSelect)
        let friendDetailVC = UIStoryboard(name: "FunctionalView", bundle: nil).instantiateViewControllerWithIdentifier("FriendDetailVC") as! FriendDetailVC
        if searchController.active && resultFilter.count > 0 {
            friendDetailVC.friend = resultFilter[indexPath.row]
        } else {
            friendDetailVC.friend = friends[indexPath.row]
        }
        self.navigationController?.pushViewController(friendDetailVC, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UI Searchbar delegate
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UI Search result updating
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let strippedString = searchText?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        var searchItems = [String]()
        if ((strippedString?.endIndex) != nil) {
            searchItems = (strippedString?.componentsSeparatedByString(" "))!
        }
        var andMatchPredicates = [NSPredicate]()
        
        for searchString in searchItems {
            let lhs = NSExpression(forKeyPath: "username")
            let rhs = NSExpression(forConstantValue: searchString)
            let finalPredicate = NSComparisonPredicate(leftExpression: lhs, rightExpression: rhs, modifier: NSComparisonPredicateModifier.DirectPredicateModifier, type: NSPredicateOperatorType.ContainsPredicateOperatorType, options: NSComparisonPredicateOptions.CaseInsensitivePredicateOption)
            andMatchPredicates.append(finalPredicate)
        }
        let finalCompoundPredicate = NSCompoundPredicate.andPredicateWithSubpredicates(andMatchPredicates)
        var searchArray = NSArray(array: friends)
        searchArray = searchArray.filteredArrayUsingPredicate(finalCompoundPredicate)
        let resultTable = searchController.searchResultsController as! ResultFriendVC
        resultFilter = searchArray as! [Friend]
        resultTable.resultFriends = resultFilter
        resultTable.tableView.reloadData()
    }
    
    // MARK: - SelfiemeCell delegate
    func didTouchOnTickButton(cell: SelfiemeCell, select: Bool) {
//        let alertView = UIAlertView(title: "User info", message: "\(cell.usernameLabel.text)", delegate: nil, cancelButtonTitle: "Oh Yeah")
//        alertView.show()

    }
    
    
    // MARK: - UIStateRestoration
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        
    }
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        
    }
}
