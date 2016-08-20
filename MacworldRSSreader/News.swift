//
//  News.swift
//  MacworldRSSreader
//
//  Created by Pavel Osipenko on 19/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import Foundation

class News {
  
  var title:String
  var pubDate:NSDate?
  var author:String
  var description:String
  var link:String
  var thumbnailURL:String
  
  init(title:String, pubDate:String, author:String, description:String, link:String, thumbnailURL:String) {
    self.title = title
    self.author = author
    self.description = description
    self.link = link
    self.thumbnailURL = thumbnailURL
    
    // Date in RSS items:
    // Fri, 19 Aug 2016 06:00:00 -0700
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss zzz"
    self.pubDate = dateFormatter.dateFromString(pubDate)
  }
  
}
