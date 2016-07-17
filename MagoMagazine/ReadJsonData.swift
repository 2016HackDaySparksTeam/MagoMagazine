//
//  ReadJsonData.swift
//  MagoMagazine
//
//  Created by 渡辺雄貴 on 2016/07/17.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//
//
//import Foundation
//
//class ReadJsonData {
//    let data :NSData = {"cover": {"title": "",		// マガジンの表紙のタイトル
//                                  "image": "",		// 表紙の写真 1枚 URL
//                                  "number": { "year": 2016,"month": 7,"week": 3},
//                                  "color": "red",	// マガジンの表紙の色
//                        },
//                        "summary": { "title": "",  // coverのtitleと同じ
//                                     "joy": "",  // URL or null
//            "sorrow": ""  // URL or null
//            "anger": "",  // URL or null
//            "surprise": "", // URL or null
//            "other": "",  // URL or null
//        },
//        "contents": [	// 各ページの配列
//        {
//        "templateNo": 1,
//        "text": "楽しい写真",
//        "images": [
//        {
//        "url": "",
//        "caption": "",
//        },
//        {}  // 他の写真
//        ]
//        },
//        {},	// 他のページ
//        ]
//    }
//    
//    let list:NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
//
//}