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
    var bookHeight :CGFloat = 300.0
    let lineBooks = 4
    let magazines = ["book_blue","book_green","book_orange","book_pink","book_yellow","book_green","book_orange","book_pink","book_yellow","book_green","book_orange","book_pink"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidAppear(animated: Bool) {
        collectionView.dataSource = self
        collectionView.delegate = self
        let image :UIImage = UIImage(named: "daiza")!
        //collectionView.backgroundColor = UIColor(patternImage: image)
        addDaiza(0, y: 300)
        
        if ( magazines.count > 4) {
            addDaiza(0, y: 600)
        }
        
        if ( magazines.count > 8) {
            addDaiza(0, y: 900)
        }
        
        if ( magazines.count > 12) {
            addDaiza(0, y: 1200)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func shouldAutorotate() -> Bool{
        return false
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        let orientation: UIInterfaceOrientationMask = [UIInterfaceOrientationMask.Landscape, UIInterfaceOrientationMask.PortraitUpsideDown]
        return orientation
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
        return CGSizeMake(bookWidth, bookHeight)
    }
    
    // Cell が選択されたときの処理
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
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
    
    func addDaiza(x: CGFloat, y: CGFloat){
        let imageDaiza = UIImageView(frame:CGRectMake(x,y,self.view.frame.width,100))
        imageDaiza.image = UIImage(named: "daiza")
        self.view.addSubview(imageDaiza)
        self.view.bringSubviewToFront(collectionView)
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

