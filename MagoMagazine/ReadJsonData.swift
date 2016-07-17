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
            getJson(result2[0])
            
            
            
        } catch {
            print("Error: can't create image.")
        }
    }
    
    
    func getJson(url:String) {
        
        //        let URL:NSURL = NSURL(string: url)!
        //        let jsonData :NSData = NSData(contentsOfURL: URL)!
        //
        //        do {
        //            json = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers) as! NSDictionary
        //
        //            let response:NSDictionary = json.objectForKey("cover") as! NSDictionary
        //            let response2:NSDictionary = response.objectForKey("number") as! NSDictionary
        //            print(response2.objectForKey("year"))
        //
        //        } catch  {
        //            // エラー処理
        //            print("error")
        //        }
        
        /*
        let URL = NSURL(string: url)
        let req = NSURLRequest(URL: URL!)
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration, delegate:nil, delegateQueue:NSOperationQueue.mainQueue())
        
        let task = session.dataTaskWithRequest(req, completionHandler: {
            (data, response, error) -> Void in
            do {
                
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
                
                let response:NSDictionary = json.objectForKey("cover") as! NSDictionary
                let response2:NSDictionary = response.objectForKey("number") as! NSDictionary
                print(response2.objectForKey("year"))
                
            } catch {
                
                //エラー処理
                
            }
            
        })
        task.resume()
        */
    }
    
}