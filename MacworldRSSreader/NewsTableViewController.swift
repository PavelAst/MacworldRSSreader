//
//  NewsTableViewController.swift
//  MacworldRSSreader
//
//  Created by Pavel Osipenko on 19/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  let rssAllStoriesFeed = "http://www.macworld.com/index.rss"
  let rssNewsFeed = "http://www.macworld.com/news/index.rss"
  
  private var newsItems = [News]()
  
  var searchController:UISearchController!
  var searchResults = [News]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Adding a search bar
    searchController = UISearchController(searchResultsController: nil)
    tableView.tableHeaderView = searchController.searchBar
    searchController.searchResultsUpdater = self
    searchController.dimsBackgroundDuringPresentation = false
    
    // Customize the appearance of the search bar
    searchController.searchBar.placeholder = "Search ..."
    searchController.searchBar.barTintColor = UIColor(red: 1.0/255.0, green: 80.0/255.0, blue: 127.0/255.0, alpha: 0.6)
    searchController.searchBar.tintColor = UIColor(red: 98.0/255.0, green: 196.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    let feedParser = FeedParser()
    feedParser.parseFeed(rssNewsFeed, completionHandler: {
      (newsItems: [News]) -> Void in
      
      self.newsItems = newsItems
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
      })
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return searchController.active ? searchResults.count : newsItems.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
    
    // Configure the cell
    let news = (searchController.active) ? searchResults[indexPath.row] : newsItems[indexPath.row]
    cell.setForNews(news)
    
    return cell
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowWebPage" {
      if let row = tableView.indexPathForSelectedRow?.row {
        let destinationController = segue.destinationViewController as! WebViewController
        let link = (searchController.active) ? searchResults[row].link : newsItems[row].link
        destinationController.linkURL = link
      }
    }
  }
}

// MARK: - UISearchResultsUpdating

extension NewsTableViewController: UISearchResultsUpdating {
  
  func updateSearchResultsForSearchController(searchController: UISearchController) {
    if let searchText = searchController.searchBar.text {
      filterContentForSearchText(searchText)
      tableView.reloadData()
    }
  }
  
  func filterContentForSearchText(searchText: String) {
    searchResults = newsItems.filter({ (news:News) -> Bool in
      let titleMatch = news.title.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      let descriptionMatch = news.description.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
      
      return titleMatch != nil || descriptionMatch != nil
    })
  }
  
}



