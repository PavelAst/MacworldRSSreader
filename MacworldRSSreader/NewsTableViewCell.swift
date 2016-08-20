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
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
