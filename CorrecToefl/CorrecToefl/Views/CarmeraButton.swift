//
//  CircleButton.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/03/01.
//

import UIKit

class CameraButton: UIButton {
	
	var icon: UIImageView = {
		let imageView = UIImageView()
		let configuration = UIImage.SymbolConfiguration(pointSize: 48)
		imageView.image = UIImage(systemName: ImageName.docViewFinder.rawValue, withConfiguration: configuration)
		imageView.isUserInteractionEnabled = false
		imageView.tintColor = .white
		return imageView
	}()
	
	var action: (() -> Void)?
	
	init(diameter: Int, action: (() -> Void)?) {
		self.action = action
		super.init(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
		addSubviews()
		setupLayout()
		self.backgroundColor = .brand
		self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
		
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		let height = self.frame.height
		self.layer.cornerRadius = height / 2
		self.clipsToBounds = true
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addSubviews() {
		addSubview(icon)
	}
	
	private func setupLayout() {
		icon.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
	
	@objc
	private func buttonTapped() {
		if let safeAction = action {
			safeAction()
		}
	}
	
}
