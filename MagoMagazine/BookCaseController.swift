//
//  BookCaseController.swift
//  MagoMagazine
//
//  Created by 功刀　雅士 on 2016/07/17.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import Foundation
import UIKit
class BookCaseController: UIViewController, NSURLSessionTaskDelegate, UICollectionViewDataSource, UICollectionViewDelegate{
    var bookWidth :CGFloat = 200.0
    let lineBooks = 4
    let magazines = ["magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidAppear(animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let image :UIImage = UIImage(named: "daiza")!
        collectionView.backgroundColor = UIColor(patternImage: image)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell:UICollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        let cellImage = UIImage(named: magazines[indexPath.row])
        imageView.image = cellImage
        let label = cell.contentView.viewWithTag(2) as! UILabel
        label.text = magazines[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize:CGFloat = self.view.frame.size.width/CGFloat(lineBooks) - 100
        return CGSizeMake(bookWidth, bookWidth*1.3)
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magazines.count;
    }
    
    /// アイテムごとのマージン
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maxLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        print ("mergin")
        return 0.0
        
    }
    
    /// 行ごとのマージン
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maxInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0.0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

