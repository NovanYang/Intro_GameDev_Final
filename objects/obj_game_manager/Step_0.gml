show_debug_message(ds_list_size(enemies));
switch(state){
	//when the level just start
	case STATES.LEVEL_START:
		//create ui indicating the start of the level
		var _new_level_ui = instance_create_layer(room_width/2, room_height/2, "Instances", obj_ui);
		_new_level_ui.ui_type = "LEVEL_START";
		_new_level_ui.ui_message = "LEVEL " + string(level);
		_new_level_ui.appear_duration = 100;
		_new_level_ui.permanant = false;
		state = STATES.ENEMY_GENERATE;
		break;
		
	case STATES.ENEMY_GENERATE:
		//show_debug_message("Generate!");
		//generate enemy according to current room
		if(room == rm_level_1){
			//two enemies created in LEVEL 1
			var _enemy_one = instance_create_layer(224, -100, "Instances", obj_enemy);
			_enemy_one.attack_point = 1;
			_enemy_one.health_point = 3;
			_enemy_one.target_x = 224;
			_enemy_one.target_y = 352;
			_enemy_one.died = false;
			ds_list_add(enemies, _enemy_one);
			
			var _enemy_two = instance_create_layer(384, -100, "Instances", obj_enemy);
			_enemy_two.attack_point = 3;
			_enemy_two.health_point = 2;
			_enemy_two.target_x = 384;
			_enemy_two.target_y = 352;
			_enemy_two.died = false;
			ds_list_add(enemies, _enemy_two);
		}
		state = STATES.PLAYER_ROUND_INITIAL;
		break;
	
	//start the card states
	case STATES.PLAYER_ROUND_INITIAL:
		obj_card_manager.state = CARD_STATES.INITIAL;
		state = STATES.PLAYER_ROUND;
	
	//if all enemies killed in player's round, game win (might need to change that for dot mechanics)
	case STATES.PLAYER_ROUND:
		if(ds_list_size(enemies) == 0){
			audio_stop_all();
			room_goto(rm_level_end);
		}
		break;
		
	case STATES.ENEMY_ROUND:
		//have all the enemies take turn to deal damage to the player
		if(attack_timer == 0){
			//show_debug_message("Enemy ATTACK!");
			var _enemy_count = ds_list_size(enemies);
			//when still have enemy that have not attack the player
			if(_enemy_count > 0){
				var _enemy = ds_list_find_value(enemies, ds_list_size(enemies) - 1);
				//put that enemy into attacking list
				ds_list_delete(enemies, ds_list_size(enemies) - 1);
				ds_list_add(attacking, _enemy);
				_enemy.target_y = 352 + 20;
				//deal damage
				current_health -= _enemy.attack_point;
				audio_play_sound(snd_enemy, 1, false);
				instance_create_depth(x, y, -2000, obj_player_hit_effect);
			}
			else{
				var _attacked_count = ds_list_size(attacking);
				//set the attacked enemy to the final list
				if(_attacked_count > 0){
					//show_debug_message("lalalalalal");
					var _enemy = ds_list_find_value(attacking, ds_list_size(attacking) - 1);
					ds_list_delete(attacking, ds_list_size(attacking) - 1);
					ds_list_add(attacked, _enemy);
					_enemy.target_y = 352 - 20;
				}
				else{
					//return all enemy to original list
					for(var _i = 0; _i < ds_list_size(attacked); _i++){
						ds_list_add(enemies, ds_list_find_value(attacked, _i))
					}
					ds_list_clear(attacked);
					state = STATES.PLAYER_ROUND;
					current_energy = max_energy;
					if(ds_list_size(obj_card_manager.deck) == 0){
						obj_card_manager.state = CARD_STATES.SHUFFLE;
					}
					else{
						obj_card_manager.state = CARD_STATES.INITIAL;
					}
				}
			}
		}
		if(current_health <= 0){
			audio_stop_all();
			room_goto(rm_level_start);
		}
		break;
		
}

attack_timer++;

if(attack_timer > 40){
	attack_timer = 0;
}