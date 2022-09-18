//
//  CategoryDetailsViewController.swift
//  RescueLungSociety
//
//  Created by Peyton McKee on 10/28/21.
//

import UIKit

class CategoryDetailsViewController: UIViewController {

    @IBOutlet var lungCancerScrollView: UIScrollView!
    @IBOutlet var significantIncidentalScrollView: UIScrollView!
    @IBOutlet var suspiciousScrollView: UIScrollView!
    @IBOutlet var probablyBenignScrollView: UIScrollView!
    @IBOutlet var benign2iScrollView: UIScrollView!
    @IBOutlet var benign2ScrollView: UIScrollView!
    @IBOutlet var negativeScrollView: UIScrollView!
    @IBOutlet var incompleteScrollView: UIScrollView!
    @IBOutlet var lungCancerPortrait: UIStackView!
    @IBOutlet var signifcantIncidentalPortrait: UIStackView!
    @IBOutlet var probablyBenignPortrait: UIStackView!
    @IBOutlet var suspiciousPortrait: UIStackView!
    @IBOutlet var categoryController: UIStackView!
    @IBOutlet var categoryList: UIStackView!
    @IBOutlet var incompletePortrait: UIStackView!
    @IBOutlet var negativePortrait: UIStackView!
    @IBOutlet var benign2Portrait: UIStackView!
    @IBOutlet var benign2Landscape: UIStackView!
    @IBOutlet var benign2iPortrait: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }
    func updateUI()
    {
        categoryController.isHidden = true
        incompleteScrollView.isHidden = true
        negativeScrollView.isHidden = true
        benign2ScrollView.isHidden = true
        suspiciousScrollView.isHidden = true
        probablyBenignScrollView.isHidden = true
        significantIncidentalScrollView.isHidden = true
        benign2iScrollView.isHidden = true
        lungCancerScrollView.isHidden = true
        
    }
    @IBAction func incompleteButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        incompleteScrollView.isHidden = false
        
    }
    @IBAction func negativeButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        negativeScrollView.isHidden = false
    }
    @IBAction func benign2ButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        benign2ScrollView.isHidden = false
    }
    @IBAction func backButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = false
    }
    @IBAction func benign2iButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        benign2iScrollView.isHidden = false
    }
    @IBAction func probablyBenignButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        probablyBenignScrollView.isHidden = false
    }
    @IBAction func suspiciousButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        suspiciousScrollView.isHidden = false
    }
    @IBAction func significantIncidentalButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        significantIncidentalScrollView.isHidden = false
    }
    @IBAction func luncCancerButtonPressed(_ sender: UIButton) {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        lungCancerScrollView.isHidden = false
    }
    func selcetedButton(_ buttonName: Any)
    {
        updateUI()
        categoryList.isHidden = true
        categoryController.isHidden = false
        //buttonName.isHidden = false
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
