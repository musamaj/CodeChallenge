//
//  UIApplication+Extension.swift
//  CodeChallange
//
//  Created by Usama Jamil on 06/06/2022.
//

import Foundation
import UIKit


extension UIApplication {
    
    func exitApp() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
    }
}
