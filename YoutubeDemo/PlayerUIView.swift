//
//  PlayerUIView.swift
//  YoutubeDemo
//
//  Created by Jian Zhai on 2018/3/17.
//  Copyright © 2018年 Jian Zhai. All rights reserved.
//

import UIKit
import AVFoundation

protocol PlayerViewDelegate {
    func minimizePlayerView()
    func hidePlayerView()
}

class PlayerUIView: UIView {
    
    var delegate: PlayerViewDelegate?
    var videoPlayer: AVPlayer?
    var status: ViewStatus = .hide
    
    @IBOutlet weak var minimizeButton: UIButton!
    @IBOutlet weak var player: UIView?
    
    @IBAction func minimizeButtonClicked(_ sender: Any) {
        delegate?.minimizePlayerView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
        videoPlayer = AVPlayer(url: videoURL!)
        let videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
        videoPlayerLayer.frame = self.player?.bounds ?? self.bounds
        videoPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        if let playView = self.player {
            playView.layer.addSublayer(videoPlayerLayer)
        } else {
            self.layer.addSublayer(videoPlayerLayer)
        }
        play()
    }
    
    @objc func play() {
        print(self.status)
        if self.status != .hide {
            self.videoPlayer?.play()
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
