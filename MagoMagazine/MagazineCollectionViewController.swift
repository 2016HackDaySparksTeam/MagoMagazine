//
//  MagazineCollectionViewController.swift
//  MagoMagazine
//
//  Created by 渡辺雄貴 on 2016/07/17.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import Foundation
import UIKit

class MagazineCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView!.delegate = self
        //collectionView!.dataSource = self
        
        self.view.backgroundColor = UIColor.whiteColor()
        
    }
    
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}