//
//  TopLevelStackView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//
import Foundation

import UIKit

class StackView: UIStackView {
	
	init(axis: NSLayoutConstraint.Axis, distribution:  UIStackView.Distribution, spacing: CGFloat, alignment: UIStackView.Alignment) {
		super .init(frame: .zero)

		self.axis = axis
		self.distribution = distribution
		self.alignment = alignment
		self.spacing = spacing
	}
	
	convenience init(axis: NSLayoutConstraint.Axis,spacing: CGFloat) {
		self.init(axis: axis, distribution: .equalSpacing, spacing: spacing, alignment: .center)
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
