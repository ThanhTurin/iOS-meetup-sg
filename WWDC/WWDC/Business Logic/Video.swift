//
//  Video.swift
//  WWDC
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation
import SwiftyJSON

final class Video {
  let id: String
  let title: String
  let description: String
  let mediaURLString: String
  let contentId: String
  let eventId: String

  init(_ json: JSON) {
    self.id = json["id"].stringValue
    self.title = json["title"].stringValue
    self.description = json["description"].stringValue
    self.mediaURLString = json["media"]["hls"].stringValue
    self.contentId = json["staticContentId"].stringValue
    self.eventId = json["eventId"].stringValue
  }

}
