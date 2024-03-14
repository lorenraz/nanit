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
	@IBOutlet weak var backgroundImg: UIImageView!
	
	let defaults = UserDefaults.standard
		
	override func viewDidLoad() {
        super.viewDidLoad()
		
		initRandomBG()
		initialize()
		initBackBtn()
    }
	
	func initRandomBG() {
		let randomNumber = Int(arc4random_uniform(3))
				
		switch randomNumber {
		case 0:
			backgroundImg.image = UIImage(named: "BG_Pelican")
			babyImg.image = UIImage(named: "smileBlue")
			self.view.backgroundColor = UIColor(red: 0.85, green: 0.94, blue: 0.96, alpha: 1.0)
		case 1:
			backgroundImg.image = UIImage(named: "BG_Fox")
			babyImg.image = UIImage(named: "smileGreen")
			self.view.backgroundColor = UIColor(red: 0.77, green: 0.9, blue: 0.87, alpha: 1.0)
		case 2:
			backgroundImg.image = UIImage(named: "BG_Elephant")
			babyImg.image = UIImage(named: "smileYellow")
			self.view.backgroundColor = UIColor(red: 0.99, green: 0.93, blue: 0.79, alpha: 1.0)
		default:
			break
		}
	}
	
	func initialize() {
		let savedName = defaults.string(forKey: "name")!
		let savedDate = UserDefaults.standard.object(forKey: "birthday") as? Date
		let currentDate = Date()
		
		titleLbl.text = "TODAY \(savedName.uppercased()) IS"
		
		let calendar = Calendar.current
		let components = calendar.dateComponents([.year, .month], from: savedDate!, to: currentDate)
		
		let years = components.year ?? 0
		let month = components.month ?? 0
		
		yearsOld.text = years == 0 ? "MONTH OLD" : "YEARS OLD"
		
		setMonthImg(month)
	}
	
	func initBackBtn() {
		let backButtonImage = UIImage(named: "back")
		let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(backButtonTapped))
		navigationController?.navigationBar.tintColor = UIColor.black
		navigationItem.leftBarButtonItem = backButton
	}
	
	@objc func backButtonTapped() {
		navigationController?.popViewController(animated: true)
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
