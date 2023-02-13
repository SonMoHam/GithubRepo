//
//  Project.swift
//  GithubRepoManifests
//
//  Created by Son Daehong on 2023/02/10.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let settings: Settings = .settings(
    base: [:],
    configurations: [
        .debug(name: .debug),
        .release(name: .release)
    ], defaultSettings: .recommended)

private let deploymentTarget: DeploymentTarget = .iOS(targetVersion: "14.0", devices: [.iphone])

let project: Project = .init(
    name: "GithubRepo",
    organizationName: "son",
    settings: settings,
    targets: [
        [Project.makeAppTarget(
            platform: .iOS,
            dependencies: [
                .target(name: "Feature"),
                .target(name: "Legacy")
            ],
            deploymentTarget: deploymentTarget)],
        
        Project.makeFrameworkTargets(
            name: "Feature",
            platform: .iOS,
            deploymentTarget: deploymentTarget,
            dependencies: [
                //        .target(name: Module.designKit.moduleName),
                .external(name: "RxCocoa"),
                .external(name: "RxSwift"),
                .external(name: "ReactorKit"),
                .external(name: "SnapKit"),
                .external(name: "Then")
            ]),
        
        Project.makeFrameworkTargets(
            name: "Legacy",
            platform: .iOS,
            deploymentTarget: deploymentTarget,
            dependencies: [
                //        .target(name: Module.designKit.moduleName),
                .external(name: "RxCocoa"),
                .external(name: "RxSwift"),
                .external(name: "ReactorKit"),
                .external(name: "SnapKit"),
                .external(name: "Then"),
                .external(name: "Alamofire")
            ])
    ].flatMap { $0 }
)
