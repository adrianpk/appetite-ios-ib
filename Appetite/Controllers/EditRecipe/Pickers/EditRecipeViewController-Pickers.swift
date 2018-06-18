//
//  EditRecipeViewController-Pickers.swift
//  Appetite
//
//  Created by Adrian on 11/17/16.
//  Copyright © 2016 Kuguar. All rights reserved.
//

import UIKit

extension EditRecipeViewController {
  
  func fillPickers() {
    fillUnitPicker()
    fillPreparationTimePicker()
    fillCookingTimePicker()
    fillCategoryPicker()
    fillCuisinePicker()
    fillStylePicker()
    fillLifestylePicker()
  }
  
  func fillUnitPicker() {
    self.unitPicker.delegate = self
    self.unitPicker.dataSource = self
    guard let _ = self.unitPickerData else {
      let units = UnitFinder.all()
      self.unitPickerData = Mapper.extractNames(units: units)
      return
    }
  }
  
  func fillPreparationTimePicker() {
    self.preparationTimePicker.delegate = self
    self.preparationTimePicker.dataSource = self
  }
  
  func fillCookingTimePicker() {
    self.cookingTimePicker.delegate = self
    self.cookingTimePicker.dataSource = self
  }
  
  func fillCategoryPicker() {
    self.categoryPicker.delegate = self
    self.categoryPicker.dataSource = self
    guard let _ = self.categoryPickerData else {
      let categories = ClassificationFinder.all(ofType: App.ClassificationType.category.value)
      self.categoryPickerData = Mapper.extractNames(classifications: categories)
      return
    }
  }
  
  func fillCuisinePicker() {
    self.cuisinePicker.delegate = self
    self.cuisinePicker.dataSource = self
    guard let _ = self.cuisinePickerData else {
      let cuisines = ClassificationFinder.all(ofType: App.ClassificationType.cuisine.value)
      self.cuisinePickerData = Mapper.extractNames(classifications: cuisines)
      return
    }
  }
  
  func fillStylePicker() {
    self.stylePicker.delegate = self
    self.stylePicker.dataSource = self
    guard let _ = self.stylePickerData else {
      let styles = ClassificationFinder.all(ofType: App.ClassificationType.style.value)
      self.stylePickerData = Mapper.extractNames(classifications: styles)
      return
    }
  }
  
  func fillLifestylePicker() {
    self.lifestylePicker.delegate = self
    self.lifestylePicker.dataSource = self
    guard let _ = self.lifestylePickerData else {
      let lifestyles = ClassificationFinder.all(ofType: App.ClassificationType.lifestyle.value)
      self.lifestylePickerData = Mapper.extractNames(classifications: lifestyles)
      return
    }
  }
  
  func hidePickerStacks() {
    self.unitPickerStackView.isHidden = true
    self.preparationTimePickerStackView.isHidden = true
    self.cookingTimePickerStackView.isHidden = true
    self.categoryPickerStackView.isHidden = true
    self.cuisinePickerStackView.isHidden = true
    self.stylePickerStackView.isHidden = true
    self.lifestylePickerStackView.isHidden = true
  }
  
  func resetPickers() {
    self.resetUnitPicker()
    self.resetPreparationTimePicker()
    self.resetCookingTimePicker()
    self.resetCategoryPicker()
    self.resetCookingTimePicker()
    self.resetStylePicker()
    self.resetLifestylePicker()
    self.view.layoutIfNeeded()
  }
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    if pickerView == self.unitPicker {
      return 1
    } else if pickerView == self.preparationTimePicker {
      return 2
    } else if pickerView == self.cookingTimePicker {
      return 2
    } else {
      return 1
    }
  }
  
  // The number of rows of data
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if pickerView == self.unitPicker {
      return self.unitPickerData!.count
    } else if pickerView == self.preparationTimePicker {
      if component == 0 {
        return self.timePickerData[0].count
      } else {
        return self.timePickerData[1].count
      }
    } else if pickerView == self.cookingTimePicker {
      if component == 0 {
        return self.timePickerData[0].count
      } else {
        return self.timePickerData[1].count
      }
    } else if pickerView == self.categoryPicker {
      return self.categoryPickerData!.count
    } else if pickerView == self.cuisinePicker {
      return self.cuisinePickerData!.count
    } else if pickerView == self.stylePicker {
      return self.stylePickerData!.count
    } else if pickerView == self.lifestylePicker {
      return self.lifestylePickerData!.count
    } else {
      return 0
    }
  }
  
  // The data to return for the row and component (column) that's being passed in
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if pickerView == self.unitPicker {
      return self.unitPickerData![row]
    } else if pickerView == self.preparationTimePicker {
      return self.timePickerData[component][row]
    } else if pickerView == self.cookingTimePicker {
      return self.timePickerData[component][row]
    } else if pickerView == self.categoryPicker {
      return self.categoryPickerData![row]
    } else if pickerView == self.cuisinePicker {
      return self.cuisinePickerData![row]
    } else if pickerView == self.stylePicker {
      return self.stylePickerData![row]
    } else if pickerView == self.lifestylePicker {
      return self.lifestylePickerData![row]
    } else {
      return nil
    }
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
    let updater = {
      if pickerView == self.unitPicker {
        self.recipe!.yieldUnit = UnitFinder.find(name: self.unitPickerData![row])
        self.recipe!.yieldUnitName = self.recipe!.yieldUnit!.name
        self.unitButton.setTitle(self.recipe!.yieldUnitName, for: UIControlState.normal)
      
      } else if pickerView == self.preparationTimePicker {
        self.updatePreparationTimeButton(didSelectRow: row, inComponent: component)
        
      } else if pickerView == self.cookingTimePicker {
        self.updateCookingTimeButton(didSelectRow: row, inComponent: component)
        
      } else if pickerView == self.categoryPicker {
        self.recipe!.category = ClassificationFinder.find(byType: App.ClassificationType.category.value, name: self.categoryPickerData![row])
        self.recipe!.categoryName = self.recipe!.category!.name
        self.categoryButton.setTitle(self.recipe!.categoryName, for: UIControlState.normal)
        
      } else if pickerView == self.cuisinePicker {
        self.recipe!.cuisine = ClassificationFinder.find(byType: App.ClassificationType.cuisine.value, name: self.cuisinePickerData![row])
        self.recipe!.cuisineName = self.recipe!.cuisine!.name
        self.cuisineButton.setTitle(self.recipe!.cuisineName, for: UIControlState.normal)
        
      } else if pickerView == self.stylePicker {
        self.recipe!.style = ClassificationFinder.find(byType: App.ClassificationType.style.value, name: self.stylePickerData![row])
        self.recipe!.styleName = self.recipe!.style!.name
        self.styleButton.setTitle(self.recipe!.styleName, for: UIControlState.normal)
        
      } else if pickerView == self.lifestylePicker {
        self.recipe!.lifestyle = ClassificationFinder.find(byType: App.ClassificationType.lifestyle.value, name: self.lifestylePickerData![row])
        self.recipe!.lifestyleName = self.recipe!.lifestyle!.name
        self.lifestyleButton.setTitle(self.recipe!.lifestyleName, for: UIControlState.normal)
        
      } else {
        //return nil
      }
    }
    RecipeManager.update(self.recipe!, updater: updater)
  }
  
  func updatePreparationTimeButton(didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      self.recipe!.preparationTimeHours = Converter.toInt(self.timePickerData[component][row])
    } else if component == 1 {
      self.recipe!.preparationTimeMinutes = Converter.toInt(self.timePickerData[component][row])
    }
    let title = self.recipe!.formattedPreparationTime()
    if(title != Recipe.zeroFormattedTime()) {
      self.preparationTimeButton.setTitle(title, for: UIControlState.normal)
    } else {
      self.preparationTimeButton.setTitle(I18N.Text.preparation.value, for: UIControlState.normal)
    }
  }
  
  func updateCookingTimeButton(didSelectRow row: Int, inComponent component: Int) {
    if component == 0 {
      self.recipe!.cookingTimeHours = Converter.toInt(self.timePickerData[component][row])
    } else if component == 1 {
      self.recipe!.cookingTimeMinutes = Converter.toInt(self.timePickerData[component][row])
    }
    let title = self.recipe!.formattedCookingTime()
    if(title != Recipe.zeroFormattedTime()) {
      self.cookingTimeButton.setTitle(title, for: UIControlState.normal)
    } else {
      self.cookingTimeButton.setTitle(I18N.Text.cooking.value, for: UIControlState.normal)
    }
  }
  
  // Unit Picker
  @IBAction func showUnitPickerStack(_ sender: Any) {
    self.hidePickerStacks()
    self.unitPickerStackView.isHidden = false
  }
  
  @IBAction func closeUnitPickerStack(_ sender: Any) {
    self.unitPickerStackView.isHidden = true
  }
  
  func resetUnitPicker() {
    self.unitButton.titleLabel!.text = I18N.Text.unit.value
    self.unitPicker.selectRow(0, inComponent: 0, animated: false)
  }
  
  // Preparation Time Picker
  @IBAction func showPreparationTimeStackView(_ sender: Any) {
    self.hidePickerStacks()
    self.preparationTimePickerStackView.isHidden = false
  }
  
  @IBAction func closePreparationTimeStackView(_ sender: Any) {
    self.preparationTimePickerStackView.isHidden = true
  }
  
  func resetPreparationTimePicker() {
    self.preparationTimeButton.titleLabel!.text = I18N.Text.preparation.value
    self.preparationTimePicker.selectRow(0, inComponent: 0, animated: false)
    self.preparationTimePicker.selectRow(0, inComponent: 1, animated: false)
  }
  
  // Cooking Time Picker
  @IBAction func showCookingTimeStackView(_ sender: Any) {
    self.hidePickerStacks()
    self.cookingTimePickerStackView.isHidden = false
  }
  
  @IBAction func closeCookingTimeStackView(_ sender: Any) {
    self.cookingTimePickerStackView.isHidden = true
  }
  
  func resetCookingTimePicker() {
    self.cookingTimeButton.titleLabel!.text = I18N.Text.cooking.value
    self.cookingTimePicker.selectRow(0, inComponent: 0, animated: false)
    self.cookingTimePicker.selectRow(0, inComponent: 1, animated: false)
  }
  
  // Category Stack View
  @IBAction func showCategoryStackView(_ sender: Any) {
    self.hidePickerStacks()
    self.categoryPickerStackView.isHidden = false
  }
  
  @IBAction func closeCategoryStackView(_ sender: Any) {
    self.categoryPickerStackView.isHidden = true
  }
  
  func resetCategoryPicker() {
    self.categoryButton.titleLabel!.text = I18N.Text.category.value
    self.categoryPicker.selectRow(0, inComponent: 0, animated: false)
  }
  
  // Cuisine Stack View
  @IBAction func showCuisineStackView(_ sender: Any) {
    self.hidePickerStacks()
    self.cuisinePickerStackView.isHidden = false
  }
  
  @IBAction func closeCuisineStackView(_ sender: Any) {
    self.cuisinePickerStackView.isHidden = true
  }
  
  func resetCuisinePicker() {
    self.cuisineButton.titleLabel!.text = I18N.Text.cuisine.value
    self.cuisinePicker.selectRow(0, inComponent: 0, animated: false)
  }
  
  // Style Stack View
  @IBAction func showStyleStackView(_ sender: Any) {
    self.hidePickerStacks()
    self.stylePickerStackView.isHidden = false
  }
  
  @IBAction func closeStylePicker(_ sender: Any) {
    self.stylePickerStackView.isHidden = true
  }

  func resetStylePicker() {
    self.styleButton.titleLabel!.text = I18N.Text.style.value
    self.stylePicker.selectRow(0, inComponent: 0, animated: false)
  }
  
  // Lifestyle
  @IBAction func showLifestyleStackView(_ sender: Any) {
    self.hidePickerStacks()
    self.lifestylePickerStackView.isHidden = false
  }
  
  @IBAction func closeLifestyleStackView(_ sender: Any) {
    self.lifestylePickerStackView.isHidden = true
  }
  
  func resetLifestylePicker() {
    self.lifestyleButton.titleLabel!.text = I18N.Text.lifestyle.value
    self.lifestylePicker.selectRow(0, inComponent: 0, animated: false)
  }
  
}
