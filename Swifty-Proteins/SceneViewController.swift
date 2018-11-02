//
//  SceneViewController.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/02.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import UIKit
import SceneKit

class SceneViewController: UIViewController {
  
    @IBOutlet weak var sceneView: SCNView! {
        willSet {
            newValue.allowsCameraControl = true
            newValue.autoenablesDefaultLighting = true
        }
    }
    var gameView : SCNView!
    var gameScene : SCNScene!
    var cameraNode : SCNNode!
    
    var ligand : Ligand?
    var atoms : [Atom] = [Atom]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initCamera()
        initScene()
        if let lig = ligand {
            for a in lig.atoms {
                addAtom(atom: a)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initView() {
        gameView = sceneView
    }
    
    func initScene() {
        gameScene = SCNScene()
        gameView.scene = gameScene
        gameView.isPlaying = true
    }
    
    func initCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x : 0, y : 5, z : 10)
    }
    
    func createTarget() {
        let geometry : SCNGeometry = SCNPyramid(width: 1, height: 1, length: 1)
        geometry.materials.first?.diffuse.contents = UIColor.red
        
        let geometryNode = SCNNode(geometry: geometry)
        gameScene.rootNode.addChildNode(geometryNode)
    }
    
    func addAtom (atom : Atom) {
        let geometry : SCNGeometry = SCNSphere(radius: 0.5)
        geometry.materials.first?.diffuse.contents = UIColor.red
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = SCNVector3(x : atom.x, y : atom.y, z : atom.z)
        gameScene.rootNode.addChildNode(geometryNode)
    }
    
    func addConnetion (connect : Connect) {
        
    }
    
}


















