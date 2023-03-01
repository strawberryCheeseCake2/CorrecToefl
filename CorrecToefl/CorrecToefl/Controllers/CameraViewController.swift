//
//  CameraViewController.swift
//  CorrecToefl
//
//  Created by 김민규 on 2023/03/01.
//

import Foundation
import UIKit
import AVFoundation
import SnapKit

class CameraViewController: UIViewController {
	
	lazy var backButton = UIBarButtonItem(image: UIImage(systemName: ImageName.backIcon.rawValue), style: .plain, target: self, action: #selector(backButtonPressd))
	
	lazy var captureButton = CameraButton(diameter: 90, action: captureButtonPressed)
	
	var session: AVCaptureSession?
	
	let output = AVCapturePhotoOutput()
	
	let previewLayer = AVCaptureVideoPreviewLayer()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureVC()
		addSubLayers()
		addSubviews()
		checkCameraPermission()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		setupLayout()
		
	}
	
	
	
	
}

// MARK: Default Configuration
extension CameraViewController {
	private func configureVC() {
		view.backgroundColor = .background
		self.navigationItem.hidesBackButton = true
		self.navigationItem.leftBarButtonItem = backButton
	}
	
	private func addSubLayers() {
		view.layer.addSublayer(previewLayer)
	}
	
	private func addSubviews() {
		view.addSubview(captureButton)
	}
	
	private func setupLayout() {
		previewLayer.frame = view.bounds
		captureButton.center = CGPoint(x: view.frame.size.width / 2, y:
										view.frame.size.height - 100)
	}
	
}

// MARK: Button Methods
extension CameraViewController {
	@objc
	private func backButtonPressd() {
		navigationController?.popWithFadeOut()
		
	}
	
	@objc
	private func captureButtonPressed() {
		print("hit")
		output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
	}
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
	func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
		guard let data = photo.fileDataRepresentation() else { return }
		
		let image = UIImage(data: data)
		
		
		
		session?.stopRunning()
		
//		let imageView = UIImageView(image: image)
//		imageView.contentMode = .scaleAspectFill
//		imageView.frame = view.bounds
//		view.addSubview(imageView)
	}
}


// MARK: Camera Setup

extension CameraViewController {
	private func checkCameraPermission() {
		switch AVCaptureDevice.authorizationStatus(for: .video) {
			
		case .notDetermined:
			AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
				guard granted else { return }
				DispatchQueue.main.async {
					self?.setupCamera()
				}
			}
		case .restricted:
			break
		case .denied:
			break
		case .authorized:
			setupCamera()
		@unknown default:
			break
		}
	}
	
	private func setupCamera() {
		let session = AVCaptureSession()
		
		if let device = AVCaptureDevice.default(for: .video) {
			do {
				let input = try AVCaptureDeviceInput(device: device)
				
				if session.canAddInput(input) {
					session.addInput(input)
				}
				
				if session.canAddOutput(output) {
					session.addOutput(output)
				}
				
				previewLayer.videoGravity = .resizeAspectFill
				previewLayer.session = session
				
				session.startRunning()
				self.session = session
				
			} catch {
				print(error)
			}
		} // if let device
		
	}
}
