//
//  Video.swift
//  YoutubeDemo
//
//  Created by Jian Zhai on 2018/3/16.
//  Copyright © 2018年 Jian Zhai. All rights reserved.
//

import UIKit

class Video {
    let videoThumbnail: UIImage
    let title: String
    
    init(image: UIImage, title: String) {
        self.videoThumbnail = image
        self.title = title
    }
}

