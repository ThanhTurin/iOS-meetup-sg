//
//  VideoAPI.swift
//  WWDC
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation
import SwiftyJSON

struct VideoAPIRequestPayload {
  let page: Int
  let limitPerPage: Int

  func getParameters() -> [String: Any] {
    return ["page": page, "limitPerPage": limitPerPage]
  }
}

enum VideoAPIResponsePayload {
  case success(hasMore: Bool, videos: [Video])
  case failure(error: Error)
}

class VideoAPI {

  static let shared = VideoAPI()

  func getVideo(with payload: VideoAPIRequestPayload, completions: ((VideoAPIResponsePayload) -> Void)?) {
    let path = "videos_page_\(payload.page)"
    let json = dataFromJSONFile(path)
    let hasMore = json["hasMore"].boolValue
    let videos = json["videos"].arrayValue.map{Video($0)}

    completions?(VideoAPIResponsePayload.success(hasMore: hasMore, videos: videos))
  }

  private func dataFromJSONFile(_ filename: String) -> JSON {
    if let path = Bundle.main.path(forResource: filename, ofType: "json") {
      if let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) {
        if let jsonObj = try? JSON(data: data) {
          return jsonObj
        }
      }
    }

    return JSON()
  }

}
