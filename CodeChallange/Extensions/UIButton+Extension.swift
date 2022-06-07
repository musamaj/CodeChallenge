//
//  UIButton+Extension.swift
//  CodeChallange
//
//  Created by Usama Jamil on 07/06/2022.
//

import Foundation
import UIKit


extension UIButton {
    
    func tapHandling() {
        self.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.isEnabled = true
        }
    }
    
}
