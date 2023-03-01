//
//  HeaderLabel.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/27.
//
import UIKit

class HeaderLabel: UILabel {
	
	init(text: String) {
		super .init(frame: .zero)
		self.font = .systemFont(ofSize: 32, weight: .bold)
		self.textColor = .primary
		self.text = text
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}
