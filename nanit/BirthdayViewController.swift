//
//  BirthdayViewController.swift
//  nanit
//
//  Created by Loren Raz on 12/03/2024.
//

import UIKit

class BirthdayViewController: UIViewController {
	
	@IBOutlet weak var titleLbl: UILabel!
	@IBOutlet weak var yearsOld: UILabel!
	@IBOutlet weak var ageImg: UIImageView!
	@IBOutlet weak var babyImg: UIImageView!
	@IBOutlet weak var cameraImg: UIImageView!
	@IBOutlet weak var shareBtn: UIButton!
	
	let backImg = UIImageView()
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		initRandomBG()
		initElements()
		initBackBtn()
		initCameraIcon()
		initShareBtn()
    }
	
	func initRandomBG() {
		view.addSubview(backImg)
		backImg.translatesAutoresizingMaskIntoConstraints = false
		backImg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		backImg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		backImg.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		backImg.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		view.sendSubviewToBack(backImg)
		
		let randomNumber = Int(arc4random_uniform(3))
				
		switch randomNumber {
		case 0:
			backImg.image = UIImage(named: "BG_Pelican")
			babyImg.image = UIImage(named: "smileBlue")
			self.view.backgroundColor = UIColor(red: 0.85, green: 0.94, blue: 0.96, alpha: 1.0)
			cameraImg.image = UIImage(named: "cameraBlue")
		case 1:
			backImg.image = UIImage(named: "BG_Fox")
			babyImg.image = UIImage(named: "smileGreen")
			self.view.backgroundColor = UIColor(red: 0.77, green: 0.9, blue: 0.87, alpha: 1.0)
			cameraImg.image = UIImage(named: "cameraGreen")
		case 2:
			backImg.image = UIImage(named: "BG_Elephant")
			babyImg.image = UIImage(named: "smileYellow")
			self.view.backgroundColor = UIColor(red: 0.99, green: 0.93, blue: 0.79, alpha: 1.0)
			cameraImg.image = UIImage(named: "cameraYellow")
		default:
			break
		}
	}
	
	func initElements() {
		let savedName = defaults.string(forKey: "name")!
		let savedDate = UserDefaults.standard.object(forKey: "birthday") as? Date
		let currentDate = Date()
		
		titleLbl.text = "TODAY \(savedName.uppercased()) IS"
		
		let calendar = Calendar.current
		let components = calendar.dateComponents([.year, .month], from: savedDate!, to: currentDate)
		
		let years = components.year ?? 0
		let month = components.month ?? 0
		
		yearsOld.text = years == 0 ? (month == 1 ? "MONTH OLD!" : "MONTHS OLD!") : "YEARS OLD!"
		
		setMonthImg(month)
		
		babyImg.contentMode = .scaleAspectFill
		babyImg.layer.cornerRadius = babyImg.frame.width / 2
		babyImg.clipsToBounds = true
		view.sendSubviewToBack(babyImg)
		
		if let imageData = UserDefaults.standard.data(forKey: "babyImageData"),
			let savedImage = UIImage(data: imageData) {
			babyImg.image = savedImage
		}
	}
	
	func initBackBtn() {
		let backButtonImage = UIImage(named: "back")
		let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(onBackBtnClick))
		navigationController?.navigationBar.tintColor = UIColor.black
		navigationItem.leftBarButtonItem = backButton
	}
	
	func initCameraIcon() {
		cameraImg.translatesAutoresizingMaskIntoConstraints = false
		cameraImg.frame.size = CGSize(width: 36, height: 36)
		
		let angleInRadians = CGFloat.pi / 4
		let distanceFromCenter = babyImg.frame.width / 2
		let xPosition = distanceFromCenter * cos(angleInRadians)
		let yPosition = distanceFromCenter * sin(angleInRadians)
		
		NSLayoutConstraint.activate([
			cameraImg.centerXAnchor.constraint(equalTo: babyImg.centerXAnchor, constant: xPosition),
			cameraImg.centerYAnchor.constraint(equalTo: babyImg.centerYAnchor, constant: -yPosition)
		])
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCameraIconClick))
		cameraImg.isUserInteractionEnabled = true
		cameraImg.addGestureRecognizer(tapGesture)
	}
	
	func initShareBtn() {
		shareBtn.backgroundColor = UIColor(red: 0.93, green: 0.48, blue: 0.48, alpha: 1)
		shareBtn.layer.cornerRadius = shareBtn.frame.size.height / 2
		shareBtn.setTitle("Share the news ", for: .normal)
		shareBtn.setImage(UIImage(named: "share"), for: .normal)
		shareBtn.setTitleColor(.white, for: .normal)
		shareBtn.semanticContentAttribute = .forceRightToLeft
		shareBtn.setTitleColor(shareBtn.titleColor(for: .normal), for: .highlighted)
		
		shareBtn.addTarget(self, action: #selector(onShareBtnClick), for: .touchUpInside)
	}
	
	@objc func onBackBtnClick() {
		navigationController?.popViewController(animated: true)
	}
	
	@objc func onCameraIconClick() {
		ImagePickerHelper.showMenu(from: self)
	}
	
	@objc func onShareBtnClick() {
		shareBtn.isHidden = true
		cameraImg.isHidden = true
		
		let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
		let image = renderer.image { rendererContext in
			view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
		}

		let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
		present(activityViewController, animated: true) {
			self.shareBtn.isHidden = false
			self.cameraImg.isHidden = false
			self.backImg.isHidden = false
		}
	}
	
	func setMonthImg(_ month: Int) {
		switch month {
		case 0: ageImg.image = UIImage(named: "age0")
		case 1: ageImg.image = UIImage(named: "age1")
		case 2: ageImg.image = UIImage(named: "age2")
		case 3: ageImg.image = UIImage(named: "age3")
		case 4: ageImg.image = UIImage(named: "age4")
		case 5: ageImg.image = UIImage(named: "age5")
		case 6: ageImg.image = UIImage(named: "age6")
		case 7: ageImg.image = UIImage(named: "age7")
		case 8: ageImg.image = UIImage(named: "age8")
		case 9: ageImg.image = UIImage(named: "age0")
		case 10: ageImg.image = UIImage(named: "age10")
		case 11: ageImg.image = UIImage(named: "age11")
		case 12: ageImg.image = UIImage(named: "age12")
		default: ageImg.image = UIImage(named: "age0")
		}
	}

}


// MARK: - ImagePicker

extension BirthdayViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			babyImg.image = selectedImage
			
			if let image = babyImg.image,
				let imageData = image.jpegData(compressionQuality: 1.0) {
				UserDefaults.standard.set(imageData, forKey: "babyImageData")
			}
		}
		picker.dismiss(animated: true, completion: nil)
	}
	
	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		picker.dismiss(animated: true, completion: nil)
	}
}
