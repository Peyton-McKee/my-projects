//
//  ClassifyFindingsViewController.swift
//  RescueLungSociety
//
//  Created by Peyton McKee on 10/30/21.
//

import UIKit

class ClassifyFindingsViewController: UIViewController {

    @IBOutlet var findingTypesScrollView: UIScrollView!
   
    @IBOutlet var findingTypesClassificationsScrollView: UIScrollView!
    @IBOutlet var firstHistoryButton: UIButton!
    @IBOutlet var firstHistoryLabel: UILabel!
    @IBOutlet var secondHistoryButton: UIButton!
    @IBOutlet var secondHistoryLabel: UILabel!
    @IBOutlet var thirdHistoryButton: UIButton!
    @IBOutlet var negativeClassificationStackView: UIStackView!
    @IBOutlet var benign2ClassificationStackView: UIStackView!
    @IBOutlet var negativeDetailsClassificationStackView: UIStackView!
    
    @IBOutlet var incompleteStackView: UIStackView!
    
    @IBOutlet var benign2StackView: UIStackView!
    
    @IBOutlet var benign2iStackView: UIStackView!

    @IBOutlet var probablyBenignStackView: UIStackView!
   
    @IBOutlet var suspiciousStackView: UIStackView!
    
    @IBOutlet var lungCancerStackView: UIStackView!
    @IBOutlet var findingsTypeStackView: UIStackView!
    
    @IBOutlet var negativeStackView: UIStackView!
  
    @IBOutlet var incompleteDetailsClassificationStackView: UIStackView!
    
    @IBOutlet var benign2DetailsClassificationStackView: UIStackView!
    
    @IBOutlet var benign2iDetailsClassificationStackView: UIStackView!
    
    @IBOutlet var classificationButtonsStackView: UIStackView!
    
    @IBOutlet var probablyBenignDetailsClassificationStackView: UIStackView!
    
    @IBOutlet var suspiciousDetailsClassificationStackView: UIStackView!
    @IBOutlet var lungCancerDetailsClassificationStackView: UIStackView!
    @IBOutlet var noduleTypeStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideApplicableCategoryResults()
        
        hideApplicableCategoryDetails()
        
        findingTypesClassificationsScrollView.isHidden = true
        // Do anyadditional setup after loading the view.
    }
    
    func hideApplicableCategoryDetails()
    {
        incompleteStackView.isHidden = true
        
        negativeStackView.isHidden = true
        
        benign2StackView.isHidden = true
        
        suspiciousStackView.isHidden = true
       
        benign2iStackView.isHidden = true
        
        lungCancerStackView.isHidden = true
        
        probablyBenignStackView.isHidden = true
        
        negativeDetailsClassificationStackView.isHidden = true
        
        incompleteDetailsClassificationStackView.isHidden = true
        
        benign2DetailsClassificationStackView.isHidden = true
        
        benign2iDetailsClassificationStackView.isHidden = true
        
        probablyBenignDetailsClassificationStackView.isHidden = true
        
        suspiciousDetailsClassificationStackView.isHidden = true
        
        lungCancerDetailsClassificationStackView.isHidden = true
    }
    func hideApplicableCategoryResults()
    {
        negativeClassificationStackView.isHidden = true
        
        benign2ClassificationStackView.isHidden = true
        
    }
    
    @IBAction func noFindingsButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        hideApplicableCategoryResults()
        
        findingTypesScrollView.isHidden = true
        
        findingTypesClassificationsScrollView.isHidden = false
        
        negativeClassificationStackView.isHidden = false
        
        firstHistoryButton.setTitle("No Findings", for: .normal)
        
        secondHistoryButton.setTitle("", for: .normal)
        
        thirdHistoryButton.setTitle("", for: .normal)
        
        firstHistoryLabel.text = ""
        
        secondHistoryLabel.text = ""
    }
    @IBAction func calcifiedPulmonaryGranulomaButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryResults()
        
        hideApplicableCategoryDetails()
        
        findingTypesScrollView.isHidden = true
        
        findingTypesClassificationsScrollView.isHidden = false
       
        benign2ClassificationStackView.isHidden = false
        
        firstHistoryButton.setTitle("Calcified Pulmonary Granuloma", for: .normal)
        
        secondHistoryButton.setTitle("", for: .normal)
        
        thirdHistoryButton.setTitle("", for: .normal)
        
        firstHistoryLabel.text = ""
        
        secondHistoryLabel.text = ""
        
    }
    @IBAction func microNoduleButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryResults()
        
        hideApplicableCategoryDetails()
        
        findingTypesScrollView.isHidden = true
        
        findingTypesClassificationsScrollView.isHidden = false
        
        benign2ClassificationStackView.isHidden = false
        
        firstHistoryButton.setTitle("Micro Nodule", for: .normal)
        
        secondHistoryButton.setTitle("", for: .normal)
        
        thirdHistoryButton.setTitle("", for: .normal)
        
        firstHistoryLabel.text = ""
        
        secondHistoryLabel.text = ""
    }
    
    @IBAction func firstHistoryButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryResults()
        
        findingTypesClassificationsScrollView.isHidden = true
        
        findingTypesScrollView.isHidden = false
    }
    
    @IBAction func noduleButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
       
        hideApplicableCategoryResults()
        
        findingTypesScrollView.isHidden = true
        
        findingTypesClassificationsScrollView.isHidden = false
        
       // noduleTypeStackView.isHidden = false
        
        firstHistoryButton.setTitle("Nodules", for: .normal)
        
        secondHistoryButton.setTitle("", for: .normal)
        
        thirdHistoryButton.setTitle("", for: .normal)
        
        firstHistoryLabel.text = ""
        
        secondHistoryLabel.text = ""
    }
    @IBAction func nonNondularFindingsButtonPressed(_ sender: UIButton) {
        
    }
    @IBAction func incompleteButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
       
        incompleteStackView.isHidden = false
    }
    @IBAction func negativeButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
       
        negativeStackView.isHidden = false
    }
    @IBAction func benign2ButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        benign2StackView.isHidden = false
    }
    @IBAction func benign2iButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        benign2iStackView.isHidden = false
    }
    @IBAction func probablyBenignButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        probablyBenignStackView.isHidden = false
    }
    @IBAction func suspiciousButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        suspiciousStackView.isHidden = false
    }
    @IBAction func lungCancerButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        lungCancerStackView.isHidden = false
    }
    @IBAction func hideDetailsButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
    }
    @IBAction func negativeClassificationButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        negativeDetailsClassificationStackView.isHidden = false
    }
    @IBAction func incompleteClassificationButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        incompleteDetailsClassificationStackView.isHidden = false
    }
    @IBAction func benign2ClassificationButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        benign2DetailsClassificationStackView.isHidden = false
    }
    
    @IBAction func benign2iClassificationButton(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        benign2iDetailsClassificationStackView.isHidden = false
    }
    @IBAction func probablyBenignClassificationButton(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        probablyBenignDetailsClassificationStackView.isHidden = false
    }
    @IBAction func suspiciousClassificationButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        suspiciousDetailsClassificationStackView.isHidden = false
    }
    @IBAction func lungCancerClassificationButtonPressed(_ sender: UIButton) {
        hideApplicableCategoryDetails()
        
        lungCancerDetailsClassificationStackView.isHidden = false
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
