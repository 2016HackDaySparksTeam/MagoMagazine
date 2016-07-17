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
       /*
        var urlString = "http://babyfuture.zayarwinttun.me/getURL.php"
        var url = NSURL(string: urlString)
        //
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest()
        //download by NSSession
        //var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler:{data, response, error in
            //convert json data to dictionary
//            var dict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//            
//            print(dict)
           /// print(response!)
       // })
        
      //  task.resume()
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { data, request, error in
            //サーバサイドから返ってきたデータ
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print("result=\(result)")
        })
        task.resume()
        */
        
        
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
            
            //（下記）仮に、1.jsonだけからパースして取ってくる
            
            
            
        } catch {
            print("Error: can't create image.")
        }
        
        
    }
}