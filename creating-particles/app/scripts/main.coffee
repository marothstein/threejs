$(document).ready(->
  # Viewport Constraints
  WIDTH = 400
  HEIGHT = 300

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
  particleCount = 2000
  particles = new THREE.Geometry()
  pMaterial = new THREE.ParticleBasicMaterial(
    color: 0xFFFFFF
    size: 20
    map: THREE.ImageUtils.loadTexture("images/particle.png")
    blending: THREE.AdditiveBlending
    transparent: true
  )

  # Create and add the particles as vertices in the new geometry
  for p in [0..particleCount] by 1
    pX = Math.random()*500 - 250
    pY = Math.random()*500 - 250
    pZ = Math.random()*500 - 250
    particle = new THREE.Vector3(pX,pY,pZ)

    particles.vertices.push(particle)

  # Create the particle system
  particleSystem = new THREE.ParticleSystem(particles, pMaterial)

  # Enable particle sorting (?)
  particleSystem.sortParticles = true

  # Add the particle system to the scene
  scene.add(particleSystem)

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
  # renderer.render(scene, camera)

  window.particles = particles
  # return true


  # Declare the animation loop
  update = ->
    # Start the system rotating
    particleSystem.rotation.y += 0.01

    # Add velocity to the particles
    pCount = particleCount
    while pCount-- > -1
      particle = particles.vertices[pCount]

      if particle
        if particle.y < -200 then particle.y = 200

        # Move the particle along the y-axis at a predetermined speed
        particle.y -= Math.random() * 0.1

    # Let the renderer know that the vertices need to be rerendered
    particleSystem.geometry.__dirtyVertices = true

    # Draw the scene
    renderer.render(scene, camera)

    # Set up the next call of update()
    requestAnimFrame(update)


  requestAnimFrame(update)

)