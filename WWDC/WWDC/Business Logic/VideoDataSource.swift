//
//  VideoDataSource.swift
//  WWDC
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit

protocol VideoDataSourceDelegate: AnyObject {
  func videoDataSource(_ dataSource: VideoDataSource, sizeForItemAt indexPath: IndexPath) -> CGSize
  func videoDataSource(_ dataSource: VideoDataSource, didSelect video: Video)
  func videoDataSource(_ dataSource: VideoDataSource, didRetrivedData videos: [Video])
}

final class VideoDataSource: NSObject {

  private weak var delegate: VideoDataSourceDelegate?

  private let videoAPI: VideoAPI

  private var videos = [Video]()
  private var hasMore = false

  private var currentPage: Int = 1
  private let limitPerPage = 10
  private var isFetchingData: Bool = false

  init(delegate: VideoDataSourceDelegate?,
       videoAPI: VideoAPI = VideoAPI.shared
    ) {
    self.delegate = delegate
    self.videoAPI = videoAPI
  }

  func registerCells(for collectionView: UICollectionView) {
    collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.reuseIdentifier)
  }

  func fetchData() {
    isFetchingData = true

    let requestPayload = VideoAPIRequestPayload(page: currentPage, limitPerPage: limitPerPage)

    videoAPI.getVideo(with: requestPayload) { [weak self] (response) in
      self?.updateData(with: response)
      self?.isFetchingData = false
    }
  }

  private func updateData(with response: VideoAPIResponsePayload) {
    switch response {
    case .success(hasMore: let hasMore, videos: let videos):
      self.hasMore = hasMore
      self.videos += videos
      delegate?.videoDataSource(self, didRetrivedData: videos)

    case .failure:
      self.hasMore = false
    }
  }

  private func fetchNextPage() {
    currentPage += 1
    fetchData()
  }

}

extension VideoDataSource: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.reuseIdentifier, for: indexPath) as? VideoCollectionViewCell else {
      return UICollectionViewCell()
    }

    let video = videos[indexPath.row]
    let viewModel = VideoCollectionViewModel(video)
    cell.viewModel = viewModel
    return cell
  }

}

extension VideoDataSource: UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let delegate = delegate else {
      return CGSize.zero
    }
    return delegate.videoDataSource(self, sizeForItemAt: indexPath)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.videoDataSource(self, didSelect: videos[indexPath.row])
  }

}

