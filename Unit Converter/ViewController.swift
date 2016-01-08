//
//  ViewController.swift
//  Unit Converter
//
//  Created by rziolkowski on 9/23/15.
//  Copyright © 2015 rziolkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource, UITextFieldDelegate{
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var unitLabel: UILabel!
    @IBOutlet weak var conversionPicker: UIPickerView!
    @IBOutlet weak var firstUnitPicker: UIPickerView!
    @IBOutlet weak var secondUnitPicker: UIPickerView!
    
    var firstNumber = 0.0
    var secondNumber = 0.0
    var currentConversion = "Length"
    var firstUnit = "Kilometer"
    var secondUnit = "Kilometer"
    
    
    let pickerData = ["Length", "Speed", "Time", "Temperature", "Volume", "Weight"]
    
    let lengthUnits = ["Kilometer", "Meter", "Centimeter", "Millimeter", "Mile", "Yard", "Foot", "Inch"]
    let shortLengthUnits = ["Km", "m", "cm", "mm", "Mi", "yd", "ft", "in"]
    
    let speedUnits = ["Miles/Hour", "Feet/Sec", "Meters/Sec", "Km/Hour"]
    let shortSpeedUnits = ["mph", "fps", "mps", "kph"]
    
    let temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"]
    let shortTemperatureUnits = ["°C", "°F", "K"]
    
    let timeUnits = ["Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year"]
    let shortTimeUnits = ["ms", "sec", "min", "hr.", "day", "wk.", "mo.", "yr."]
    
    let volumeUnits = ["US gal", "US quart", "US pint", "US cup", "US oz", "US tbsp", "US tsp", "Liter", "Millileter",
        "Meter^3", "Centimeter^3", "Foot^3", "Inch^3"]
    let shortVolumeUnits = ["gal", "qt", "pt", "c", "oz", "tbsp", "tsp", "l", "ml", "m^3", "cm^3", "ft^3", "in^3"]
    
    let weightUnits = ["Kilogram", "Gram", "Milligram", "Pound", "Ounce"]
    let shortWeightUnits = ["Kg", "g", "mg", "lb", "oz"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "orange_bg")!)
        conversionPicker.dataSource = self
        conversionPicker.delegate = self
        firstUnitPicker.dataSource = self
        firstUnitPicker.delegate = self
        secondUnitPicker.dataSource = self
        secondUnitPicker.delegate = self
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
        unitLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "dismissKeyboard"))
        calculate()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
    
    func dismissKeyboard(){
        inputTextField.resignFirstResponder()
        firstNumber = (NSString(UTF8String: inputTextField.text!)?.doubleValue)!
        calculate()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == conversionPicker{
            return pickerData.count
        }
            
        else{
            switch currentConversion{
            case "Length":
                return lengthUnits.count
            case "Speed":
                return speedUnits.count
            case "Temperature":
                return temperatureUnits.count
            case "Time":
                return timeUnits.count
            case "Volume":
                return volumeUnits.count
            case "Weight":
                return weightUnits.count
            default:
                currentConversion = "Length"
                return lengthUnits.count
            }
        }
    }
    
    
    //Sets all of the titles for each of the rows in the different pickerviews
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == conversionPicker{
            return pickerData[row]
        }
        else{
            switch currentConversion{
            case "Length":
                return lengthUnits[row]
            case "Speed":
                return speedUnits[row]
            case "Temperature":
                return temperatureUnits[row]
            case "Time":
                return timeUnits[row]
            case "Volume":
                return volumeUnits[row]
            case "Weight":
                return weightUnits[row]
            default:
                currentConversion = "Length"
                return temperatureUnits[row]
            }
        }
    }
    
    //Gets called everytime a pickerview gets selected or changed, it calls calculate then inserts the answer onto the label.
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if pickerView == conversionPicker
        {
            currentConversion = pickerData[row]
            firstUnitPicker.reloadAllComponents()
            secondUnitPicker.reloadAllComponents()
        }
        switch currentConversion{
        case "Length":
            firstUnit = lengthUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = lengthUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortLengthUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortLengthUnits[secondUnitPicker.selectedRowInComponent(0)])"
        case "Speed":
            firstUnit = speedUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = speedUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortSpeedUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortSpeedUnits[secondUnitPicker.selectedRowInComponent(0)])"
        case "Temperature":
            firstUnit = temperatureUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = temperatureUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortTemperatureUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortTemperatureUnits[secondUnitPicker.selectedRowInComponent(0)])"
        case "Time":
            firstUnit = timeUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = timeUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortTimeUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortTimeUnits[secondUnitPicker.selectedRowInComponent(0)])"
        case "Volume":
            firstUnit = volumeUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = volumeUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortVolumeUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortVolumeUnits[secondUnitPicker.selectedRowInComponent(0)])"
        case "Weight":
            firstUnit = weightUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = weightUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortWeightUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortWeightUnits[secondUnitPicker.selectedRowInComponent(0)])"
        default:
            currentConversion = "Length"
            firstUnit = lengthUnits[firstUnitPicker.selectedRowInComponent(0)]
            secondUnit = lengthUnits[secondUnitPicker.selectedRowInComponent(0)]
            calculate()
            unitLabel.text = "\(shortLengthUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortLengthUnits[secondUnitPicker.selectedRowInComponent(0)])"
        }
    }
    
    //All of the logic behind converting the number is done in this method
    func calculate(){
        switch currentConversion{
        case "Length":
            switch firstUnit{
            case "Kilometer":
                switch secondUnit{
                case "Meter":
                    secondNumber = 1000 * firstNumber
                case "Centimeter":
                    secondNumber = 100000 * firstNumber
                case "Millimeter":
                    secondNumber = 1000000 * firstNumber
                case "Mile":
                    secondNumber = 0.621371 * firstNumber
                case "Yard":
                    secondNumber = 1093.61 * firstNumber
                case "Foot":
                    secondNumber = 3280.84 * firstNumber
                case "Inch":
                    secondNumber = 39370.1 * firstNumber
                default:
                    secondNumber = firstNumber
                }
            case "Meter":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber / 1000
                case "Centimeter":
                    secondNumber = firstNumber * 100
                case "Millimeter":
                    secondNumber = firstNumber * 1000
                case "Mile":
                    secondNumber = firstNumber * 0.000621371
                case "Yard":
                    secondNumber = firstNumber * 1.09361
                case "Foot":
                    secondNumber = firstNumber * 3.28084
                case "Inch":
                    secondNumber = firstNumber * 39.3701
                default:
                    secondNumber = firstNumber
                }
            case "Centimeter":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber * 0.00001
                case "Meter":
                    secondNumber = firstNumber * 0.01
                case "Millimeter":
                    secondNumber = firstNumber * 10
                case "Mile":
                    secondNumber = firstNumber * 0.0000062137
                case "Yard":
                    secondNumber = firstNumber * 0.0109361
                case "Foot":
                    secondNumber = firstNumber * 0.0328084
                case "Inch":
                    secondNumber = firstNumber * 0.393701
                default:
                    secondNumber = firstNumber
                }
            case "Millimeter":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber * 0.000001
                case "Meter":
                    secondNumber = firstNumber * 0.001
                case "Centimeter":
                    secondNumber = firstNumber * 0.1
                case "Mile":
                    secondNumber = firstNumber * 0.00000062137
                case "Yard":
                    secondNumber = firstNumber * 0.00109361
                case "Foot":
                    secondNumber = firstNumber * 0.00328084
                case "Inch":
                    secondNumber = firstNumber * 0.0393701
                default:
                    secondNumber = firstNumber
                }
            case "Mile":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber * 1.60934
                case "Meter":
                    secondNumber = firstNumber * 1609.34
                case "Centimeter":
                    secondNumber = firstNumber * 160934
                case "Millimeter":
                    secondNumber = firstNumber * 1609340
                case "Yard":
                    secondNumber = firstNumber * 1760
                case "Foot":
                    secondNumber = firstNumber * 5280
                case "Inch":
                    secondNumber = firstNumber * 63360
                default:
                    secondNumber = firstNumber
                }
            case "Yard":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber * 0.0009144
                case "Meter":
                    secondNumber = firstNumber * 0.9144
                case "Centimeter":
                    secondNumber = firstNumber * 91.44
                case "Millimeter":
                    secondNumber = firstNumber * 914.4
                case "Mile":
                    secondNumber = firstNumber * 0.000568182
                case "Foot":
                    secondNumber = firstNumber * 12
                case "Inch":
                    secondNumber = firstNumber * 36
                default:
                    secondNumber = firstNumber
                }
            case "Foot":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber * 0.0003048
                case "Meter":
                    secondNumber = firstNumber * 0.3048
                case "Centimeter":
                    secondNumber = firstNumber * 30.48
                case "Millimeter":
                    secondNumber = firstNumber * 304.8
                case "Mile":
                    secondNumber = firstNumber * 0.000189394
                case "Yard":
                    secondNumber = firstNumber * 0.333333
                case "Inch":
                    secondNumber = firstNumber * 12
                default:
                    secondNumber = firstNumber
                }
            case "Inch":
                switch secondUnit{
                case "Kilometer":
                    secondNumber = firstNumber * 0.0000254
                case "Meter":
                    secondNumber = firstNumber * 0.0254
                case "Centimeter":
                    secondNumber = firstNumber * 2.54
                case "Millimeter":
                    secondNumber = firstNumber * 25.4
                case "Mile":
                    secondNumber = firstNumber * 0.000015783
                case "Yard":
                    secondNumber = firstNumber * 0.0277778
                case "Foot":
                    secondNumber = firstNumber * 0.0833333
                default:
                    secondNumber = firstNumber
                }
            default:
                secondNumber = firstNumber
                
            }
            unitLabel.text = "\(shortLengthUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortLengthUnits[secondUnitPicker.selectedRowInComponent(0)])"
            
        case "Speed":
            switch firstUnit{
            case "Miles/Hour":
                switch secondUnit{
                case "Feet/Sec":
                    secondNumber = firstNumber * 1.46667
                case "Meters/Sec":
                    secondNumber = firstNumber * 0.44704
                case "Km/Hour":
                    secondNumber = firstNumber * 1.60934
                default:
                    secondNumber = firstNumber
                }
            case "Feet/Sec":
                switch secondUnit{
                case "Miles/Hour":
                    secondNumber = firstNumber * 0.681818
                case "Meters/Sec":
                    secondNumber = firstNumber * 0.3048
                case "Km/Hour":
                    secondNumber = firstNumber * 1.09728
                default:
                    secondNumber = firstNumber
                }
            case "Meters/Sec":
                switch secondUnit{
                case "Miles/Hour":
                    secondNumber = firstNumber * 2.23694
                case "Feet/Sec":
                    secondNumber = firstNumber * 3.28084
                case "Km/Hour":
                    secondNumber = firstNumber * 3.6
                default:
                    secondNumber = firstNumber
                }
            case "Km/Hour":
                switch secondUnit{
                case "Miles/Hour":
                    secondNumber = firstNumber * 0.621371
                case "Feet/Sec":
                    secondNumber = firstNumber * 0.911344
                case "Meters/Sec":
                    secondNumber = firstNumber * 0.277778
                default:
                    secondNumber = firstNumber
                }
            default:
                secondNumber = firstNumber
            }
            unitLabel.text = "\(shortSpeedUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortSpeedUnits[secondUnitPicker.selectedRowInComponent(0)])"
            
        case "Temperature":
            switch firstUnit{
            case "Celsius":
                switch secondUnit{
                case "Fahrenheit":
                    secondNumber = (firstNumber * 9.0 / 5.0) + 32
                case "Kelvin":
                    secondNumber = firstNumber + 273.15
                default:
                    secondNumber = firstNumber
                }
            case "Fahrenheit":
                switch secondUnit{
                case "Celsius":
                    secondNumber = (firstNumber - 32) * 5.0 / 9.0
                case "Kelvin":
                    secondNumber = (firstNumber - 32) * 5.0 / 9.0 + 273.15
                default:
                    secondNumber = firstNumber
                }
            case "Kelvin":
                switch secondUnit{
                case "Celsius":
                    secondNumber = firstNumber - 273.15
                case "Fahrenheit":
                    secondNumber = (firstNumber - 273.15) * 9.0 / 5.0 + 32
                default:
                    secondNumber = firstNumber
                }
            default:
                secondNumber = firstNumber
            }
            secondNumber = round(secondNumber * 100000) / 100000
            unitLabel.text = "\(shortTemperatureUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortTemperatureUnits[secondUnitPicker.selectedRowInComponent(0)])"
            
        case "Time":
            switch firstUnit{
            case "Millisecond":
                switch secondUnit{
                case "Second":
                    secondNumber = firstNumber * 0.001
                case "Minute":
                    secondNumber = firstNumber * 1.6667e-5
                case "Hour":
                    secondNumber = firstNumber * 2.7778e-7
                case "Day":
                    secondNumber = firstNumber * 1.1574e-8
                case "Week":
                    secondNumber = firstNumber * 1.6534e-9
                case "Month":
                    secondNumber = firstNumber * 3.8052e-10
                case "Year":
                    secondNumber = firstNumber * 3.171e-11
                default:
                    secondNumber = firstNumber
                }
            case "Second":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 1000
                case "Minute":
                    secondNumber = round((firstNumber / 60) * 100000) / 100000
                case "Hour":
                    secondNumber = firstNumber * 0.000277778
                case "Day":
                    secondNumber = firstNumber * 1.1574e-5
                case "Week":
                    secondNumber = firstNumber * 1.6534e-6
                case "Month":
                    secondNumber = firstNumber * 3.8052e-7
                case "Year":
                    secondNumber = firstNumber * 3.171e-8
                default:
                    secondNumber = firstNumber
                }
            case "Minute":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 60000
                case "Second":
                    secondNumber = firstNumber * 60
                case "Hour":
                    secondNumber = round((firstNumber / 60) * 100000) / 100000
                case "Day":
                    secondNumber = firstNumber * 0.000694444
                case "Week":
                    secondNumber = firstNumber * 9.9206e-5
                case "Month":
                    secondNumber = firstNumber * 2.2831e-5
                case "Year":
                    secondNumber = firstNumber * 1.9026e-6
                default:
                    secondNumber = firstNumber
                }
            case "Hour":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 3.6e+6
                case "Second":
                    secondNumber = firstNumber * 3600
                case "Minute":
                    secondNumber = firstNumber * 60
                case "Day":
                    secondNumber = round((firstNumber / 24) * 100000) / 100000
                case "Week":
                    secondNumber = firstNumber * 0.00595238
                case "Month":
                    secondNumber = firstNumber * 0.00136986
                case "Year":
                    secondNumber = firstNumber * 0.000114155
                default:
                    secondNumber = firstNumber
                }
            case "Day":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 8.64e+7
                case "Second":
                    secondNumber = firstNumber * 86400
                case "Minute":
                    secondNumber = firstNumber * 1440
                case "Hour":
                    secondNumber = firstNumber * 24
                case "Week":
                    secondNumber = round((firstNumber / 7) * 100000) / 100000
                case "Month":
                    secondNumber = firstNumber * 0.0328767
                case "Year":
                    secondNumber = firstNumber * 0.00273973
                default:
                    secondNumber = firstNumber
                }
            case "Week":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 6.048e+8
                case "Second":
                    secondNumber = firstNumber * 604800
                case "Minute":
                    secondNumber = firstNumber * 10080
                case "Hour":
                    secondNumber = firstNumber * 168
                case "Day":
                    secondNumber = firstNumber * 7
                case "Month":
                    secondNumber = firstNumber * 0.230137
                case "Year":
                    secondNumber = firstNumber * 0.0191781
                default:
                    secondNumber = firstNumber
                }
            case "Month":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 2.628e+9
                case "Second":
                    secondNumber = firstNumber * 2.628e+6
                case "Minute":
                    secondNumber = firstNumber * 43800
                case "Hour":
                    secondNumber = firstNumber * 730.001
                case "Day":
                    secondNumber = firstNumber * 30.4167
                case "Week":
                    secondNumber = firstNumber * 4.34524
                case "Year":
                    secondNumber = round((firstNumber / 12) * 100000) / 100000
                default:
                    secondNumber = firstNumber
                }
            case "Year":
                switch secondUnit{
                case "Millisecond":
                    secondNumber = firstNumber * 3.154e+10
                case "Second":
                    secondNumber = firstNumber * 3.154e+7
                case "Minute":
                    secondNumber = firstNumber * 525600
                case "Hour":
                    secondNumber = firstNumber * 8760
                case "Day":
                    secondNumber = firstNumber * 365
                case "Week":
                    secondNumber = firstNumber * 52.1429
                case "Month":
                    secondNumber = firstNumber * 12
                default:
                    secondNumber = firstNumber
                }
            default:
                secondNumber = firstNumber
            }
            unitLabel.text = "\(shortTimeUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortTimeUnits[secondUnitPicker.selectedRowInComponent(0)])"
            
        case "Volume":
            switch firstUnit{
            case "US gal":
                switch secondUnit{
                case "US quart":
                    secondNumber = firstNumber * 4
                case "US pint":
                    secondNumber = firstNumber * 8
                case "US cup":
                    secondNumber = firstNumber * 16
                case "US oz":
                    secondNumber = firstNumber * 128
                case "US tbsp":
                    secondNumber = firstNumber * 256
                case "US tsp":
                    secondNumber = firstNumber * 768
                case "Liter":
                    secondNumber = firstNumber * 3.78541
                case "Millileter":
                    secondNumber = firstNumber * 3785.41
                case "Meter^3":
                    secondNumber = firstNumber * 0.00378541
                case "Centimeter^3":
                    secondNumber = firstNumber * 3785.411784
                case "Foot^3":
                    secondNumber = firstNumber * 0.133681
                case "Inch^3":
                    secondNumber = firstNumber * 231
                default:
                    secondNumber = firstNumber
                }
            case "US quart":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.25
                case "US pint":
                    secondNumber = firstNumber * 2
                case "US cup":
                    secondNumber = firstNumber * 4
                case "US oz":
                    secondNumber = firstNumber * 32
                case "US tbsp":
                    secondNumber = firstNumber * 64
                case "US tsp":
                    secondNumber = firstNumber * 192
                case "Liter":
                    secondNumber = firstNumber * 0.946353
                case "Millileter":
                    secondNumber = firstNumber * 946.353
                case "Meter^3":
                    secondNumber = firstNumber * 0.000946353
                case "Centimeter^3":
                    secondNumber = firstNumber * 946.352946
                case "Foot^3":
                    secondNumber = firstNumber * 0.0334201
                case "Inch^3":
                    secondNumber = firstNumber * 57.75
                default:
                    secondNumber = firstNumber
                }
            case "US pint":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.125
                case "US quart":
                    secondNumber = firstNumber * 0.5
                case "US cup":
                    secondNumber = firstNumber * 2
                case "US oz":
                    secondNumber = firstNumber * 16
                case "US tbsp":
                    secondNumber = firstNumber * 32
                case "US tsp":
                    secondNumber = firstNumber * 96
                case "Liter":
                    secondNumber = firstNumber * 0.473176
                case "Millileter":
                    secondNumber = firstNumber * 473.176
                case "Meter^3":
                    secondNumber = firstNumber * 0.000473176
                case "Centimeter^3":
                    secondNumber = firstNumber * 473.176473
                case "Foot^3":
                    secondNumber = firstNumber * 0.0167101
                case "Inch^3":
                    secondNumber = firstNumber * 28.875
                default:
                    secondNumber = firstNumber
                }
            case "US cup":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.0625
                case "US quart":
                    secondNumber = firstNumber * 0.25
                case "US pint":
                    secondNumber = firstNumber * 0.5
                case "US oz":
                    secondNumber = firstNumber * 8
                case "US tbsp":
                    secondNumber = firstNumber * 16
                case "US tsp":
                    secondNumber = firstNumber * 48
                case "Liter":
                    secondNumber = firstNumber * 0.236588
                case "Millileter":
                    secondNumber = firstNumber * 236.588
                case "Meter^3":
                    secondNumber = firstNumber * 0.000236588
                case "Centimeter^3":
                    secondNumber = firstNumber * 236.5882365
                case "Foot^3":
                    secondNumber = firstNumber * 0.00835503
                case "Inch^3":
                    secondNumber = firstNumber * 14.4375
                default:
                    secondNumber = firstNumber
                }
            case "US oz":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.0078125
                case "US quart":
                    secondNumber = firstNumber * 0.03125
                case "US pint":
                    secondNumber = firstNumber * 0.0625
                case "US cup":
                    secondNumber = firstNumber * 0.125
                case "US tbsp":
                    secondNumber = firstNumber * 2
                case "US tsp":
                    secondNumber = firstNumber * 6
                case "Liter":
                    secondNumber = firstNumber * 0.0295735
                case "Millileter":
                    secondNumber = firstNumber * 29.5735
                case "Meter^3":
                    secondNumber = firstNumber * 0.000029574
                case "Centimeter^3":
                    secondNumber = firstNumber * 29.573529563
                case "Foot^3":
                    secondNumber = firstNumber * 0.00104438
                case "Inch^3":
                    secondNumber = firstNumber * 1.80469
                default:
                    secondNumber = firstNumber
                }
            case "US tbsp":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.00390625
                case "US quart":
                    secondNumber = firstNumber * 0.015625
                case "US pint":
                    secondNumber = firstNumber * 0.03125
                case "US cup":
                    secondNumber = firstNumber * 0.0625
                case "US oz":
                    secondNumber = firstNumber * 0.5
                case "US tsp":
                    secondNumber = firstNumber * 3
                case "Liter":
                    secondNumber = firstNumber * 0.0147868
                case "Millileter":
                    secondNumber = firstNumber * 14.7868
                case "Meter^3":
                    secondNumber = firstNumber * 0.000014787
                case "Centimeter^3":
                    secondNumber = firstNumber * 14.786764781
                case "Foot^3":
                    secondNumber = firstNumber * 0.00052219
                case "Inch^3":
                    secondNumber = firstNumber * 0.902344
                default:
                    secondNumber = firstNumber
                }
            case "US tsp":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.00130208
                case "US quart":
                    secondNumber = firstNumber * 0.00520833
                case "US pint":
                    secondNumber = firstNumber * 0.0104167
                case "US cup":
                    secondNumber = firstNumber * 0.0208333
                case "US oz":
                    secondNumber = firstNumber * 0.166667
                case "US tbsp":
                    secondNumber = firstNumber * 0.333333
                case "Liter":
                    secondNumber = firstNumber * 0.00492892
                case "Millileter":
                    secondNumber = firstNumber * 4.92892
                case "Meter^3":
                    secondNumber = firstNumber * 0.0000049289
                case "Centimeter^3":
                    secondNumber = firstNumber * 4.9289215938
                case "Foot^3":
                    secondNumber = firstNumber * 0.000174063
                case "Inch^3":
                    secondNumber = firstNumber * 0.300781
                default:
                    secondNumber = firstNumber
                }
            case "Liter":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.264172
                case "US quart":
                    secondNumber = firstNumber * 1.05669
                case "US pint":
                    secondNumber = firstNumber * 2.11338
                case "US cup":
                    secondNumber = firstNumber * 4.22675
                case "US oz":
                    secondNumber = firstNumber * 33.814
                case "US tbsp":
                    secondNumber = firstNumber * 67.628
                case "US tsp":
                    secondNumber = firstNumber * 202.884
                case "Millileter":
                    secondNumber = firstNumber * 1000
                case "Meter^3":
                    secondNumber = firstNumber * 0.001
                case "Centimeter^3":
                    secondNumber = firstNumber * 1000
                case "Foot^3":
                    secondNumber = firstNumber * 0.0353147
                case "Inch^3":
                    secondNumber = firstNumber * 61.0237
                default:
                    secondNumber = firstNumber
                }
            case "Millileter":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.000264172
                case "US quart":
                    secondNumber = firstNumber * 0.00105669
                case "US pint":
                    secondNumber = firstNumber * 0.00211338
                case "US cup":
                    secondNumber = firstNumber * 0.00422675
                case "US oz":
                    secondNumber = firstNumber * 0.033814
                case "US tbsp":
                    secondNumber = firstNumber * 0.067628
                case "US tsp":
                    secondNumber = firstNumber * 0.202884
                case "Liter":
                    secondNumber = firstNumber * 0.001
                case "Meter^3":
                    secondNumber = firstNumber * 0.000001
                case "Centimeter^3":
                    secondNumber = firstNumber
                case "Foot^3":
                    secondNumber = firstNumber * 0.000035315
                case "Inch^3":
                    secondNumber = firstNumber * 0.0610237
                default:
                    secondNumber = firstNumber
                }
            case "Meter^3":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 264.172
                case "US quart":
                    secondNumber = firstNumber * 1056.69
                case "US pint":
                    secondNumber = firstNumber * 2113.38
                case "US cup":
                    secondNumber = firstNumber * 4226.75
                case "US oz":
                    secondNumber = firstNumber * 33814
                case "US tbsp":
                    secondNumber = firstNumber * 67628
                case "US tsp":
                    secondNumber = firstNumber * 202884
                case "Liter":
                    secondNumber = firstNumber * 1000
                case "Millileter":
                    secondNumber = firstNumber * 1000000
                case "Centimeter^3":
                    secondNumber = firstNumber * 1000000
                case "Foot^3":
                    secondNumber = firstNumber * 35.3147
                case "Inch^3":
                    secondNumber = firstNumber * 61023.7
                default:
                    secondNumber = firstNumber
                }
            case "Centimeter^3":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.00026417205236
                case "US quart":
                    secondNumber = firstNumber * 0.0010566882094
                case "US pint":
                    secondNumber = firstNumber * 0.0021133764189
                case "US cup":
                    secondNumber = firstNumber * 0.0042267528377
                case "US oz":
                    secondNumber = firstNumber * 0.033814022701
                case "US tbsp":
                    secondNumber = firstNumber * 0.067628045405
                case "US tsp":
                    secondNumber = firstNumber * 0.20288413621
                case "Liter":
                    secondNumber = firstNumber * 0.001
                case "Millileter":
                    secondNumber = firstNumber
                case "Meter^3":
                    secondNumber = firstNumber * 0.000001
                case "Foot^3":
                    secondNumber = firstNumber * 0.000035314666721
                case "Inch^3":
                    secondNumber = firstNumber * 0.061023744095
                default:
                    secondNumber = firstNumber
                }
            case "Foot^3":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 7.48052
                case "US quart":
                    secondNumber = firstNumber * 29.9221
                case "US pint":
                    secondNumber = firstNumber * 59.8442
                case "US cup":
                    secondNumber = firstNumber * 119.688
                case "US oz":
                    secondNumber = firstNumber * 957.506
                case "US tbsp":
                    secondNumber = firstNumber * 1915.01
                case "US tsp":
                    secondNumber = firstNumber * 5745.04
                case "Liter":
                    secondNumber = firstNumber * 28.3168
                case "Millileter":
                    secondNumber = firstNumber * 28316.8
                case "Meter^3":
                    secondNumber = firstNumber * 0.0283168
                case "Centimeter^3":
                    secondNumber = firstNumber * 28316.846592
                case "Inch^3":
                    secondNumber = firstNumber * 1728
                default:
                    secondNumber = firstNumber
                }
            case "Inch^3":
                switch secondUnit{
                case "US gal":
                    secondNumber = firstNumber * 0.004329
                case "US quart":
                    secondNumber = firstNumber * 0.017316
                case "US pint":
                    secondNumber = firstNumber * 0.034632
                case "US cup":
                    secondNumber = firstNumber * 0.0692641
                case "US oz":
                    secondNumber = firstNumber * 0.554113
                case "US tbsp":
                    secondNumber = firstNumber * 1.10823
                case "US tsp":
                    secondNumber = firstNumber * 3.32468
                case "Liter":
                    secondNumber = firstNumber * 0.0163871
                case "Millileter":
                    secondNumber = firstNumber * 16.3871
                case "Meter^3":
                    secondNumber = firstNumber * 0.000016387
                case "Centimeter^3":
                    secondNumber = firstNumber * 16.387064
                case "Foot^3":
                    secondNumber = firstNumber * 0.000578704
                default:
                    secondNumber = firstNumber
                }
            default:
                secondNumber = firstNumber
            }
            unitLabel.text = "\(shortVolumeUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortVolumeUnits[secondUnitPicker.selectedRowInComponent(0)])"
            
        case "Weight":
            switch firstUnit{
            case "Kilogram":
                switch secondUnit{
                case "Gram":
                    secondNumber = firstNumber * 1000
                case "Milligram":
                    secondNumber = firstNumber * 1000000
                case "Pound":
                    secondNumber = firstNumber * 2.20462
                case "Ounce":
                    secondNumber = firstNumber * 35.274
                default:
                    secondNumber = firstNumber
                }
            case "Gram":
                switch secondUnit{
                case "Kilogram":
                    secondNumber = firstNumber * 0.001
                case "Milligram":
                    secondNumber = firstNumber * 1000
                case "Pound":
                    secondNumber = firstNumber * 0.00220462
                case "Ounce":
                    secondNumber = firstNumber * 0.035274
                default:
                    secondNumber = firstNumber
                }
            case "Milligram":
                switch secondUnit{
                case "Kilogram":
                    secondNumber = firstNumber * 0.000001
                case "Gram":
                    secondNumber = firstNumber * 0.001
                case "Pound":
                    secondNumber = firstNumber * 0.0000022046
                case "Ounce":
                    secondNumber = firstNumber * 0.000035274
                default:
                    secondNumber = firstNumber
                }
            case "Pound":
                switch secondUnit{
                case "Kilogram":
                    secondNumber = firstNumber * 0.453592
                case "Gram":
                    secondNumber = firstNumber * 453.592
                case "Milligram":
                    secondNumber = firstNumber * 453592
                case "Ounce":
                    secondNumber = firstNumber * 16
                default:
                    secondNumber = firstNumber
                }
            case "Ounce":
                switch secondUnit{
                case "Kilogram":
                    secondNumber = firstNumber * 0.0283495
                case "Gram":
                    secondNumber = firstNumber * 28.3495
                case "Milligram":
                    secondNumber = firstNumber * 28349.5
                case "Pound":
                    secondNumber = firstNumber * 0.0625
                default:
                    secondNumber = firstNumber
                }
            default:
                secondNumber = firstNumber
            }
            unitLabel.text = "\(shortWeightUnits[firstUnitPicker.selectedRowInComponent(0)]) = \(secondNumber)\(shortWeightUnits[secondUnitPicker.selectedRowInComponent(0)])"
        default:
            return
        }
    }
}