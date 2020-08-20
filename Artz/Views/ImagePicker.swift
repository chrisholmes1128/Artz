//
//  ImagePicker.swift
//  Artz
//
//  Created by Chris holmes on 7/6/20.
//  Copyright © 2020 Chris holmes. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isVisibile: Bool
    @Binding var image:Image?
    @Binding var sourceNumber:Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isVisibile: $isVisibile, image: $image)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = sourceNumber == 1 ? .photoLibrary : .camera
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
        @Binding var isVisibile: Bool
        @Binding var image:Image?
        
        init(isVisibile: Binding<Bool>, image: Binding<Image?>) {
            _isVisibile = isVisibile
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = Image(uiImage: uiImage)
            isVisibile = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isVisibile = false
        }
    }
}


