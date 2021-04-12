//
//  PhotosSlideCell.swift
//  TinderClone
//
//  Created by Michel Bernardo on 01/04/21.
//

import UIKit

class PhotosSlideCell: UICollectionViewCell {
  var photoImageView: UIImageView = .photoImageView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    layer.cornerRadius = 8
    clipsToBounds = true
    
    addSubview(photoImageView)
    photoImageView.fillSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
