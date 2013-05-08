$(document).ready(->
  ##############################
  # Viewport Constraints
  ##############################
  WIDTH = 400
  HEIGHT = 300

  # Viewport and Rendering Properties
  VIEW_ANGLE = 45
  ASPECT = WIDTH / HEIGHT
  NEAR = 0.1
  FAR = 10000

  ##############################
  # Grab the container
  ##############################
  $container = $("#container")

  ##############################
  # Create a WebGL renderer
  ##############################
  renderer = new THREE.WebGLRenderer()

  # Set the renderer's dimensions
  renderer.setSize(WIDTH, HEIGHT)

  # Now append the dom element to the screen
  $container.append(renderer.domElement)


  ##############################
  # Create the scene
  ##############################
  scene = new THREE.Scene()

  ##############################
  # Create the camera
  ##############################
  camera = new THREE.PerspectiveCamera(
    VIEW_ANGLE,  # 45
    ASPECT,      # WIDTH / HEIGHT
    NEAR,        # 0.1
    FAR         # 10000
  )

  # Position the camera away from origin (it's default)
  camera.position.set(-15,10,10)
  camera.lookAt(scene.position)

  # Add the camera to the scene
  scene.add(camera)

  ##############################
  # SET UP THE MESHES
  ##############################
  attributes = {
    displacement: {
      type: 'f'
      value: []
    }
  }

  uniforms = {
    amplitude: {
      type: 'f'
      value: 0
    }
  }


  radius = 4
  segments = 8
  rings = 8

  vShader = $("#vertexshader")
  fShader = $("#fragmentshader")

  sphere = new THREE.Mesh(
    new THREE.SphereGeometry(radius, segments, rings),
    new THREE.ShaderMaterial(
      uniforms: uniforms
      attributes: attributes
      vertexShader: vShader.text()
      fragmentShader: fShader.text()
    )
  )

  scene.add(sphere)

  sphereVertices = sphere.geometry.vertices
  values = attributes.displacement.value
  for i in [0..sphereVertices.length-1] by 1
    values.push(Math.random()*3)


  ##############################
  # SET UP THE LIGHTS
  ##############################
  # pointLight = new THREE.PointLight(0xFFFFFF)
  # pointLight.position.x = 0
  # pointLight.position.y = 0
  # pointLight.position.z = 0

  # scene.add(pointLight)

  # light = new THREE.PointLight( 0xFFFF00 )
  # light.position.set( 10, 0, 10 )
  # scene.add( light )

  ##############################f
  # SET UP THE RENDER LOOP
  ##############################
  # renderer.render(scene, camera)

  # return true


  # Declare the animation loop
  frame = 0
  update = ->
    uniforms.amplitude.value = Math.sin(frame)

    # update the frame
    frame += 0.1

    # Draw the scene
    renderer.render(scene, camera)

    # Set up the next call of update()
    requestAnimFrame(update)

  requestAnimFrame(update)

)