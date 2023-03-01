//
//  PlaceHolderLabel.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/27.
//

import UIKit

class PlaceholderLabel: UILabel {
	
	override init(frame: CGRect) {
		super .init(frame: frame)
		self.font = .systemFont(ofSize: 16, weight: .medium)
		self.textColor = .placeholderText
		self.isUserInteractionEnabled = false
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
}
