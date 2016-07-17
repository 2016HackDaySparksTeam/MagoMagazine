//
//  ReadJsonData.swift
//  MagoMagazine
//
//  Created by 渡辺雄貴 on 2016/07/17.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import Foundation

class ReadJsonData {
    
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
            }
            
            print("----------------------")
            
            //（下記）仮に、1.jsonだけからパースして取ってくる
            print(result2[0])
            print("----------------------")
            getJson(result2[0])
            
            
            
        } catch {
            print("Error: can't create image.")
        }
    }
    
    
    func getJson(url:String) {
        
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
                print(coverResponse.objectForKey("image") as! NSString)
                print(coverResponse.objectForKey("color") as! NSString)
                //summary
                let summaryResponse:NSDictionary = json.objectForKey("summary") as! NSDictionary
                print(summaryResponse.objectForKey("title") as! NSString)
                print(summaryResponse.objectForKey("joy") as! NSString)
                print(summaryResponse.objectForKey("sorrow") as! NSString)
                print(summaryResponse.objectForKey("anger") as! NSString)
                /////print(summaryResponse.objectForKey("surprise") as! NSString)
                //contents
                let contentsResponse:NSArray = json.objectForKey("contents") as! NSArray
                for i in 0..<contentsResponse.count {
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