//
//  UIAnimation+Extension.swift
//  CodeChallange
//
//  Created by Usama Jamil on 05/06/2022.
//

import UIKit

extension UIView{
    
    func animHide(){
        UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= 300
                        self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func animShow(){
        UIView.animate(withDuration: 5, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += 300
                        self.layoutIfNeeded()

        },  completion: nil)
    }
}
