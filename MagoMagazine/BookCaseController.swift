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
    @IBOutlet weak var collectionView: UICollectionView!
    var bookWidth :CGFloat = 200.0
    let lineBooks = 4
    let magazines = ["magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine","magazine"]
    
    override func viewDidAppear(animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        addDaiza(100, y: 100)
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
        let cellSize:CGFloat = self.view.frame.size.width/CGFloat(lineBooks)
        return CGSizeMake(bookWidth, bookWidth*1.5)
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magazines.count;
    }
    
    /// アイテムごとのマージン
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maxLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return 100.0
        
    }
    
    /// 行ごとのマージン
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maxInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
        
    }
    
    func addDaiza(x: CGFloat, y: CGFloat){
        let imageDaiza = UIImageView(frame:CGRectMake(0,0,1024,768))
        imageDaiza.image = UIImage(named: "daiza")
        self.view.addSubview(imageDaiza)
        //self.view.bringSubviewToFront(imageDaiza)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

