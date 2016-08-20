//
//  NewsTableViewController.swift
//  MacworldRSSreader
//
//  Created by Pavel Osipenko on 19/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
  
  private var newsItems:[News]?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let feedParser = FeedParser()
    feedParser.parseFeed("http://www.macworld.com/index.rss", completionHandler: {
      (newsItems: [News]) -> Void in
      
      self.newsItems = newsItems
      print(newsItems)
      NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
        self.tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .None)
      })
    })
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // Return the number of sections.
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // Return the number of rows in the section.
    guard let newsItems = newsItems else {
      return 0
    }
    
    return newsItems.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! NewsTableViewCell
    
    // Configure the cell...
    if let item = newsItems?[indexPath.row] {
      cell.titleLabel.text = item.title
      cell.authorLabel.text = item.author
    }
    
    return cell
  }



}

