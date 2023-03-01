//
//  RoundedButton.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import UIKit

class RoundedButton: UIButton {
	
	var title: String
	
	var action: (() -> Void)?
	
	init(title: String, action: (() -> Void)? = nil) {
		self.title = title
		super .init(frame: .zero)
		backgroundColor = .brand
		
		setupLayout()
	}
	
	override func layoutSubviews() {
		configureButton()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func configureButton() {
		let height = self.frame.height
		self.layer.cornerRadius = height / 2
		self.clipsToBounds = true
		self.setTitle(title, for: .normal)
		self.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
		self.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
	}
	
	@objc
	private func handleTap() {
		if let safeAction = action {
			safeAction()
		}
	}
	
	private func setupLayout() {
		
	}
}
