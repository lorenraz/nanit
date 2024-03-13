//
//  DetailsViewController.swift
//  nanit
//
//  Created by Loren Raz on 12/03/2024.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var nextBtn: UIButton!
	@IBOutlet weak var date: UIDatePicker!
	@IBOutlet weak var pickImgBtn: UIButton!
	@IBOutlet weak var image: UIImageView!
	
	let defaults = UserDefaults.standard
		
	override func viewDidLoad() {
        super.viewDidLoad()
		
		if let savedName = defaults.string(forKey: "name") {
			name.text = savedName
		}
		
		if let savedDate = UserDefaults.standard.object(forKey: "birthday") as? Date {
			date.date = savedDate
		}
		
		if let imageData = UserDefaults.standard.data(forKey: "imageData"),
			let savedImage = UIImage(data: imageData) {
			image.image = savedImage
		} else {
			image.image = UIImage(named: "catImg")
		}
		
		nextBtn.isEnabled = !name.text!.isEmpty
		
		pickImgBtn.addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
	}

	@IBAction func onNameChange(_ sender: Any) {
		nextBtn.isEnabled = !name.text!.isEmpty
	}
	
	@IBAction func onDateChange(_ sender: Any) {}
	
	@IBAction func onPickImgBtn(_ sender: Any) {}
	
	@IBAction func onNextBtn(_ sender: Any) {
		defaults.set(name.text, forKey: "name")
		defaults.set(date.date, forKey: "birthday")
		
		if let image = image.image,
			let imageData = image.jpegData(compressionQuality: 1.0) {
			UserDefaults.standard.set(imageData, forKey: "imageData")
		}
	}
	
	@objc func menuButtonTapped() {
		let alertController = UIAlertController()
		
		let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
			self.takePhoto()
		}
		alertController.addAction(takePhotoAction)
		
		let openGalleryAction = UIAlertAction(title: "Open Gallery", style: .default) { (action) in
			self.openGallery()
		}
		alertController.addAction(openGalleryAction)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(cancelAction)
		
		present(alertController, animated: true, completion: nil)
	}
	
	func takePhoto() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .camera
		present(imagePicker, animated: true, completion: nil)
	}
		
	func openGallery() {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)
	}
}

// MARK: - ImagePicker

extension DetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			image.image = selectedImage
		}
		picker.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
}
