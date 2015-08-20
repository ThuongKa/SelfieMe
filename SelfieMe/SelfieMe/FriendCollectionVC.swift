//
//  FriendCollectionVC.swift
//  SelfieMe
//
//  Created by Thuong Vu on 8/4/15.
//  Copyright © 2015 Thuong Vu. All rights reserved.
//

import UIKit

// Images collection of friend

class FriendCollectionVC: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.registerNib(UINib(nibName: "ImageCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionCell")
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ImageCollectionCell", forIndexPath: indexPath)
        return cell
    }
}
