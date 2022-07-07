//
//  UIApplication+Extension.swift
//  Mobile Weather App
//
//  Created by Ishan Gohil on 5/22/22.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
