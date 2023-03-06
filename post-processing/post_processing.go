components {
  id: "post_processing_quad"
  component: "/post-processing/post_processing_quad.model"
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
components {
  id: "post_processing"
  component: "/post-processing/post_processing.script"
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
    id: "blur_radius"
    value: "5.0"
    type: PROPERTY_TYPE_NUMBER
  }
}
