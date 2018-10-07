//
//  VideoCollectionViewModelTests.swift
//  WWDCTests
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

@testable import WWDC
import XCTest
import SwiftyJSON

class VideoCollectionViewModelTests: XCTestCase {

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
      "eventId": "wwdc2016"
      ])

    let video = Video(json)
    let viewModel = VideoCollectionViewModel(video)
    XCTAssertEqual(viewModel.title, "title_1")
    XCTAssertEqual(viewModel.subtitle, "description_1")
    XCTAssertEqual(viewModel.imageURL?.absoluteString, "https://devimages-cdn.apple.com/wwdc-services/images/1/content_1/content_1_wide_900x506_1x.jpg")
    

  }

}
