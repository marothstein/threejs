(function() {
  $(document).ready(function() {
    var $container, ASPECT, FAR, HEIGHT, NEAR, VIEW_ANGLE, WIDTH, camera, fShader, radius, renderer, rings, scene, segments, sphere, vShader;

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
    radius = 50;
    segments = 16;
    rings = 16;
    vShader = $("#vertexshader");
    fShader = $("#fragmentshader");
    console.log("Vertex Shader: ", vShader, "Text: " + (vShader.text()));
    console.log("Fragment Shader: ", fShader, "Text: " + (fShader.text()));
    sphere = new THREE.Mesh(new THREE.SphereGeometry(radius, segments, rings), new THREE.ShaderMaterial({
      vertexshader: vShader.text(),
      fragmentshader: fShader.text()
    }));
    scene.add(sphere);
    return renderer.render(scene, camera);
  });

}).call(this);
