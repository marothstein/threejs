vertices = []

layoutVertices = ->


$(document).ready(->
  ##############################
  # Viewport Constraints
  ##############################
  WIDTH = 400
  HEIGHT = 300

  VERTEX_WIDTH = 4
  VERTEX_HEIGHT = 4

  GRID_WIDTH = Math.floor(WIDTH / VERTEX_WIDTH)
  GRID_HEIGHT = Math.floor(HEIGHT / VERTEX_HEIGHT)

  PARTICLE_COUNT = GRID_WIDTH * GRID_HEIGHT


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


  # derive particle count from the particle size and viewport dimensions
  particleCount = PARTICLE_COUNT

  pGeometry = new THREE.Geometry()
  pMaterial = new THREE.ParticleBasicMaterial(
    color: 0xFFFFFF
    size: 4
    # blending: THREE.NormalBlending
    opacity: 0.6
    transparent: false
    vertexColors: true
  )

  colors = []

  # Create and add the particles as vertices in the new geometry
  for p in [0..particleCount] by 1
    # get x
    pX = (p % GRID_WIDTH) * VERTEX_WIDTH
    # get y
    pY = Math.floor(p / GRID_WIDTH) * VERTEX_HEIGHT
    # constant z
    pZ = 20

    particle = new THREE.Vector3(pX,pY,pZ)
    pGeometry.vertices.push(particle)

    # get the color
    colors[p] = new THREE.Color();
    colors[p].setHSV(Math.random(), 1.0, 1.0)

  # add colors
  pGeometry.colors = colors

  # Create the particle system
  particleSystem = new THREE.ParticleSystem(pGeometry, pMaterial)

  # Enable particle sorting (?)
  # particleSystem.sortParticles = true

  # Add the particle system to the scene
  scene.add(particleSystem)


  ##############################
  # SET UP THE LIGHTS
  ##############################
  pointLight = new THREE.PointLight(0xFFFFFF)
  pointLight.position.x = 0
  pointLight.position.y = 0
  pointLight.position.z = 0

  scene.add(pointLight)

  light = new THREE.PointLight( 0xFFFF00 )
  light.position.set( 10, 0, 10 )
  scene.add( light )

  ##############################f
  # SET UP THE RENDER LOOP
  ##############################
  renderer.render(scene, camera)

  # return true


  # Declare the animation loop
  # frame = 0
  # update = ->
  #   uniforms.amplitude.value = Math.sin(frame)

  #   # update the frame
  #   frame += 0.1

  #   # Draw the scene
  #   renderer.render(scene, camera)

  #   # Set up the next call of update()
  #   requestAnimFrame(update)

  # requestAnimFrame(update)

)