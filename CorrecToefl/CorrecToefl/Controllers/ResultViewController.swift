//
//  ResultViewController.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/28.
//

import SkeletonView
import SnapKit
import UIKit

class ResultViewController: UIViewController {
	var feedbacks = [Feedback]()
	var question: String
	var answer: String
	
	var isLoading: Bool = true
	
	lazy var backButton = UIBarButtonItem(image: UIImage(systemName: ImageName.backIcon.rawValue), style: .plain, target: self, action: #selector(backButtonPressd))
	
	let feedbackTableView = UITableView(frame: .zero, style: .grouped)
	let scrollView = UIScrollView()
	let topLevelStackView = StackView(axis: .vertical, distribution: .equalSpacing, spacing: 24, alignment: .leading)
	
	let promptManger = PromptManger()
	
	init(question: String, answer: String) {
		self.question = question
		self.answer = answer
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		configureTableView()
		addSubviews()
		setupLayout()
		
		loadFeedback()
	}
	
	// MARK: Updating Data
	
	private func loadFeedback() {
		isLoading = true
		promptManger.getFeedback(question: question, answer: answer) { [weak self] result in
			
			guard self != nil,
				  let safePromptManger = self?.promptManger else { return }
			
			self?.feedbacks = safePromptManger.parsePrompt(result)
			print(self!.feedbacks)
			
			self?.updateFeedbackView()
		}
	}
	
	private func updateFeedbackView() {
		isLoading = false
		
		DispatchQueue.main.async {
			self.feedbackTableView.reloadData()
		}
		
		self.scrollToBottom()
		
	}
	
	private func scrollToBottom() {
		let feedbackCount = feedbacks.count
		if feedbackCount > 0 {
			let indexPath = IndexPath(row: feedbackCount - 1, section: 1)
			feedbackTableView.scrollToRow(at: indexPath, at: .top, animated: true)
		}
	}
	
	
}

// MARK: Button Action Methods

extension ResultViewController {
	@objc
	private func backButtonPressd() {
		navigationController?.popToRootVCWithFadeOut()
	}
	
	@objc
	private func inputViewButtonPressed() {
		navigationController?.popWithFadeOut()
	}
}

// MARK: Default VC Configuration & Layout

extension ResultViewController {
	private func configureVC() {
		view.backgroundColor = .background
		navigationItem.hidesBackButton = true
		navigationItem.leftBarButtonItem = backButton
	}
	
	private func addSubviews() {
		view.addSubview(feedbackTableView)
	}
	
	private func setupLayout() {
		feedbackTableView.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide)
			make.bottom.equalToSuperview()
			make.width.equalToSuperview()
		}
	}
}

// MARK: Skeleton

extension ResultViewController {
	private func hideSkeletons() {}
}

// MARK: TableView Configurations

extension ResultViewController: SkeletonTableViewDelegate, SkeletonTableViewDataSource {
	func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
		return FeedbackTableViewCell.id
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 0
		} else if section == 1 {
			if isLoading {
				return SkeletonNumbers.feedback.rawValue
			} else {
				return feedbacks.count
			}
		}
		
		return 0
		
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FeedbackTableViewCell.id, for: indexPath) as! FeedbackTableViewCell
		cell.selectionStyle = .none
		
		if !isLoading {
			cell.icon.hideSkeleton()
			cell.feedbackLabel.hideSkeleton()
			let feedback = self.feedbacks[indexPath.row]
			print(feedback)
			cell.configureContents(feedback: feedback)
		}
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		var header: UITableViewHeaderFooterView
		
		switch section {
		case 0:
			header = tableView.dequeueReusableHeaderFooterView(withIdentifier: FeedbackInputTableViewHeaderView.id) as! FeedbackInputTableViewHeaderView
			(header as! FeedbackInputTableViewHeaderView).question = question
			(header as! FeedbackInputTableViewHeaderView).answer = answer
			(header as! FeedbackInputTableViewHeaderView).action = inputViewButtonPressed
		default:
			header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeaderView.id) as! TableViewHeaderView
			(header as! TableViewHeaderView).header.text = "피드백"
		}
		
		return header
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	private func configureTableView() {
		feedbackTableView.backgroundColor = .background
		feedbackTableView.separatorStyle = .none
		feedbackTableView.dataSource = self
		feedbackTableView.delegate = self
		feedbackTableView.register(FeedbackTableViewCell.self, forCellReuseIdentifier: FeedbackTableViewCell.id)
		feedbackTableView.register(FeedbackInputTableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: FeedbackInputTableViewHeaderView.id)
		feedbackTableView.register(TableViewHeaderView.self, forHeaderFooterViewReuseIdentifier: TableViewHeaderView.id)
	}
}
