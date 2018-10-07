//
//  UtilityTests.swift
//  WWDCTests
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

@testable import WWDC
import XCTest
import SwiftyJSON

class UtilityTests: XCTestCase {

  func testNormalVideo() {
    let video = Video(JSON(["eventId": "wwdc2016", "staticContentId": "content_1"]))
    let videoURLString = Utility.getImageURL(from: video)?.absoluteString
    let expectation = "https://devimages-cdn.apple.com/wwdc-services/images/1/content_1/content_1_wide_900x506_1x.jpg"
    XCTAssertEqual(videoURLString, expectation)
  }

  func testUnsupportedVideo() {
    let video = Video(JSON(["eventId": "wwdc2019", "staticContentId": "content_1"]))
    let videoURL = Utility.getImageURL(from: video)
    XCTAssertNil(videoURL)
  }

}
