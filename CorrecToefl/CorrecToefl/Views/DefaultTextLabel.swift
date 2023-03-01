//
//  DefaultTextLabel.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/27.
//
import UIKit

class DefaultTextLabel: UILabel {
	
	init(text: String) {
		super .init(frame: .zero)
		self.font = .systemFont(ofSize: 16, weight: .medium)
		self.textColor = .primary
		self.text = text
		self.numberOfLines = 0
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
