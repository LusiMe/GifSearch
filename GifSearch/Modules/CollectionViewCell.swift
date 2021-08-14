//
//  CollectionViewCell.swift
//  GifSearch
//
//  Created by Luda Parfenova on 08/08/2021.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var gifView: UIImageView!
    
    public func setGif(url: URL) {
        gifView.setGIFImage(url: url )
    }
}

