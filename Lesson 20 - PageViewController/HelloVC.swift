//
//  ViewController.swift
//  Lesson 20 - PageViewController
//
//  Created by Валентин Ремизов on 17.03.2023.
//

import UIKit

//Этот VC показывает на экране где что будет и где какое значение будет. То есть по шаблону OptionsVC он знает какие значения он получит и так сказать здесь код "по умолчанию" для этих значений. А init нужен, чтобы эти значения он принимал и инициализировал автоматически как нам нужно.
public class HelloVC: UIViewController {

    open var img : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()

    open var titleStrig = String()

    open var descriptionString = String()

    private var titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        return titleLabel
    }()

    private var descriptionLabel : UILabel = {
        let desc = UILabel()
        desc.textColor = .black
        desc.font = .systemFont(ofSize: 18)
        desc.numberOfLines = 0
        desc.textAlignment = .center
        return desc
    }()

    internal init(options: OptionsVC) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .cyan
        img.image = options.typeImage
        img.frame = CGRect(x: 50,
                           y: view.bounds.height / 2 - 300,
                           width: view.bounds.width - 100,
                           height: 300)
        view.addSubview(img)

        titleLabel.frame = CGRect(x: 50,
                                  y: img.frame.maxY,
                                  width: view.bounds.width - 100,
                                  height: 60)
        titleLabel.text = options.label
        view.addSubview(titleLabel)

        descriptionLabel.frame = CGRect(x: 50,
                                        y: titleLabel.frame.maxY + 30,
                                        width: view.bounds.width - 100,
                                        height: 60)
        descriptionLabel.text = options.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.center.x = view.center.x
        descriptionLabel.textAlignment = .center
        view.addSubview(descriptionLabel)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

