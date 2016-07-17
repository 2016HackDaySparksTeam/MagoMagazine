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
    //PostRequestのインスタンス作成
    let postReq = PostRequest()
    // ボタンを作成.
    let myButton = UIButton(frame: CGRectMake(0,0,60,60))
    // ボタンを作成.
    let changeButton = UIButton(frame: CGRectMake(0,0,50,50))
    
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
        
        myButton.backgroundColor = UIColor.redColor();
        myButton.layer.masksToBounds = true
        //myButton.setTitle("撮影", forState: .Normal)
        myButton.layer.borderColor = UIColor.whiteColor().CGColor
        myButton.layer.borderWidth = 2
        myButton.layer.cornerRadius = 30.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: #selector(ViewController.onClickMyButton(_:)), forControlEvents: .TouchUpInside)
        // UIボタンをViewに追加.
        self.view.addSubview(myButton)
        
        changeButton.backgroundColor = UIColor.whiteColor();
        changeButton.layer.masksToBounds = true
        //myButton.setTitle("撮影", forState: .Normal)
        changeButton.layer.borderColor = UIColor.redColor().CGColor
        changeButton.layer.borderWidth = 2
        changeButton.layer.cornerRadius = 25.0
        changeButton.layer.position = CGPoint(x: self.view.bounds.width-30, y:50)
        //changeButton.addTarget(self, action: #selector(ViewController.onClickChangeButton(_:)), forControlEvents: .TouchUpInside)
        // UIボタンをViewに追加.
        self.view.addSubview(changeButton)
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
            PostRequest().postRequest(myImageData)
        })
    }
}