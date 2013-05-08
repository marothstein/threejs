$(document).ready(->
  # Viewport Constraints
  WIDTH = 400
  HEIGHT = 500

  # Viewport and Rendering Properties
  VIEW_ANGLE = 45
  ASPECT = WIDTH / HEIGHT
  NEAR = 0.1
  FAR = 10000

  # Grab the container
  $container = $("#container")

  # Create a WebGL renderer
  renderer = new THREE.WebGLRenderer()

  # Create the camera
  camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)

  # Create the scene
  scene = new THREE.Scene()

  # Add the camera to the scene
  scene.add(camera)

  # Position the camera away from origin (it's default)
  camera.position.z = 300

  # Set the renderer's dimensions
  renderer.setSize(WIDTH, HEIGHT)

  # Now append the dom element to the screen
  $container.append(renderer.domElement)

  ##############################
  # SET UP THE MESHES
  ##############################
  radius = 50
  segments = 16
  rings = 16

  vShader = $("#vertexshader")
  fShader = $("#fragmentshader")

  console.log "Vertex Shader: ", vShader, "Text: #{vShader.text()}"
  console.log "Fragment Shader: ", fShader, "Text: #{fShader.text()}"

  # Create the sphere mesh
  sphere = new THREE.Mesh(
    new THREE.SphereGeometry(radius, segments, rings),
    new THREE.ShaderMaterial(
      vertexshader: vShader.text()
      fragmentshader: fShader.text()
    )
  )

  scene.add(sphere)

  ##############################
  # SET UP THE LIGHTS
  ##############################
  # pointLight = new THREE.PointLight(0xFFFFFF)
  # pointLight.x = 10
  # pointLight.y = 50
  # pointLight.z = 130

  # scene.add(pointLight)

  ##############################
  # SET UP THE RENDER LOOP
  ##############################
  renderer.render(scene, camera)
  # return true


  # # # Declare the animation loop
  # update = ->
  #   # particleSystem.geometry.__dirtyVertices = true

  #   # Draw the scene
  #   renderer.render(scene, camera)

  #   # Set up the next call of update()
  #   requestAnimFrame(update)


  # requestAnimFrame(update)

)