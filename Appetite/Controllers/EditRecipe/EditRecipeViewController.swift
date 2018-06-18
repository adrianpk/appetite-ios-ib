//
//  EditRecipeViewController.swift
//  Appetite
//
//  Created by Adrian on 11/15/16.
//  Copyright © 2016 Kuguar. All rights reserved.
//

import UIKit
import RealmSwift
import Controls

class EditRecipeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, RecipeControllerDelegate {

  
  @IBOutlet weak var statusBar: StatusBar!
  // Fields
  @IBOutlet weak var clearRecipeButton: UIBarButtonItem!
  @IBOutlet weak var cookbookTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var infoTextView: UITextView!
  @IBOutlet weak var yieldQuantityTextField: UITextField!
  @IBOutlet weak var unitButton: Button!
  @IBOutlet weak var preparationTimeButton: Button!
  @IBOutlet weak var cookingTimeButton: Button!
  // Image
  @IBOutlet weak var imageStackView: UIStackView!
  @IBOutlet weak var takePictureImageButton: Button!
  @IBOutlet weak var selectImageButton: Button!
  @IBOutlet weak var deleteImageButton: Button!
  // More
  @IBOutlet weak var moreStackView: UIStackView!
  // Fields
  @IBOutlet weak var authorTextField: UITextField!
  @IBOutlet weak var sourceTextField: UITextField!
  @IBOutlet weak var sourceURLTextField: UITextField!
  @IBOutlet weak var tagsTextField: UITextField!
  @IBOutlet weak var notesTextView: UITextView!
  // Pickers
  @IBOutlet weak var unitPicker: UIPickerView!
  @IBOutlet weak var preparationTimePicker: UIPickerView!
  @IBOutlet weak var cookingTimePicker: UIPickerView!
  @IBOutlet weak var categoryPicker: UIPickerView!
  @IBOutlet weak var cuisinePicker: UIPickerView!
  @IBOutlet weak var stylePicker: UIPickerView!
  @IBOutlet weak var lifestylePicker: UIPickerView!
  // Picker Stack Views
  @IBOutlet weak var unitPickerStackView: UIStackView!
  @IBOutlet weak var preparationTimePickerStackView: UIStackView!
  @IBOutlet weak var cookingTimePickerStackView: UIStackView!
  @IBOutlet weak var categoryPickerStackView: UIStackView!
  @IBOutlet weak var cuisinePickerStackView: UIStackView!
  @IBOutlet weak var stylePickerStackView: UIStackView!
  @IBOutlet weak var lifestylePickerStackView: UIStackView!
  // Classification
  @IBOutlet weak var categoryButton: Button!
  @IBOutlet weak var cuisineButton: Button!
  @IBOutlet weak var styleButton: Button!
  @IBOutlet weak var lifestyleButton: Button!
  // Ingredients & Directions
  @IBOutlet weak var ingredientsButton: Button!
  @IBOutlet weak var directionsButton: Button!
  // Constraints
  @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
  // Validations
  var status: [Status] = []
  // Model and View
  var recipe: Recipe?
  // Data for Pickers
  var unitPickerData: [String]?
  var timePickerData = [Constant.ListData.hours.value, Constant.ListData.minutes_5.value]
  var categoryPickerData: [String]?
  var cuisinePickerData: [String]?
  var stylePickerData: [String]?
  var lifestylePickerData: [String]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupNavigationBar()
    self.fillPickers()
    self.hidePickerStacks()
    self.setupImageRelatedViews()
    //self.toggleMoreStackView(animate: false)
    self.setupNewRecipe()
    // MARK: - Mock Data (delete on production)
    self.loadMockRecipe()
    //self.setMockStatus()
    // MARK: - Update form
    self.updateFormWithRecipeValues()
    self.view.layoutIfNeeded()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.handleDelegate()
  }
  
  func loadMockRecipe() {
    self.recipe = RecipeFinder.find(name: "Lasagna")
  }
  
  func setMockStatus() {
    let message1 = Status(message: "Ha sucedido un error.", kind: .error)
    let message2 = Status(message: "También este.", kind: .error)
    self.status.append(message1)
    self.status.append(message2)
  }
  
  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
  }

  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Name.Segue.showIngredientsTable.value {
      if let vc = segue.destination as? IngredientsTableViewController {
        //vc.appStatus = (AppStatus(message: "Updated!", type: StatusType.info))
        vc.delegate = self
      }
    }
  }
  
  func setupNavigationBar() {
    setupNavigationBarTitle()
  }
  
  func setupNavigationBarTitle() {
    self.navigationItem.title = "Edit Recipe"
  }
  
  func setupNewRecipe() {
    self.recipe = RecipeManager.create()
  }
  
  @IBAction func clearRecipe(_ sender: Any) {
    self.setupNewRecipe()
    self.clearRecipeForm()
  }
  
  func clearRecipeForm() {
    self.cookbookTextField.text = nil
    self.nameTextField.text = nil
    self.yieldQuantityTextField.text = nil
    self.resetPickers()
  }
  
  @IBAction func saveRecipe(_ sender: Any) {
    RealmManager.save(self.recipe!, updater: getRecipeWithFormValuesUpdater())
  }
  
  func getRecipeWithFormValuesUpdater() -> () -> Void {
    return self.updateRecipeWithFormValues
  }
  
  func updateRecipeWithFormValues() {
    if let recipe = self.recipe {
      recipe.cookbook = self.cookbookTextField.text!
      recipe.name = self.nameTextField.text!
      recipe.info = self.infoTextView.text!
      recipe.yieldValue = Converter.toDouble(self.yieldQuantityTextField.text!)
      recipe.author = self.authorTextField.text!
      recipe.source = self.sourceTextField.text!
      recipe.sourceURL = self.sourceURLTextField.text!
      recipe.notes = self.notesTextView.text!
      recipe.defaultsForCreate()
    }
  }
  
  func updateFormWithRecipeValues() {
    if let recipe = self.recipe {
      self.cookbookTextField.text = recipe.cookbook
      self.nameTextField.text = recipe.name
      self.infoTextView.text = recipe.info
      self.yieldQuantityTextField.text = "\(recipe.yieldValue)"
      self.authorTextField.text = recipe.author
      self.sourceTextField.text = recipe.source
      self.sourceURLTextField.text = recipe.sourceURL
      self.notesTextView.text = recipe.notes
    }
  }

  @IBAction func goToAddIngredientsTable(_ sender: Any) {
    self.performSegue(withIdentifier: Name.Segue.showIngredientsTable.value, sender: sender)
  }
  
  @IBAction func goToAddDirectionsTable(_ sender: Any) {
    self.performSegue(withIdentifier: Name.Segue.showDirectionsTable.value, sender: sender)
  }
  
  // MARK: Delegate
  // MARK: - Delegate related
  func handleDelegate() {
    self.processStatus()
  }
  
  internal func getRecipe() -> Recipe {
    return self.recipe!
  }
  
  internal func getSelectedIngredient() -> Ingredient? {
    return nil
  }
  
  internal func setStatus(status: [Status]) {
    self.status = status
  }
  
  internal func getStatus() -> [Status] {
    return self.status
  }
  
  func completed(recipe: Recipe) {
    //
  }

}
