//
//  Utility.swift
//  WWDC
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation

class Utility {

  class func getImageURL(from video: Video) -> URL? {
    let maps = [
      "wwdc2016": 1,
      "wwdc2015": 2,
      "wwdc2014": 3,
      "wwdc2018": 42,
      "insights": 44,
      "wwdc2017": 7,
      "tech-talks": 8,
    ]

    guard let imageGroupId = maps[video.eventId] else {
      return nil
    }

    let path = "https://devimages-cdn.apple.com/wwdc-services/images/\(imageGroupId)/\(video.contentId)/\(video.contentId)_wide_900x506_1x.jpg"

    return URL(string: path)
  }

}
