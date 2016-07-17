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
    let magazines = ["book_blue","book_green","book_orange","book_pink","book_yellow","book_green","book_orange","book_pink","book_yellow","book_orange","book_pink","book_yellow"]
    let images = ["http://babyfuture.zayarwinttun.me/upload//0f357e62eeed2326296963fc6aebea29.jpg","http://babyfuture.zayarwinttun.me/upload//3bc52368708e9129fb4623e1323c35ee.jpg","http://babyfuture.zayarwinttun.me/upload//4e5020f476df46c43b3e4496e0738515.jpg","http://babyfuture.zayarwinttun.me/upload//5ea7784365166b17d6ed4df59e97d31f.jpg","http://babyfuture.zayarwinttun.me/upload//9a224f1c98c97a54cd229e27eb97ba38.jpg","http://babyfuture.zayarwinttun.me/upload//10d742fb9d04c3c7f1a2f8f31dd8b0da.jpg","http://babyfuture.zayarwinttun.me/upload//68cfdf8af52254d2887f214ee96e14ac.jpg","http://babyfuture.zayarwinttun.me/upload//86e3b5ec0adcd7d1e86960e93d347005.jpg","http://babyfuture.zayarwinttun.me/upload//3573ee34204a594dcead93421cf44e43.jpg","http://babyfuture.zayarwinttun.me/upload//9358da5a35d07a5af69410a50c230cc1.jpg","http://babyfuture.zayarwinttun.me/upload//821429f1089fa0935761248db17cc749.jpg","http://babyfuture.zayarwinttun.me/upload//c10cd2d118512485644769c5d6bedf1b.jpg"]
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
        readJson()
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
        cell.setImage(UIImage(named: "magazine")!) //<-  ここに外部のURLの画像を流し込む        
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
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Magazine", bundle: nil)
                    let next: MagazineViewController = storyboard.instantiateInitialViewController() as! MagazineViewController
                    
                    //let storyboard: UIStoryboard = UIStoryboard(name: "Magazine", bundle: nil)
                    //let next: MagazineViewController = storyboard.instantiateInitialViewController() as! MagazineViewController
                    dispatch_async(dispatch_get_main_queue(), {
                        self.presentViewController(next, animated: true, completion: nil)
                    })

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
    
    func readJson(){
        
        let url = NSURL(string: "http://babyfuture.zayarwinttun.me/getURL.php")
        let jsonUrlData: NSData
        
        do {
            jsonUrlData = try NSData(contentsOfURL:url!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
            //print(jsonUrlData)
            let result = NSString(data: jsonUrlData, encoding: NSUTF8StringEncoding)!
            print(result)
            let separators = NSCharacterSet(charactersInString: "\n")
            let result2 = result.componentsSeparatedByCharactersInSet(separators)
            print(result2)//配列の最後の中身は空っぽなので注意！
            print("----------------------")
            
            for i in 0..<result2.count - 1 {
                let jsonFile = result2[i]
                print(jsonFile)
                //book[i]
                getJson(jsonFile, index: i)
            }
            
            print("----------------------")
            
            //（下記）仮に、1.jsonだけからパースして取ってくる
            //print(result2[0])
            //print("----------------------")
            //getJson(result2[0])
            
            
            
        } catch {
            print("Error: can't create image.")
        }
    }
    
    
    func getJson(url:String, index :Int) {
        
        let URL = NSURL(string: "http://" + url)
        let req = NSURLRequest(URL: URL!)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
        
        let task = session.dataTaskWithRequest(req, completionHandler: {
            (data, response, error) -> Void in
            do {
                //print(data)
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                //cover
                let coverResponse:NSDictionary = json.objectForKey("cover") as! NSDictionary
                let response:NSDictionary = coverResponse.objectForKey("number") as! NSDictionary
                print(response.objectForKey("year")!)
                print(response.objectForKey("month")!)
                print(response.objectForKey("week")!)
                print(coverResponse.objectForKey("title") as! NSString)
                
                if let title = coverResponse.objectForKey("title") as? String {
                    if(index < 9){
                        self.cells[index].setTitle(title)
                    }
               }
                
                if var image = coverResponse.objectForKey("image") as? String {
                    //image = "http://" + image
                    image = self.images[index]
                    var imgData = try NSData(contentsOfURL:NSURL(string:image)!,options: NSDataReadingOptions.DataReadingMappedIfSafe)
                    let img = UIImage(data:imgData);
                    print("やべええええ")
                    print(image)
                    self.cells[index].setImage(img!)
                }else {
                    print("じゅそやべええええ")
                    
                }
                
                print(coverResponse.objectForKey("image") as! NSString)
                print(coverResponse.objectForKey("color") as! NSString)
                //summary
                let summaryResponse:NSDictionary = json.objectForKey("summary") as! NSDictionary
                print(summaryResponse.objectForKey("title") as! NSString)
                print(summaryResponse.objectForKey("joy") as! NSString)
                print(summaryResponse.objectForKey("sorrow") as! NSString)
                print(summaryResponse.objectForKey("anger") as! NSString)
                print(summaryResponse.objectForKey("surprise") as! NSString)
                //contents
                let contentsResponse:NSArray = json.objectForKey("contents") as! NSArray
                for i in 0..<contentsResponse.count {
                    if let text = contentsResponse[i]["text"] as? String {
                        
                    }
                    print(contentsResponse[i]["text"] as! String)
                    print(contentsResponse[i]["templateNo"] as! Int)
                    let response2:NSArray = contentsResponse[i]["images"] as! NSArray
                    for i in 0..<response2.count {
                        print(response2[i]["url"] as! String)
                        print(response2[i]["caption"] as! String)
                    }
                }
                
            } catch {
                
                //エラー処理
                
            }
            
        })
        task.resume()
        
    }

}

