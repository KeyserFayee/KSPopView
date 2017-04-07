//
//  ViewController.swift
//  KSPopViewDemo
//
//  Created by keyser_soz on 2017/3/31.
//  Copyright © 2017年 keyser_soz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var inputTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showText(_ sender: Any) {
        KSPopView.sharedInstance.showText(textStr: inputTextField.text!)
    }
    
    @IBAction func showTextWithPosition(_ sender: Any) {
        KSPopView.sharedInstance.showText(textStr: inputTextField.text!, position: (20,20))
    }
    
    @IBAction func showImageText(_ sender: Any) {
        KSPopView.sharedInstance.showTextWithImage(textStr: inputTextField.text!, imageName: "ic_success@2x.png", dissmiss:true, needMask:true)
    }

    @IBAction func showGifText(_ sender: Any) {
        KSPopView.sharedInstance.showTextWithImage(textStr: inputTextField.text!, imageName: "loading.gif", dissmiss:false, needMask:false)
        
        let dispatchTime = DispatchTime.now() + .seconds(3)
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            KSPopView.sharedInstance.hidePopView()
        }
    }
}

