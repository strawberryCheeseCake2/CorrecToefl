//
//  Color+Extensions.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import Foundation
import UIKit

extension UIColor {
	class var background: UIColor {
		return UIColor(named: "background") ?? .systemBackground
	}
	
	class var primary: UIColor {
		return UIColor(named: "primary") ?? .label
	}
	
	class var brand: UIColor {
		return UIColor(named: "brand") ?? .systemTeal
	}
}
