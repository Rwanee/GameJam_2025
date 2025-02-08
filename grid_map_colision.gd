extends GridMap

func _ready():
	for cell in get_used_cells():
		var mesh = mesh_library.get_item_mesh(get_cell_item(cell))
		if mesh:
			# Créer une forme de collision plus simple et plus performante
			var shape = BoxShape3D.new()  # Utiliser BoxShape3D au lieu de TrimeshShape
			shape.size = mesh.get_aabb().size  # Ajuster la taille selon le mesh
			
			var collision = CollisionShape3D.new()
			collision.shape = shape
			
			var static_body = StaticBody3D.new()
			static_body.add_child(collision)
			static_body.position = map_to_local(cell)
			add_child(static_body)
			
