//when enemy property of died set true, delete from enemy list and desotry itself
if(sprite_index == spr_enemy_died){
	for(var _i = 0; _i < ds_list_size(obj_game_manager.enemies); _i++){
		if(ds_list_find_value(obj_game_manager.enemies, _i) == id){
			ds_list_delete(obj_game_manager.enemies, _i);
		}
	}
	audio_play_sound(snd_enemy_died, 1, false);
	instance_destroy(id);
}

/**
if(sprite_index == spr_enemy_died){
	var _enemy_index = ds_list_find_index(obj_game_manager.enemies, id);
	ds_list_delete(obj_game_manager.enemies, _enemy_index);
	instance_destroy(id);
}
**/