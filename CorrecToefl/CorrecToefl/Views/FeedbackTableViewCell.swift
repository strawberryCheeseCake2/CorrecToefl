//
//  FeedbackListItemView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/27.
//
import UIKit
import SkeletonView

class FeedbackTableViewCell: UITableViewCell {
	
	static let id = "FeedbackTableViewCell"
	
	var type: FeedbackType = .check
	var feedback: String = "DummyTextDummyTextDummyTextDummyTextDummyTextDummyTextDummyTextDummyTextDummyTextDummyTextDummyTextDummy" {
		didSet {
			feedbackLabel.text = feedback
		}
	}
	
	let container = StackView(axis: .horizontal, distribution: .fill, spacing: 16, alignment: .center)
	
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
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super .init(style: style, reuseIdentifier: reuseIdentifier)
		addSubviews()
		setupLayout()
		showSkeletons()
	}
	
	private func showSkeletons() {
		self.icon.isSkeletonable = true
		self.feedbackLabel.isSkeletonable = true
		self.icon.skeletonCornerRadius = 18
		self.feedbackLabel.skeletonCornerRadius = 10
		self.icon.showAnimatedSkeleton(usingColor: .systemFill, transition: .crossDissolve(0.3))
		self.feedbackLabel.showAnimatedSkeleton(usingColor: .systemFill, transition: .crossDissolve(0.3))
	}
	
	func configureContents(feedback: Feedback) {
		self.feedback = feedback.feedbackString
		feedbackLabel.text = feedback.feedbackString
	}
	
	private func addSubviews() {
		addSubview(container)
		container.addArrangedSubview(icon)
		container.addArrangedSubview(feedbackLabel)
	}
	
	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		
		container.snp.makeConstraints { make in
			make.top.equalToSuperview().offset(16)
			make.left.equalToSuperview().offset(16)
			make.bottom.equalToSuperview().offset(-16)
			make.right.equalToSuperview().offset(-16)
		}
		
		icon.snp.makeConstraints { make in
			make.width.equalTo(36)
			make.height.equalTo(36)
		}
		
		feedbackLabel.snp.makeConstraints { make in
			make.height.greaterThanOrEqualTo(64)
			make.width.greaterThanOrEqualTo(UIScreen.main.bounds.width * 0.7)
		}
	}
}
