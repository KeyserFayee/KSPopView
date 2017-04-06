//
//  KSPopView.swift
//  KSPopViewDemo
//
//  Created by keyser_soz on 2017/3/31.
//  Copyright © 2017年 keyser_soz. All rights reserved.
//

import UIKit
import SnapKit

let Screen_width = UIScreen.main.bounds.size.width
let Screen_height = UIScreen.main.bounds.size.height

enum popViewType {
    case TextType
    case ImageTextType
    case GifTextType
}


class KSPopView: UIView {

    static let sharedInstance = KSPopView()
    
    let bgView = UIView()
    let iconView = UIImageView()
    let titleLabel = UILabel()
    let subTitleLabel = UILabel()
    var isPopup:Bool!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: Screen_width, height: Screen_height))
        
        isPopup = false
        bgView.backgroundColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 0.8)
        bgView.layer.cornerRadius = 5
        
        titleLabel.preferredMaxLayoutWidth = 80
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        titleLabel.setContentHuggingPriority(UILayoutPriorityRequired, for: .vertical)

        self.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(iconView)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showText(textStr:String) {
        if !isPopup {
            isPopup = true
            titleLabel.text = textStr
    
            setAutoLayout(.TextType)
            self.iconView.isHidden = true
            self.alpha = 0.0
            weak var weakSelf:KSPopView! = self
            UIApplication.shared.keyWindow?.insertSubview(self, at: 9999)
            UIView.animate(withDuration: 0.2, animations: {
                weakSelf.alpha = 1.0;

            }, completion: { (finished) -> Void in
                let dispatchTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                    weakSelf.hiddenSelfView()
                }
            })
        }
    }
    
    func showTextWithImage(textStr:String, image:UIImage) {
        if !isPopup {
            isPopup = true
            titleLabel.text = textStr
            iconView.image = image
            
            setAutoLayout(.ImageTextType)
            self.iconView.isHidden = false
            self.alpha = 0.0
            weak var weakSelf:KSPopView! = self
            UIApplication.shared.keyWindow?.insertSubview(self, at: 9999)
            UIView.animate(withDuration: 0.2, animations: {
                weakSelf.alpha = 1.0;
                
            }, completion: { (finished) -> Void in
                let dispatchTime = DispatchTime.now() + .seconds(1)
                DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
                    weakSelf.hiddenSelfView()
                }
            })
        }
    }
    
    func setAutoLayout (_ type:popViewType) {
        
        titleLabel.snp.removeConstraints()
        iconView.snp.removeConstraints()
        
        bgView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-90)
        }
        
        
        if type == .TextType {
            
            titleLabel.snp.makeConstraints { (make) -> Void in
                make.center.equalTo(bgView)
                make.edges.equalTo(bgView).inset(UIEdgeInsetsMake(5, 5, 5, 5))
            }
        }else if type == .ImageTextType {
            
            if titleLabel.intrinsicContentSize.width < (iconView.image?.size.width)! {
                iconView.snp.makeConstraints { (make) -> Void in
                    
                    make.top.equalTo(bgView).offset(10)
                    make.left.equalTo(bgView).offset(10)
                    make.right.equalTo(bgView).offset(-10)
                    
                }
                titleLabel.snp.makeConstraints { (make) -> Void in
                    make.centerX.equalTo(bgView)
                    make.top.equalTo(iconView.snp.bottom).offset(10)
                    make.bottom.equalTo(bgView).offset(-5)
                }
            }else {
                iconView.snp.makeConstraints { (make) -> Void in
                    
                    make.top.equalTo(bgView).offset(10)
                    make.centerX.equalTo(bgView)
                    
                }
                titleLabel.snp.makeConstraints { (make) -> Void in
                    make.top.equalTo(iconView.snp.bottom).offset(10)
                    make.left.equalTo(bgView).offset(10)
                    make.right.equalTo(bgView).offset(-10)
                    make.bottom.equalTo(bgView).offset(-10)
                }
            }
        
        }
        
        
    }
    
    func hiddenSelfView () {
        
        weak var weakSelf:KSPopView! = self
        UIView.animate(withDuration: 0.2, animations: {
            weakSelf.alpha = 0.0
            
        }, completion: { (finished) -> Void in
            weakSelf.removeFromSuperview()
        })
        self.isPopup = false
    }
    

}
