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

  # Create the sphere mesh
  sphere = new THREE.Mesh(
    new THREE.SphereGeometry(radius, segments, rings),
    new THREE.MeshLambertMaterial({color: 0xCC0000})
  )

  # Add the sphere mesh to the scene
  scene.add(sphere)

  ##############################
  # SET UP THE LIGHTS
  ##############################
  pointLight = new THREE.PointLight(0xFFFFFF)
  pointLight.x = 10
  pointLight.y = 50
  pointLight.z = 130

  scene.add(pointLight)

  ##############################
  # SET UP THE RENDER LOOP
  ##############################
  renderer.render(scene, camera)
)