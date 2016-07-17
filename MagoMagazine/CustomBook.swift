//
//  CustomBook.swift
//  MagoMagazine
//
//  Created by 功刀　雅士 on 2016/07/17.
//  Copyright © 2016年 渡辺雄貴. All rights reserved.
//

import Foundation
import UIKit

class CustomBook :UICollectionViewCell {
    
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookBack: UIImageView!
    
    func setTitle(str :String){
        bookTitle.text = str
    }
    
    func setImage(i :UIImage){
        let image = UIImageView(frame:CGRectMake(50,80,120,120))
        image.image = i
        self.addSubview(image)
        self.bringSubviewToFront(image)
    }
    
    func setBack(image :UIImage){
        bookBack.image = image
    }
    
}