(function() {
  var layoutVertices, vertices;

  vertices = [];

  layoutVertices = function() {};

  $(document).ready(function() {
    var $container, ASPECT, FAR, GRID_HEIGHT, GRID_WIDTH, HEIGHT, NEAR, PARTICLE_COUNT, VERTEX_HEIGHT, VERTEX_WIDTH, VIEW_ANGLE, WIDTH, attributes, camera, colors, fShader, light, p, pGeometry, pMaterial, pX, pY, pZ, particle, particleCount, particleSystem, pointLight, radius, renderer, rings, scene, segments, uniforms, vShader, _i;

    WIDTH = 400;
    HEIGHT = 300;
    VERTEX_WIDTH = 4;
    VERTEX_HEIGHT = 4;
    GRID_WIDTH = Math.floor(WIDTH / VERTEX_WIDTH);
    GRID_HEIGHT = Math.floor(HEIGHT / VERTEX_HEIGHT);
    PARTICLE_COUNT = GRID_WIDTH * GRID_HEIGHT;
    VIEW_ANGLE = 45;
    ASPECT = WIDTH / HEIGHT;
    NEAR = 0.1;
    FAR = 10000;
    $container = $("#container");
    renderer = new THREE.WebGLRenderer();
    renderer.setSize(WIDTH, HEIGHT);
    $container.append(renderer.domElement);
    scene = new THREE.Scene();
    camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR);
    camera.position.set(-15, 10, 10);
    camera.lookAt(scene.position);
    scene.add(camera);
    attributes = {
      displacement: {
        type: 'f',
        value: []
      }
    };
    uniforms = {
      amplitude: {
        type: 'f',
        value: 0
      }
    };
    radius = 4;
    segments = 8;
    rings = 8;
    vShader = $("#vertexshader");
    fShader = $("#fragmentshader");
    particleCount = PARTICLE_COUNT;
    pGeometry = new THREE.Geometry();
    pMaterial = new THREE.ParticleBasicMaterial({
      color: 0xFFFFFF,
      size: 4,
      opacity: 0.6,
      transparent: false,
      vertexColors: true
    });
    colors = [];
    for (p = _i = 0; _i <= particleCount; p = _i += 1) {
      pX = (p % GRID_WIDTH) * VERTEX_WIDTH;
      pY = Math.floor(p / GRID_WIDTH) * VERTEX_HEIGHT;
      pZ = 20;
      particle = new THREE.Vector3(pX, pY, pZ);
      pGeometry.vertices.push(particle);
      colors[p] = new THREE.Color();
      colors[p].setHSV(Math.random(), 1.0, 1.0);
    }
    pGeometry.colors = colors;
    particleSystem = new THREE.ParticleSystem(pGeometry, pMaterial);
    scene.add(particleSystem);
    pointLight = new THREE.PointLight(0xFFFFFF);
    pointLight.position.x = 0;
    pointLight.position.y = 0;
    pointLight.position.z = 0;
    scene.add(pointLight);
    light = new THREE.PointLight(0xFFFF00);
    light.position.set(10, 0, 10);
    scene.add(light);
    return renderer.render(scene, camera);
  });

}).call(this);
