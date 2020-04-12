//
//  ViewController2.swift
//  Meme Maker
//
//  Created by Sergey on 15/10/2019.
//  Copyright © 2019 Sergey. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate{
@IBOutlet weak var imageView: UIImageView!
@IBOutlet weak var cameraButton :UILabel!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
        @IBOutlet weak var imagePickerView: UIImageView!
    struct Keys{
let memeTextAttributes:[NSAttributedString.Key: Any] = [
               NSAttributedString.Key.strokeColor: UIColor.black,
               NSAttributedString.Key.foregroundColor: UIColor.white,
               NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
               NSAttributedString.Key.strokeWidth: 4.0]
}
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextfield.text = "TOP"
        bottomTextfield.text = "BOTTOM"
        topTextfield.textAlignment = NSTextAlignment.center
        bottomTextfield.textAlignment = NSTextAlignment.center
        
    }
override func viewWillAppear(_ animated: Bool) {
              super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
}
       override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
           unsubscribeFromKeyboardNotifications()
           
       }
       func textFieldShouldReturn(_textField: UITextField) -> Bool{
           
           return true
       }
       func getKeyboardHeight(_ notification:Notification) -> CGFloat {

           let userInfo = notification.userInfo
           let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
           return keyboardSize.cgRectValue.height
       }
    @objc func keyboardWillShow(_ notification:Notification) {

    view.frame.origin.y -= getKeyboardHeight(notification)
    }
     func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
        }
    func subscribeToKeyboardNotifications() {

           NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       }
       func unsubscribeFromKeyboardNotifications() {
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
       
}
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
     
    pickAnImage(UIImagePickerController.SourceType.photoLibrary)
     
    }
     
     
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
     
        pickAnImage(UIImagePickerController.SourceType.camera)
     
    }
     
     
    func pickAnImage(_ source: UIImagePickerController.SourceType) {
    
        let pickerController = UIImagePickerController()
    
        pickerController.delegate = self
    
        pickerController.sourceType = source
    
        present(pickerController, animated: true, completion: nil)
    
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]){
                   if let image = info [UIImagePickerController.InfoKey.originalImage] as? UIImage {
                    imagePickerView.image = image
                            dismiss(animated: true, completion: nil)
        }
        func ImagePickerControllerDidCancel(_picker: UIImagePickerController){
            dismiss(animated: true, completion: nil)
        }
        func generateMemedImage() -> UIImage {

        // Render view to an image
        // TODO: Hide toolbar and navbar

            // Render view to an image
            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
            let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            // TODO: Show toolbar and navbar

            return memedImage
    }
    let sharedImage = generateMemedImage()
    let activityController = UIActivityViewController(activityItems:    [sharedImage], applicationActivities: nil)
    self.present(activityController, animated: true, completion: nil)
 activityController.completionWithItemsHandler = {(activity, success, items, error) in
    func Save(){
        /// let meme = Meme
        /// _ =
        _ =  (topText:self.topTextfield.text!,
                bottomText: self.bottomTextfield.text!,
                originalImage: self.imagePickerView.image!,
                memedImage: sharedImage)
            }
            
    }
}
}
