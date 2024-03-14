//
//  Extras.swift
//  nanit
//
//  Created by Loren Raz on 14/03/2024.
//

import Foundation
import UIKit

struct ImagePickerHelper {
		
	static func showMenu(from viewController: UIViewController) {
		let alertController = UIAlertController()
		
		let takePhotoAction = UIAlertAction(title: "Take Photo", style: .default) { (action) in
			takePhoto(from: viewController)
		}
		alertController.addAction(takePhotoAction)
		
		let openGalleryAction = UIAlertAction(title: "Open Gallery", style: .default) { (action) in
			openGallery(from: viewController)
		}
		alertController.addAction(openGalleryAction)
		
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		alertController.addAction(cancelAction)
		
		viewController.present(alertController, animated: true, completion: nil)
	}
	
	private static func takePhoto(from viewController: UIViewController) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = viewController as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
		imagePicker.sourceType = .camera
		viewController.present(imagePicker, animated: true, completion: nil)
	}
		
	private static func openGallery(from viewController: UIViewController) {
		let imagePicker = UIImagePickerController()
		imagePicker.delegate = viewController as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
		imagePicker.sourceType = .photoLibrary
		viewController.present(imagePicker, animated: true, completion: nil)
	}
}
