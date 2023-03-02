components {
  id: "script"
  component: "/rendercam/camera.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "fixedAspectRatio"
    value: "true"
    type: PROPERTY_TYPE_BOOLEAN
  }
}
embedded_components {
  id: "model"
  type: "model"
  data: "mesh: \"/rendercam/cam model.glb\"\n"
  "material: \"/rendercam/material/cam.material\"\n"
  "skeleton: \"\"\n"
  "animations: \"\"\n"
  "default_animation: \"\"\n"
  "name: \"unnamed\"\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
