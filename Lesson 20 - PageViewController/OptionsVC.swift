//
//  OptionsVC.swift
//  Lesson 20 - PageViewController
//
//  Created by Валентин Ремизов on 17.03.2023.
//

import UIKit

//Эта структура нужна нам как шаблон создания вьюконтроллеров (чтобы не создавать каждый контроллер отдельно)
public struct OptionsVC {
    var typeImage = UIImage()
    var label = String()
    var description = String()
}
