//
//  CameraViewController.swift
//  MagoMagazine
//
//  Created by 渡辺雄貴 on 2016/07/16.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import UIKit
import AVFoundation

class CameraViewController: UIViewController, NSURLSessionTaskDelegate{
    
    // デバイス.
    var myDevice : AVCaptureDevice!
    // セッションの作成.
    let mySession :AVCaptureSession! = AVCaptureSession()
    var videoInput: AVCaptureInput!
    // デバイス一覧の取得.
    let devices = AVCaptureDevice.devices()
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    //PostRequestのインスタンス作成
    let postReq = PostRequest()
    // ボタンを作成.
    let myButton = UIButton(frame: CGRectMake(0,0,60,60))
    // ボタンを作成.
    let changeButton = UIButton(frame: CGRectMake(0,0,50,50))
    // Reader画面への遷移用ボタンを作成
    let nextBtn = UIButton(frame: CGRectMake(0,0,60,60))
    
    let image:UIImage = UIImage(named:"head.png")!
    let imageview = UIImageView()
    
    let image2:UIImage = UIImage(named:"bottun_changeview.png")!
    
    let whiteLabel = UILabel()
    
    let secondview = MagazineCollectionViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // バックカメラをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as! AVCaptureDevice
            }
        }
        // バックカメラからVideoInputを取得.
        if let myDevice = myDevice  {
            do {
                videoInput = try AVCaptureDeviceInput.init(device: myDevice)
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
            myVideoLayer.frame = CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height-100)
            myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
            // Viewに追加.
            self.view.layer.addSublayer(myVideoLayer)
            // セッション開始.
            mySession.startRunning()
        }
        
        //
        whiteLabel.frame = CGRectMake(0, 0, self.view.bounds.width, 50)
        whiteLabel.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(whiteLabel)
        
        //
        imageview.image = image
        imageview.frame = CGRectMake(0, 20, self.view.bounds.width, 35)
        self.view.addSubview(imageview)
        
        myButton.backgroundColor = UIColor.redColor();
        myButton.layer.borderColor = UIColor.blackColor().CGColor
        myButton.layer.borderWidth = 2
        myButton.layer.cornerRadius = 30.0
        myButton.layer.position = CGPoint(x: self.view.bounds.width/2, y:self.view.bounds.height-50)
        myButton.addTarget(self, action: #selector(CameraViewController.onClickMyButton(_:)), forControlEvents: .TouchUpInside)
        // UIボタンをViewに追加.
        self.view.addSubview(myButton)
        
        changeButton.backgroundColor = UIColor.whiteColor();
        changeButton.layer.borderColor = UIColor.redColor().CGColor
        changeButton.layer.borderWidth = 2
        changeButton.layer.cornerRadius = 25.0
        changeButton.layer.position = CGPoint(x: self.view.bounds.width-30, y:50)
        changeButton.addTarget(self, action: #selector(CameraViewController.onClickChangeButton(_:)), forControlEvents: .TouchUpInside)
        // UIボタンをViewに追加.
        //self.view.addSubview(changeButton)
        
        nextBtn.setImage(image2, forState: UIControlState.Normal)
        //nextBtn.backgroundColor = UIColor.blueColor();
        nextBtn.layer.position = CGPoint(x: self.view.bounds.width-50, y:self.view.bounds.height-50)
        nextBtn.addTarget(self, action: #selector(CameraViewController.onChangeViewButton(_:)), forControlEvents: .TouchUpInside)
        // UIボタンをViewに追加.
        self.view.addSubview(nextBtn)
        
        ReadJsonData().readJson()
        
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
    
    func onClickChangeButton(sender: UIButton) {
        
    }
    
    func onChangeViewButton(sender: UIButton) {
        secondview.modalTransitionStyle = UIModalTransitionStyle.FlipHorizontal
        self.presentViewController(secondview, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}