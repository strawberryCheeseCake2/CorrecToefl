//
//  Constants.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//
import Foundation

enum ImageName: String {
	case scanIcon = "doc.text.fill.viewfinder"
	case backIcon = "arrow.left"
	case checkIcon = "checkmark.circle.fill"
	case crossIcon = "xmark.circle.fill"
	case docViewFinder = "doc.viewfinder.fill"
}

enum InputViewGravity {
	case center
	case leadingCenter
	case leadingTop
}

enum Size: Float {
	case separatorSize = 0.34
}

enum FeedbackType {
	case check
	case cross
}


enum SkeletonNumbers: Int {
	case feedback = 5
}
