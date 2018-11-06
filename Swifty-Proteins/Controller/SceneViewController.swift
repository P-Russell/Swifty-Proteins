//
//  SceneViewController.swift
//  Swifty-Proteins
//
//  Created by Patrick RUSSELL on 2018/11/02.
//  Copyright © 2018 Patrick RUSSELL. All rights reserved.
//

import UIKit
import SceneKit
import SVProgressHUD


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
    var displayLigand : String?
    
    let proteinAPI : ProteinDataBankAPI = ProteinDataBankAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initCamera()
        initScene()
        if let ligand = displayLigand {
            DispatchQueue.global(qos: .userInitiated).async {
                SVProgressHUD.show(withStatus: "Fetching data for \(ligand) ligand")
                if self.proteinAPI.oldFetch(ligand: ligand) {
                    DispatchQueue.main.async {
                        self.renderLigand()
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func renderLigand() {
        if let lig = proteinAPI.ligand {
            for a in lig.atoms {
                addAtom(atom: a)
            }
            for c in lig.connections {
                let a = c.connects[0]
                var i = 1
                while i < c.connects.count {
                    addConnetion(atom1: lig.atoms[a - 1], atom2: lig.atoms[c.connects[i] - 1])
                    i += 1
                }
            }
        }
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
        let color : UIColor = Colors.map[atom.symbol] ?? UIColor.init(red: 221, green: 114, blue: 255, alpha: 1) // default pink
        geometry.materials.first?.diffuse.contents = color
        
        let geometryNode = SCNNode(geometry: geometry)
        geometryNode.position = SCNVector3(x : atom.x, y : atom.y, z : atom.z)
        gameScene.rootNode.addChildNode(geometryNode)
    }
    
    private func distance(atom1 : Atom, atom2 : Atom) -> CGFloat {
        let vector = SCNVector3(
            atom2.x - atom1.x,
            atom2.y - atom1.y,
            atom2.z - atom1.z
        )
        return CGFloat(sqrtf(vector.x * vector.x + vector.y * vector.y + vector.z * vector.z))
    }
    
    private func midPoint(a1 : Atom, a2 : Atom) -> SCNVector3 {
        return SCNVector3((a1.x + a2.x) / 2, (a1.y + a2.y) / 2, (a1.z + a2.z) / 2)
    }
    
    private func differenceAtomPosition(a1 : Atom, a2 : Atom) -> SCNVector3 {
        return SCNVector3(a1.x - a2.x, a1.y - a2.y, a1.z - a2.z)
    }
    
    private func distanceFromOrigin(vec : SCNVector3) -> Float {
        return sqrtf(vec.x * vec.x + vec.y * vec.y + vec.z * vec.z)
    }
    
//    https://stackoverflow.com/questions/35002232/draw-scenekit-object-between-two-points
    private func lineEulerAngles(vector: SCNVector3) -> SCNVector3 {
        let height = distanceFromOrigin(vec: vector)
        let lxz = sqrtf(vector.x * vector.x + vector.z * vector.z)
        let pitchB = vector.y < 0 ? Float.pi - asinf(lxz / height) : asinf(lxz / height)
        let pitch = vector.z == 0 ? pitchB : sign(vector.z) * pitchB

        var yaw: Float = 0
        if vector.x != 0 || vector.z != 0 {
            let inner = vector.x / (height * sinf(pitch))
            if inner > 1 || inner < -1 {
                yaw = Float.pi / 2
            } else {
                yaw = asinf(inner)
            }
        }
        return SCNVector3(CGFloat(pitch), CGFloat(yaw), 0)
    }
    
    private func addConnetion (atom1 : Atom, atom2 : Atom) {
        let cylinder : SCNGeometry = SCNCylinder(radius: 0.2, height: distance(atom1: atom1, atom2: atom2))
        cylinder.materials.first?.diffuse.contents = UIColor.gray
        
        let node = SCNNode(geometry: cylinder)
        node.position = midPoint(a1: atom1, a2: atom2)
        let vector : SCNVector3 = differenceAtomPosition(a1: atom1, a2: atom2)
        node.eulerAngles = lineEulerAngles(vector: vector)
        gameScene.rootNode.addChildNode(node)
    }
}


















