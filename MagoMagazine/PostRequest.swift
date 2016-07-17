//
//  PostRequest.swift
//  MagoMagazine
//
//  Created by 渡辺雄貴 on 2016/07/16.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import Foundation

class PostRequest {
    
    func postRequest(imageData:NSData) {
        //NSURLRequestを生成
        let url = NSURL(string: "http://babyfuture.zayarwinttun.me/upload.php")
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest()
        if let u = url{
            urlRequest.URL = u
            urlRequest.HTTPMethod = "POST"
            urlRequest.timeoutInterval = 30.0
        }
        //BODYを作成
        let uniqueId = NSProcessInfo.processInfo().globallyUniqueString
        let body: NSMutableData = NSMutableData()
        var postData :String = String()
        let boundary:String = "---------------------------\(uniqueId)"
        urlRequest.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        postData += "--\(boundary)\r\n"
        postData += "Content-Disposition: form-data; name=\"image\"; filename=\"images.jpg\"\r\n"
        postData += "Content-Type: image/jpeg\r\n\r\n"
        body.appendData(postData.dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(imageData)
        postData = String()
        postData += "\r\n"
        postData += "\r\n--\(boundary)--\r\n"
        body.appendData(postData.dataUsingEncoding(NSUTF8StringEncoding)!)
        urlRequest.HTTPBody = NSData(data:body)
        //print(urlRequest)
        //リクエストを送信してレスポンスを受け取る
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(urlRequest, completionHandler: { data, request, error in
            //サーバサイドから返ってきたデータ
            let result = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print("result=\(result)")
        })
        task.resume()
    }
}