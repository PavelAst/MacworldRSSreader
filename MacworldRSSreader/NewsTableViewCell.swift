//
//  NewsTableViewCell.swift
//  MacworldRSSreader
//
//  Created by Pavel Osipenko on 19/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var pubDateLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var thumbnail: UIImageView!
  
  var downloadTask: NSURLSessionDownloadTask?
  
  let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .NoStyle
    return formatter
  }()
  
  let sampleURL = "http://zapt3.staticworld.net/images/article/2016/08/wifi_security_cam-100677733-primary.idge.jpg"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func setForNews(news:News) {
    titleLabel.text = news.title
    
    if let date = news.pubDate {
      pubDateLabel.text = dateFormatter.stringFromDate(date)
    }
    authorLabel.text = news.author
    descriptionLabel.text = news.description
    if let url = NSURL(string: news.thumbnailURL) {
      downloadTask = thumbnail.loadImageWithURL(url)
    }
  }
  
}
