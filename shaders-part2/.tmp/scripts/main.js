(function() {
  $(document).ready(function() {
    var $container, ASPECT, FAR, HEIGHT, NEAR, VIEW_ANGLE, WIDTH, attributes, camera, fShader, frame, i, radius, renderer, rings, scene, segments, sphere, sphereVertices, uniforms, update, vShader, values, _i, _ref;

    WIDTH = 400;
    HEIGHT = 300;
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
    sphere = new THREE.Mesh(new THREE.SphereGeometry(radius, segments, rings), new THREE.ShaderMaterial({
      uniforms: uniforms,
      attributes: attributes,
      vertexShader: vShader.text(),
      fragmentShader: fShader.text()
    }));
    scene.add(sphere);
    sphereVertices = sphere.geometry.vertices;
    values = attributes.displacement.value;
    for (i = _i = 0, _ref = sphereVertices.length - 1; _i <= _ref; i = _i += 1) {
      values.push(Math.random() * 3);
    }
    frame = 0;
    update = function() {
      uniforms.amplitude.value = Math.sin(frame);
      frame += 0.1;
      renderer.render(scene, camera);
      return requestAnimFrame(update);
    };
    return requestAnimFrame(update);
  });

}).call(this);
