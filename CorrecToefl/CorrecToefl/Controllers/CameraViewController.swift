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
import CropViewController
import Vision

class CameraViewController: UIViewController {
	
	lazy var backButton = UIBarButtonItem(image: UIImage(systemName: ImageName.backIcon.rawValue), style: .plain, target: self, action: #selector(backButtonPressd))
	
	lazy var captureButton = CameraButton(diameter: 90, action: captureButtonPressed)
	
	var session: AVCaptureSession?
	
	let output = AVCapturePhotoOutput()
	
	let previewLayer = AVCaptureVideoPreviewLayer()
	
	let activityIndicator = UIActivityIndicatorView(style: .large)
	
	let promptManger = PromptManger()
	
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
		view.addSubview(activityIndicator)
	}
	
	private func setupLayout() {
		previewLayer.frame = view.bounds
		captureButton.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height - 100)
		activityIndicator.center = CGPoint(x: view.frame.size.width / 2, y:view.frame.size.height / 2)
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
		guard let data = photo.fileDataRepresentation(),
		let image = UIImage(data: data) else { return }
		
		showCropVC(image)
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

// MARK: Crop
extension CameraViewController: CropViewControllerDelegate {
	private func showCropVC(_ image: UIImage) {
		print(image)
		
		let cropVC = CropViewController(croppingStyle: .default, image: image)
		cropVC.aspectRatioPreset = .presetSquare
		cropVC.delegate = self
		
		navigationController?.pushWithFadeIn(cropVC)
	}
	
	func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
		navigationController?.popWithFadeOut()
		session?.startRunning()
	}
	
	func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
		navigationController?.popWithFadeOut()
		captureButton.isUserInteractionEnabled = false
		activityIndicator.startAnimating()
		
		recognizeText(image: image) { [weak self] ocrResult in
			self?.activityIndicator.stopAnimating()
			self?.captureButton.isUserInteractionEnabled = true
			
//			self?.promptManger.getEndOfQuestion(ocrResult: ocrResult) { result in
////				 ocr parse -> prompt
//
//				let editorVC = EditorViewController()
//				editorVC.questionTextView.placholderLabel.isHidden = true
//				editorVC.answerTextView.placholderLabel.isHidden = true
////				editorVC.questionTextView.text = question
////				editorVC.answerTextView.text = answer
//				self?.navigationController?.pushWithFadeIn(editorVC)
//			}
			
			let editorVC = EditorViewController()
			let prompt = self?.promptManger.getSeperatedPrompt(text: ocrResult)
			editorVC.answerTextView.text = ""
			editorVC.answerTextView.placholderLabel.isHidden = true
			self?.navigationController?.setNavigationBarHidden(false, animated: true)
			self?.navigationController?.pushWithFadeIn(editorVC)
			
		}
		
	}
}


// MARK: Vision
extension CameraViewController {
	private func recognizeText(image: UIImage, completionHandler: @escaping ((String) -> Void)) {
		guard let cgImage = image.cgImage else { return }
		
		print(cgImage)
		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		
		let request = VNRecognizeTextRequest { request , error in
			
			guard let observations = request.results as? [VNRecognizedTextObservation], error == nil
			else {
				print(error!)
				return }
			
			let text = observations.compactMap { observation in
				observation.topCandidates(1).first?.string
			}.joined(separator: " ")
			
			completionHandler(text)
		}
		
		request.usesLanguageCorrection = true
		request.automaticallyDetectsLanguage = true
		request.recognitionLevel = .accurate
		request.recognitionLanguages = ["English"]
		
		do {
			try handler.perform([request])
		} catch {
			print(error)
		}
		
		
	}
	
	
}
