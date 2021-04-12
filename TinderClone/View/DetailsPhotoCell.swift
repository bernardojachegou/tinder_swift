//
//  DetailsPhotoCell.swift
//  TinderClone
//
//  Created by Michel Bernardo on 01/04/21.
//

import UIKit

class DetailsPhotoCell: UICollectionViewCell {
  let descriptionLabel: UILabel = .textBoldLabel(16)
  let photosSlideVC = PhotosSlideVC()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    descriptionLabel.text = "New pictures"
    
    addSubview(descriptionLabel)
    descriptionLabel.fullfill(
      top: topAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      bottom: nil,
      padding: .init(top: 0, left: 20, bottom: 0, right: 20)
    )
    
    addSubview(photosSlideVC.view)
    photosSlideVC.view.fullfill(
      top: descriptionLabel.bottomAnchor,
      leading: leadingAnchor,
      trailing: trailingAnchor,
      bottom: bottomAnchor
    )
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}
