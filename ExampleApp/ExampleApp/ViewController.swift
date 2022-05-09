//
//  ViewController.swift
//  ExampleApp
//
//  Created by Eric Hyche on 5/6/22.
//

import UIKit
import SwiftGenExampleLibrary

class ViewController: UIViewController {

    private lazy var label: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = .preferredFont(forTextStyle: .title1)
        view.textColor = .label
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = SomeLibraryFile.someString()
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.image = SomeLibraryFile.someImage()
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 200.0),
            view.heightAnchor.constraint(equalToConstant: 200.0)
        ])
        return view
    }()

    private lazy var stackView: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .center
        view.spacing = 20.0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

