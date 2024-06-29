//
//  ImagePickerCoordinator.swift
//  UserProfiles
//
//  Created by Cle on 2024/6/28.
//

import SwiftUI

class ImagePickerCoordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: UIViewController?
    var callback: ((UIImage?) -> Void)?
      
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
//            print("Image selected: \(image)")
            callback?(image)
        }
        picker.dismiss(animated: true, completion: nil)
    }
      
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

struct ImagePickerController: UIViewControllerRepresentable {
    let coordinator = ImagePickerCoordinator()
    let picker = UIImagePickerController()
      
    @Binding var image: UIImage? //
      
    func makeCoordinator() -> ImagePickerCoordinator {
        coordinator.callback = { aImage in
            self.image = aImage
        }
        return coordinator
    }
      
    func makeUIViewController(context: Context) -> UIImagePickerController {
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary // or .camera
        return picker
    }
      
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}
