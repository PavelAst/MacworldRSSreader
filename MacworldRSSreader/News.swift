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
  var pubDate:String
  var author:String
  var description:String
  var link:String
  var thumbnailURL:String
  
  init(title:String, pubDate:String, author:String, description:String, link:String, thumbnailURL:String) {
    self.title = title
    self.pubDate = pubDate
    self.author = author
    self.description = description
    self.link = link
    self.thumbnailURL = thumbnailURL
  }
  
}
