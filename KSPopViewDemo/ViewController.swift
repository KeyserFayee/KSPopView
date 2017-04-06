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
    
    @IBAction func showImageText(_ sender: Any) {
        KSPopView.sharedInstance.showTextWithImage(textStr: inputTextField.text!, image: UIImage.init(named: "ic_success.png")!)
    }

}

