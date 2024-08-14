if(place_meeting(x, y, obj_enemy)){
	if(speed != 0){
		speed -= 3;
		y -= 2;
	}
	else{
		var _hit_enemy = instance_nearest(x, y, obj_enemy);
		image_speed = 1;
		sprite_index = spr_kunai_hit;	
	}
}