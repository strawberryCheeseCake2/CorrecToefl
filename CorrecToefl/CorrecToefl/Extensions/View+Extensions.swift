//
//  View+Extensions.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import Foundation
import UIKit

extension UIView {
	func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
		let border = UIView()
		border.backgroundColor = color
		border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
		border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
		addSubview(border)
	}

	func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
		let border = UIView()
		border.backgroundColor = color
		border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
		border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
		addSubview(border)
	}

	func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
		let border = UIView()
		border.backgroundColor = color
		border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
		border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
		addSubview(border)
	}

	func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
		let border = UIView()
		border.backgroundColor = color
		border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
		border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
		addSubview(border)
	}
}
