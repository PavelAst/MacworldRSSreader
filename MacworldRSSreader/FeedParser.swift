//
//  FeedParser.swift
//  MacworldRSSreader
//
//  Created by Pavel Osipenko on 20/08/16.
//  Copyright © 2016 P.Osipenko. All rights reserved.
//

import UIKit

class FeedParser: NSObject, NSXMLParserDelegate {
  
  private var rssItems = [News]()
  private var currentElement = ""
  private var currentTitle:String = "" {
    didSet {
      currentTitle = currentTitle.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
  }
  private var currentPubDate:String = "" {
    didSet {
      currentPubDate = currentPubDate.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
  }
  private var currentDescription:String = "" {
    didSet {
      currentDescription = currentDescription.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
  }
  private var currentAuthor:String = "" {
    didSet {
      currentAuthor = currentAuthor.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
  }
  private var currentLink:String = "" {
    didSet {
      currentLink = currentLink.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
  }
  private var currentThumbnailURL:String = "" {
    didSet {
      currentThumbnailURL = currentThumbnailURL.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
  }
  
  private var parserCompletionHandler:([News] -> Void)?
  
  func parseFeed(feedUrl: String, completionHandler: ([News] -> Void)?) -> Void {
    
    self.parserCompletionHandler = completionHandler
    
    let request = NSURLRequest(URL: NSURL(string: feedUrl)!)
    let urlSession = NSURLSession.sharedSession()
    let task = urlSession.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
      
      guard let data = data else {
        if let error = error {
          print(error)
        }
        return
      }
      
      // Parse XML data
      let parser = NSXMLParser(data: data)
      parser.delegate = self
      parser.parse()
      
    })
    
    task.resume()
  }
  
  func parserDidStartDocument(parser: NSXMLParser) {
    rssItems = []
  }
  
  func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
    
    currentElement = elementName
    
    if currentElement == "item" {
      currentTitle = ""
      currentPubDate = ""
      currentDescription = ""
      currentAuthor = ""
      currentLink = ""
      currentThumbnailURL = ""
    }
  }
  
  func parser(parser: NSXMLParser, foundCharacters string: String) {
    
    switch currentElement {
      case "title": currentTitle += string
      case "pubDate": currentPubDate += string
      //case "description": currentDescription += string
      case "author": currentAuthor += string
      case "link": currentLink += string
      case "media:thumbnail": currentThumbnailURL += string
      default: break
    }
  }
  
  func parser(parser: NSXMLParser, foundCDATA CDATABlock: NSData) {
    let stringDescription = String(data: CDATABlock, encoding: NSUTF8StringEncoding)!
    currentDescription = stringDescription.stringByReplacingOccurrencesOfString("<[^>]+>", withString: " ", options: .RegularExpressionSearch, range: nil)
  }
  
  func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
    if elementName == "item" {
      if !currentTitle.isEmpty && !currentPubDate.isEmpty &&
        !currentAuthor.isEmpty && !currentLink.isEmpty {
        let newsItem = News(title: currentTitle, pubDate: currentPubDate, author: currentAuthor, description: currentDescription, link: currentLink, thumbnailURL: currentThumbnailURL)
        rssItems += [newsItem]
      }
    }
  }
  
  func parserDidEndDocument(parser: NSXMLParser) {
    parserCompletionHandler?(rssItems)
  }
  
  func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
    print(parseError.localizedDescription)
  }

}
