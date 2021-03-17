//
//  ViewController.swift
//  RandomDog
//
//  Created by Renan Baialuna on 28/02/21.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let breeds: [String] = ["greyhound", "poodle"]
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerView.dataSource = self
        pickerView.delegate = self
        
    }
    
    func handleImageFileResponse(image: UIImage?, error:Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    func handleRandomImageResponse(imageData: DogImage?, error: Error?) {
        let newUrl = URL(string: imageData!.message)
        DogApi.requestImageFile(url: newUrl!, completionHandler: self.handleImageFileResponse(image:error:))
    }
    

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApi.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}
