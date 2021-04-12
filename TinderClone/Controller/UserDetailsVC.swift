//
//  UserDetailsVC.swift
//  TinderClone
//
//  Created by Michel Bernardo on 01/04/21.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    let layoutAttributes = super.layoutAttributesForElements(in: rect)
    
    layoutAttributes?.forEach({ (attribute) in
      if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
        
        guard let collectionView = collectionView else {return}
        let contentOffSetY = collectionView.contentOffset.y
        
        attribute.frame = CGRect(
          x: 0,
          y: contentOffSetY,
          width: collectionView.bounds.width,
          height: attribute.bounds.height - contentOffSetY
        )
      }
      
    })
    return layoutAttributes
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
}

class UserDetailsVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var user: User? {
    didSet {
      self.collectionView.reloadData()
    }
  }
  
  let cellId = "cellId"
  let headerId = "headerId"
  let profileId = "profileId"
  let photosId = "photosId"
  
  var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
  var likeButton: UIButton = .iconFooter(named: "icone-like")
  var theBackButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "icone-down"), for: .normal)
    button.backgroundColor = UIColor(red: 232/255, green: 88/255, blue: 54/255, alpha: 1)
    button.clipsToBounds = true
    return button
  }()
  var callback: ((User?, Action) -> Void)?
  
  init () {
    super.init(collectionViewLayout: HeaderLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    
    super.viewDidLoad()
    
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 132, right: 0)
    collectionView.backgroundColor = .white
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    collectionView.register(DetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    collectionView.register(DetailsInProfileCell.self, forCellWithReuseIdentifier: profileId)
    collectionView.register(DetailsPhotoCell.self, forCellWithReuseIdentifier: photosId)
    
    self.addFooter()
    self.addBackButton()
  }
  
  func addBackButton() {
    //    view.addSubview(theBackButton)
    //    theBackButton.frame = CGRect(
    //      x: view.bounds.width - 69,
    //      y: view.bounds.height * 0.7,
    //      width: 48,
    //      height: 48
    //    )
    
    view.addSubview(theBackButton)
    theBackButton.frame = CGRect(
      x: view.bounds.width + 350,
      y: view.bounds.height + 625,
      width: 48,
      height: 48
    )
    theBackButton.layer.cornerRadius = 24
    theBackButton.addTarget(self, action: #selector(goBackClick), for: .touchUpInside)
  }
  
  
  func addFooter() {
    let stackView = UIStackView(arrangedSubviews: [UIView(), deslikeButton, likeButton, UIView()])
    stackView.distribution = .equalCentering
    
    view.addSubview(stackView)
    stackView.fullfill(
      top: nil,
      leading: view.leadingAnchor,
      trailing: view.trailingAnchor,
      bottom: view.bottomAnchor,
      padding: .init(top: 0, left: 16, bottom: 32, right: 16)
    )
    
    deslikeButton.addTarget(self, action: #selector(deslikeClick), for: .touchUpInside)
    likeButton.addTarget(self, action: #selector(likeClick), for: .touchUpInside)
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  // header
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetailHeaderView
    header.user = self.user
    return header
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
  }
  
  // footer
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    if indexPath.item == 0 {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileId, for: indexPath) as! DetailsInProfileCell
      cell.user = self.user
      return cell
    }
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photosId, for: indexPath) as! DetailsPhotoCell
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.width * 0.66
    
    if indexPath.item == 0 {
      let cell = DetailsInProfileCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
      cell.user = self.user
      cell.layoutIfNeeded()
      
      let stimatedSize = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
      height = stimatedSize.height
    }
    
    return .init(width: width, height: height)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let originY = view.bounds.height + 625
    
    if scrollView.contentOffset.y > 0 {
      self.theBackButton.frame.origin.y = originY - scrollView.contentOffset.y
    } else {
      self.theBackButton.frame.origin.y = originY + scrollView.contentOffset.y * -1
    }
  }
  
  @objc func goBackClick() {
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func deslikeClick() {
    self.callback?(self.user, Action.deslike)
    self.goBackClick()
  }
  
  @objc func likeClick() {
    self.callback?(self.user, Action.like)
    self.goBackClick()
  }
  
}
