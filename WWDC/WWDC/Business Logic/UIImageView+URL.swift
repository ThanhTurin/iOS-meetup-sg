import UIKit
import AlamofireImage

extension UIImageView {

  func setImage(with url: URL?) {
    if let url = url {
      af_setImage(withURL: url, placeholderImage: UIImage(named: "video_placeholder"))
    }
    else {
      image = UIImage(named: "video_placeholder")
    }
  }

}
