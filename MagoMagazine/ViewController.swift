//
//  ViewController.swift
//  MagoMagazine
//
//  Created by 渡辺雄貴 on 2016/07/16.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, NSURLSessionTaskDelegate{
    
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セッションの作成.
        mySession = AVCaptureSession()
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as! AVCaptureDevice
            }
        }
        
        // バックカメラからVideoInputを取得.
        let videoInput: AVCaptureInput!
        do {
            videoInput = try AVCaptureDeviceInput.init(device: myDevice!)
        }catch{
            videoInput = nil
        }
        
        // セッションに追加.
        mySession.addInput(videoInput)
        // 出力先を生成.
        myImageOutput = AVCaptureStillImageOutput()
        // セッションに追加.
        mySession.addOutput(myImageOutput)
        
        // 画像を表示するレイヤーを生成.
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.init(session:mySession)
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Viewに追加.
        self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
        
        // UIボタンを作成.
        let myButton = UIButton(frame: CGRectMake(0,0,120,50))
        myButton.backgroundColor = UIColor.redColor();
        myButton.layer.masksToBounds = true
        myButton.setTitle("撮影", forState: .Normal)
        myButton.layer.cornerRadius = 20.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: #selector(ViewController.onClickMyButton(_:)), forControlEvents: .TouchUpInside)
        
        // UIボタンをViewに追加.
        self.view.addSubview(myButton);
        
    }
    
    // ボタンイベント.
    func onClickMyButton(sender: UIButton){
        
        // ビデオ出力に接続.
        let myVideoConnection = myImageOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        // 接続から画像を取得.
        self.myImageOutput.captureStillImageAsynchronouslyFromConnection(myVideoConnection, completionHandler: { (imageDataBuffer, error) -> Void in
            
            // 取得したImageのDataBufferをJpegに変換.
            let myImageData : NSData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataBuffer)
            
            // JpegからUIIMageを作成.
            let myImage : UIImage = UIImage(data: myImageData)!
            
            // アルバムに追加.
            UIImageWriteToSavedPhotosAlbum(myImage, self, nil, nil)
            
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
            body.appendData(myImageData)
            
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
            
        })
    }
    
}