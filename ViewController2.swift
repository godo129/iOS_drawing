//
//  ViewController.swift
//  get_photo
//
//  Created by comsoft on 2021/05/07.
//

import UIKit
import MobileCoreServices

class ViewController2: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var numImage = 1
    
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    @IBOutlet weak var imgView2: UIImageView!
    
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    var flagImageSave = false
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func LoadImage(_ sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(.photoLibrary)) {
            
                   flagImageSave = false
                   
                   imagePicker.delegate = self
                   imagePicker.sourceType = .photoLibrary // 이미지 피커의 소스 타입을 PotoLibrary로 설정
                   imagePicker.mediaTypes = [kUTTypeImage as String]
                   imagePicker.allowsEditing = true // 편집을 허용
                   
                   present(imagePicker, animated: true, completion: nil)
               } else {
                   myAlert("Photo album inaccessable", message: "Application cannot access the photo albm.")
               }    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            // 미디어 종류 확인
            let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
            // 미디어가 사진이면
            if mediaType.isEqual(to: kUTTypeImage as NSString as String){
                // 사진을 가져옴
                let captureImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                
                if flagImageSave { // flagImageSave가 true일 때
                    // 사진을 포토 라이브러리에 저장
                    UIImageWriteToSavedPhotosAlbum(captureImage, self, nil, nil)
                }
                // 가져온 사진을 해당하는 이미지 뷰에 넣기...
                if numImage == 1 {
                    imgView.image = captureImage // 가져온 사진을 이미지 뷰에 출력
                    numImage = 2
                }
                else if numImage == 2 {
                    imgView2.image = captureImage // 가져온 사진을 이미지 뷰에 출력
                    numImage = 1
                }
            }
            // 현재의 뷰(이미지 피커) 제거
            self.dismiss(animated: true, completion: nil)
        }
    @IBAction func clear(_ sender: UIButton) {
        imgView.image = nil
        imgView2.image = nil
        numImage = 1    }
    
    
    
    func myAlert(_ title: String,message: String) {
            // Alert show
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }}

