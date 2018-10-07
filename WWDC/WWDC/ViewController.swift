//
//  ViewController.swift
//  WWDC
//
//  Copyright © 2018 Thanh Turin. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

  private lazy var dataSource: VideoDataSource = {
    return VideoDataSource(delegate: self)
  }()

  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumInteritemSpacing = 10
    flowLayout.minimumLineSpacing = 40

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.contentInset = UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = UIColor.white
    collectionView.alwaysBounceVertical = true

    collectionView.dataSource = dataSource
    collectionView.delegate = dataSource
    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupDataSource()
  }

  private func setupDataSource() {
    dataSource.registerCells(for: collectionView)
    dataSource.fetchData()
  }

  private func setupView() {
    view.addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
    ])
  }

  private func playVideo(_ video: Video) {
    guard let videoURL = URL(string: video.mediaURLString) else {
      return
    }

    let playerViewController = AVPlayerViewController()
    playerViewController.player = AVPlayer(url: videoURL)

    present(playerViewController, animated: true) {
      playerViewController.player?.play()
    }
  }

}

extension ViewController: VideoDataSourceDelegate {
  func videoDataSource(_ dataSource: VideoDataSource, didSelect video: Video) {
    playVideo(video)
  }

  func videoDataSource(_ dataSource: VideoDataSource, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.size.width - 30) / 2.0
    let cellLabelsHeights: CGFloat = 70
    let height = width * 9.0 / 16.0 + cellLabelsHeights
    return CGSize(width: width, height: height)
  }

  func videoDataSource(_ dataSource: VideoDataSource, didRetrivedData videos: [Video]) {
    collectionView.reloadData()
  }

}

