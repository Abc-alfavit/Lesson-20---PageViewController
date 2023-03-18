//
//  PageViewController.swift
//  Lesson 20 - PageViewController
//
//  Created by Валентин Ремизов on 17.03.2023.
//

import UIKit

final class PageViewController: UIPageViewController {

// В этот массив мы собираем данные для вставки во ViewController (то что именно будем передавать)
    private var arrayWithOptions = [OptionsVC]()
    private let oneImage = UIImage(named: "One")
    private let twoImage = UIImage(named: "Two")
    private let threeImage = UIImage(named: "Three")
    //А в этот массив мы собираем уже сами ViewController'ы
    private lazy var arrayVC : [HelloVC] = {
            var element = [HelloVC]()
            //Добавляем контроллеры в массив из собранного массива данных arrayWithOptions
            arrayWithOptions.forEach{ element.append(HelloVC(options: $0)) }
            return element
    }()

    internal override func viewDidLoad() {
        super.viewDidLoad()
        guard let oneImg = oneImage else { return }
        guard let twoImg = twoImage else { return }
        guard let threeImg = threeImage else { return }
        let firstPage = OptionsVC(typeImage: oneImg, label: "Conversation", description: "We have you can conversation with friends")
        let twoPage = OptionsVC(typeImage: twoImg, label: "Met", description: "Did you spend conversation? You need make meet")
        let threePage = OptionsVC(typeImage: threeImg, label: "Support", description: "Yet you spend meet we will be work for you. Your service support.")
        //Добавляем циклом forEach в массив arrayWithOptions  все 3 переменные с готовыми данными
        [firstPage, twoPage, threePage].forEach{ arrayWithOptions.append($0) }
    }

//MARK: - ОЧЕНЬ ВАЖНО! Сначала срабатывает init тот что ниже и только потому viewDidLoad. Но если мы используем здесь view (как фон устанавливаем, например), то тогда при использовании view она прогружается и чтоб прогрузиться нашей view нужен метод viewDidLoad и только таким образом получается что сначала срабатывает init ещё до назначения первого контроллера, потом во viewDidLoad набирается массив из контроллеров, а потом уже назначается в init первый контроллер. Если view в init поставить после setViewControllers, то будет фатальная ошибка о пустом массиве arrayVC (как было и у меня).

    internal override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation)
        view.backgroundColor = .cyan
        //Указываем какой контроллер будет первый загружаться. Обязательно указывать внутри квадратных скобок!
        setViewControllers([arrayVC[0]], direction: .forward, animated: true)
        self.delegate = self
        self.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    //Этот метод возвращает предыдущую страницу PageViewController, если возвращается nil, то перед этой страницей нет никаких контроллеров.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HelloVC else { return nil }
        if let index = arrayVC.firstIndex(of: viewController) {
            if index > 0 {
                return arrayVC[index - 1]
            }
        }
        return nil
    }

    //Этот метод возвращает следующую страницу PageViewController, если возвращается nil, то после этой страницей нет никаких контроллеров.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? HelloVC else { return nil }
        if let index = arrayVC.firstIndex(of: viewController) {
            if index < arrayWithOptions.count - 1 {
                return arrayVC[index + 1]
            }
        }
        return nil
    }

    //Этот метод назначает количество точечек ViewController'ов
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayWithOptions.count
    }

    //Этот метод отображает эти точки на странице
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
