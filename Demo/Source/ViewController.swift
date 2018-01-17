//
//  ViewController.swift
//  Demo
//
//  Created by nagisa-kosuge on 2018/01/17.
//  Copyright © 2018年 RyoKosuge. All rights reserved.
//

import UIKit
import Nuke
import Nuke_WebP_Plugin

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let url = URL(string: "https://www.gstatic.com/webp/gallery/5.sm.webp"), let imageView = self.imageView {
            WebPImage.manager.loadImage(with: url, into: imageView)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

