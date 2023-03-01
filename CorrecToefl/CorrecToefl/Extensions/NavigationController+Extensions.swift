//
//  NavigationController+Extensions.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/02/26.
//

import Foundation
import UIKit

extension UINavigationController {
	func pushWithFadeIn(_ viewController: UIViewController) {
		let transition: CATransition = CATransition()
		transition.duration = 0.15
		transition.type = CATransitionType.fade
		view.layer.add(transition, forKey: nil)
		pushViewController(viewController, animated: false)
	}
	
	func popWithFadeOut() {
		let transition: CATransition = CATransition()
		transition.duration = 0.15
		transition.type = CATransitionType.fade
		view.layer.add(transition, forKey: nil)
		popViewController(animated: false)
	}
	
	func popToRootVCWithFadeOut() {
		let transition: CATransition = CATransition()
		transition.duration = 0.15
		transition.type = CATransitionType.fade
		view.layer.add(transition, forKey: nil)
		popToRootViewController(animated: false)
	}
}
