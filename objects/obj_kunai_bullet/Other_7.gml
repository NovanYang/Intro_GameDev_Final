if(sprite_index == spr_kunai_hit){
	audio_play_sound(snd_kunai_hit, 1, false);
	var _hit_enemy = instance_nearest(x, y, obj_enemy);
	instance_create_depth(_hit_enemy.x, _hit_enemy.y, -2000, obj_enemy_hit_effect);
	_hit_enemy.health_point -= 1;
	instance_destroy(id);
}