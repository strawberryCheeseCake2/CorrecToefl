//
//  FeedbackListItemView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/27.
//
import UIKit
import SkeletonView

class FeedbackListItemView: StackView {
	
	var type: FeedbackType
	var feedback: String
	
	
	lazy var icon: UIImageView = {
		let imageView = UIImageView()
		
		let iconConfiguration = UIImage.SymbolConfiguration(pointSize: 36)
		var iconName: String
		
		let image = UIImage(systemName: ImageName.checkIcon.rawValue, withConfiguration: iconConfiguration)
		
		imageView.image = image
		imageView.tintColor = .greenSea
		
		return imageView
	}()
	
	lazy var feedbackLabel: DefaultTextLabel = {
		let label = DefaultTextLabel(text: feedback)
		label.numberOfLines = 0
		return label
	}()
	
	init(type: FeedbackType = .check, feedback: String) {
		self.type = type
		self.feedback = feedback
		super .init(axis: .horizontal, distribution: .equalSpacing, spacing: 16, alignment: .center)
		addSubviews()
		setupLayout()
		showSkeletons()
		
	}
	
	private func showSkeletons() {
		self.icon.isSkeletonable = true
		self.feedbackLabel.isSkeletonable = true
		self.icon.skeletonCornerRadius = 18
		self.feedbackLabel.skeletonCornerRadius = 8
		self.icon.showAnimatedSkeleton(usingColor: .systemFill, transition: .crossDissolve(0.3))
		self.feedbackLabel.showAnimatedSkeleton(usingColor: .systemFill, transition: .crossDissolve(0.3))
	}
	
	private func addSubviews() {
		self.addArrangedSubview(icon)
		self.addArrangedSubview(feedbackLabel)
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		icon.snp.makeConstraints { make in
			make.width.equalTo(36)
			make.height.equalTo(36)
		}
	}
}
