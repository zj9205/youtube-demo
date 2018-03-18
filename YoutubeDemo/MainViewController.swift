//
//  ViewController.swift
//  YoutubeDemo
//
//  Created by Jian Zhai on 2018/3/16.
//  Copyright © 2018年 Jian Zhai. All rights reserved.
//

import UIKit

enum ViewStatus {
    case show
    case hide
    case min
}

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var playerView: PlayerUIView!
    @IBOutlet weak var subPlayerView: PlayerUIView!
    
    let videos = [Video(image: #imageLiteral(resourceName: "videoImage"), title: "video test")]
    let fullSize = UIScreen.main.bounds.size
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 300
        
        self.playerView.frame = CGRect(x: 0, y: fullSize.height, width: fullSize.width, height: fullSize.height)
        self.subPlayerView.frame.origin = CGPoint.init(x: 0, y: fullSize.height)
        self.playerView.delegate = self
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self.playerView)
            window.addSubview(self.subPlayerView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell
        cell.titleLable.text = videos[indexPath.row].title
        cell.videoImage.image = videos[indexPath.row].videoThumbnail
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 5, options: [.beginFromCurrentState], animations: {
            self.playerView.frame.origin = CGPoint(x: 0, y: 0)
        })
        
        self.playerView.status = .show
        self.subPlayerView.status = .show
        self.playerView.play()
        self.subPlayerView.play()
    }
}

extension MainViewController: PlayerViewDelegate {
    func hidePlayerView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.playerView.frame.origin = CGPoint(x: 0, y: self.fullSize.height)
        })
    }
    
    func minimizePlayerView() {
        hidePlayerView()
        UIView.animate(withDuration: 0.5, animations: {
            self.subPlayerView.frame.origin = CGPoint(x: self.fullSize.width/2 - self.subPlayerView.frame.width/2, y: self.fullSize.height-50-self.subPlayerView.frame.height)
        })

    }
}
