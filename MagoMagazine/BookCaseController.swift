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
    var cells :[CustomBook] = []
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
        let cell:CustomBook = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomBook
        let cellImage = UIImage(named: magazines[indexPath.row])
        cell.setTitle("本日は晴天なり")
        cell.setBack(cellImage!)
        //cell.setImage(UIImage(named: "magazine")!)
        cell.setImage(UIImage(getImg("http://kabegami.org/wp-content/uploads/2012/07/0IKPd4.jpg", imageView: cell.bookBack)))
        cells.append(cell)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cellSize:CGFloat = self.view.frame.size.width/CGFloat(lineBooks) - 100
        return CGSizeMake(bookWidth, bookHeight)
    }
    
    // Cell が選択されたときの処理
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let beforeX = self.cells[indexPath.row].center.x
        let beforeY = self.cells[indexPath.row].center.y
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.cells[indexPath.row].center.x = self.cells[indexPath.row].center.x + 10
            self.cells[indexPath.row].center.y = self.cells[indexPath.row].center.y - 10
            }, completion: {(Bool) -> Void in
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.cells[indexPath.row].center.x = self.cells[indexPath.row].center.x - 10
                    self.cells[indexPath.row].center.y = self.cells[indexPath.row].center.y + 10
                })
        })
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return magazines.count;
    }
    
    /// アイテムごとのマージン
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, maxLineSpacingForSectionAtIndex section: Int) -> CGFloat {
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
    
    func getImg(imgUrl: String, imageView :UIImageView){
        print("本日は眠いなり")
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            var img :UIImage = UIImage()
            // Backgroundで実行
            let url = NSURL(string:imgUrl)
            let req = NSURLRequest(URL:url!)

            NSURLConnection.sendAsynchronousRequest(req, queue:NSOperationQueue.mainQueue()){(res, data, err) in
                img = UIImage(data:data!)!
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                print("僕ドラえもん")
                //imageView.image = img
                imageView.image = UIImage(named: "magazine")!
            })
        })
    }
    
}

