if(place_meeting(x, y, obj_enemy)){
	if(speed != 0){
		speed -= 1;
		y -= 1;
	}
	else{
		if(!play_audio){
			audio_play_sound(snd_fireball_explode, 1, false);
			play_audio = true;
		}
		var _hit_enemy = instance_nearest(x, y, obj_enemy);
		image_speed = 1;
		sprite_index = spr_hit_by_fireball;
		
	}
}