//
//  VideoCollectionViewModel.swift
//  WWDC
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import Foundation

final class VideoCollectionViewModel {

  let title: String
  let subtitle: String
  let imageURL: URL?

  init(_ video: Video) {
    self.title = video.title
    self.subtitle = video.description
    self.imageURL = Utility.getImageURL(from: video)
  }

}
