(function() {
  $(document).ready(function() {
    var $container, ASPECT, FAR, HEIGHT, NEAR, VIEW_ANGLE, WIDTH, camera, p, pMaterial, pX, pY, pZ, particle, particleCount, particleSystem, particles, renderer, scene, update, _i;

    WIDTH = 400;
    HEIGHT = 500;
    VIEW_ANGLE = 45;
    ASPECT = WIDTH / HEIGHT;
    NEAR = 0.1;
    FAR = 10000;
    $container = $("#container");
    renderer = new THREE.WebGLRenderer();
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR);
    scene = new THREE.Scene();
    scene.add(camera);
    camera.position.z = 300;
    renderer.setSize(WIDTH, HEIGHT);
    $container.append(renderer.domElement);
    particleCount = 2000;
    particles = new THREE.Geometry();
    pMaterial = new THREE.ParticleBasicMaterial({
      color: 0xFFFFFF,
      size: 20,
      map: THREE.ImageUtils.loadTexture("images/particle.png"),
      blending: THREE.AdditiveBlending,
      transparent: true
    });
    for (p = _i = 0; _i <= particleCount; p = _i += 1) {
      pX = Math.random() * 500 - 250;
      pY = Math.random() * 500 - 250;
      pZ = Math.random() * 500 - 250;
      particle = new THREE.Vector3(pX, pY, pZ);
      particles.vertices.push(particle);
    }
    particleSystem = new THREE.ParticleSystem(particles, pMaterial);
    particleSystem.sortParticles = true;
    scene.add(particleSystem);
    window.particles = particles;
    update = function() {
      var pCount;

      particleSystem.rotation.y += 0.01;
      pCount = particleCount;
      while (pCount-- > -1) {
        particle = particles.vertices[pCount];
        if (particle) {
          if (particle.y < -200) {
            particle.y = 200;
          }
          particle.y -= Math.random() * 2;
        }
      }
      particleSystem.geometry.__dirtyVertices = true;
      renderer.render(scene, camera);
      return requestAnimFrame(update);
    };
    return requestAnimFrame(update);
  });

}).call(this);
