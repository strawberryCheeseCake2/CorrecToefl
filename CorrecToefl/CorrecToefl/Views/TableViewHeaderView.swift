//
//  TableViewHeaderView.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/03/01.
//

import UIKit
import SnapKit

class TableViewHeaderView: UITableViewHeaderFooterView {
	
	static let id = "TableViewHeaderView"
	
	let header = HeaderLabel(text: "")
	
	let spacer = UIView()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		addSubview(header)
		addSubview(spacer)
		setupLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupLayout() {
		header.snp.makeConstraints { make in
			make.top.equalToSuperview()
			make.left.equalToSuperview().offset(16)
		}
		
		spacer.snp.makeConstraints { make in
			make.height.equalTo(16)
			make.top.equalTo(header.snp.bottom)
			make.bottom.equalToSuperview()
		}
	}
}
