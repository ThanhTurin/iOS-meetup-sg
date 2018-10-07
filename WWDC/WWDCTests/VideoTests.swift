//
//  VideoTests.swift
//  WWDCTests
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

@testable import WWDC
import XCTest
import SwiftyJSON

class VideoTests: XCTestCase {

  func testVideoSerialization() {
    let json = JSON([
      "id": "id_1",
      "title": "title_1",
      "description": "description_1",
      "media": [
        "hls": "https://ios.m3u8",
        "tvOShls": "https://tvos.m3u8",
      ],
      "staticContentId": "content_1",
      "eventId": "event_1"
    ])

    let video = Video(json)
    XCTAssertEqual(video.id, "id_1")
    XCTAssertEqual(video.title, "title_1")
    XCTAssertEqual(video.description, "description_1")
    XCTAssertEqual(video.mediaURLString, "https://ios.m3u8")
    XCTAssertEqual(video.contentId, "content_1")
    XCTAssertEqual(video.eventId, "event_1")
  }

}
