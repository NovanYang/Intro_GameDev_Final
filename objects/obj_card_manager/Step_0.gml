//show_debug_message(obj_game_manager.current_energy);
//show_debug_message(ds_list_size(selected));
switch(state) {
    case CARD_STATES.STAND_BY:
        break;
    
    case CARD_STATES.INITIAL:

        if (move_timer == 0) {
            var _player_num = ds_list_size(player_hand);
            if (_player_num < 3) {
				//show_debug_message(_player_num);
                var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
                ds_list_delete(deck, ds_list_size(deck) - 1);
                ds_list_add(player_hand, _dealt_card);
                
                _dealt_card.in_player_hand = true;
                _dealt_card.target_x = room_width / 3 + _player_num * hand_x_offset;
                _dealt_card.target_y = room_height * 0.8;
				audio_play_sound(snd_move, 1, false);
            }
			else{
				state = CARD_STATES.REVEAL;
				break;
			}
        }
        break;
		
	case CARD_STATES.REVEAL:
		if(move_timer == 0){
			for(var _i = 0; _i < ds_list_size(player_hand); _i++){
				player_hand[| _i].face_up = true;
			}
			state = CARD_STATES.ACTION;
		}
		break;

    case CARD_STATES.ACTION:
		if(move_timer == 0){
			if(ds_list_size(selected) == 1){
				state = CARD_STATES.CHOOSE_ENEMY;
			}
		}
        break;
		
	case CARD_STATES.CHOOSE_ENEMY:
		break;
	
	case CARD_STATES.ATTACK:
		if(move_timer == 0){
			//show_debug_message("ATTACK!");
			var _target = ds_list_find_value(slot, 0);
			var _spell = ds_list_find_value(selected, 0);
			var _enough_energy = false;
			if(_spell.sprite_index == spr_blizzard){
				if(obj_game_manager.current_energy >= 3){
					_enough_energy = true;
					obj_game_manager.current_energy -= 3;
					with(obj_enemy){
						health_point -= 2;
					}
					audio_play_sound(snd_frost, 1, false);
				}
			}
			else if(_spell.sprite_index == spr_fireball){
				if(obj_game_manager.current_energy >= 2){
					_enough_energy = true;
					obj_game_manager.current_energy -= 2;
					_target.health_point -= 3;
					audio_play_sound(snd_fire, 1, false);
				}
			}
			else if(_spell.sprite_index == spr_kunai){
				if(obj_game_manager.current_energy >= 1){
					_enough_energy = true;
					obj_game_manager.current_energy -= 1;
					_target.health_point -= 1;
					audio_play_sound(snd_kunai, 1, false);
				}
			}
			
			if(_enough_energy){
				_spell.lock = false;
				_spell.discard = true;
				_spell.target_y = y - 2 * discard_track;
				_spell.target_x = 0.9 * room_width;
				_spell.target_depth = num_cards - discard_track;
				discard_track += 1;
				ds_list_add(discard, _spell);
				state = CARD_STATES.ACTION;
				audio_play_sound(snd_move, 1, false);
			}
			else{
				var _new_level_ui = instance_create_layer(room_width/2, room_height/2, "Instances", obj_ui);
				_new_level_ui.ui_type = "LEVEL_START";
				_new_level_ui.ui_message = "Lack of Energy";
				_new_level_ui.appear_duration = 30;
				_new_level_ui.permanant = false;
				_spell.lock = false;
				state = CARD_STATES.ACTION;
				ds_list_add(player_hand, _spell);
			}
			
			ds_list_delete(selected, 0);
			ds_list_delete(slot, 0);
		}
		break;
		
	case CARD_STATES.CLEAN_UP:
		if(move_timer == 0){
			var _player_num = ds_list_size(player_hand);
			if(_player_num > 0){
				var _hand_card = ds_list_find_value(player_hand, ds_list_size(player_hand) - 1);
				ds_list_delete(player_hand, ds_list_size(player_hand) - 1);
				ds_list_add(discard, _hand_card);
				_hand_card.discard = true;
				_hand_card.target_x = room_width * 0.9;
				_hand_card.target_y = y - 2 * discard_track;
				_hand_card.target_depth = num_cards - discard_track;
				discard_track += 1
				audio_play_sound(snd_move, 1, false);
				//show_debug_message("lalala");
			}
			else{
				state = CARD_STATES.STAND_BY;
				obj_game_manager.state = STATES.ENEMY_ROUND
			}
		}
		break;
		
	case CARD_STATES.SHUFFLE:
		shuffle_timer_2++;
		var _discard_num = ds_list_size(discard);
		var _unshuffled_num = ds_list_size(unshuffled_card);
		if(_discard_num > 0){
			if(shuffle_timer_2 > 5){
				var _discard_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
				ds_list_delete(discard, ds_list_size(discard) - 1);
				ds_list_insert(unshuffled_card, 0, _discard_card);
				_discard_card.target_x = x;
				_discard_card.target_y = y - (2 * _unshuffled_num);
				_discard_card.target_depth = num_cards - _unshuffled_num;
				_discard_card.face_up = false;
				_discard_card.in_player_hand = false;
				_discard_card.picked = false;
				_discard_card.lock = false;
				_discard_card.discard = false;
				shuffle_timer_2 = 0;
				audio_play_sound(snd_move, 1, false);
			}
		}
		else{
			ds_list_shuffle(unshuffled_card);
			state = CARD_STATES.RESTART;
			discard_track = 0;
		}
		break;
	
	case CARD_STATES.RESTART:
		shuffle_timer++;
		shuffle_timer_2++;
		if(shuffle_timer > 30 && shuffle_timer_2 > 5){
			var _unshuffled_num = ds_list_size(unshuffled_card);
			var _deck_num = ds_list_size(deck);
			if(_unshuffled_num > 0){
				var _unshuffled_card = ds_list_find_value(unshuffled_card, ds_list_size(unshuffled_card) - 1);
				ds_list_delete(unshuffled_card, ds_list_size(unshuffled_card) - 1);
				ds_list_add(deck, _unshuffled_card);
				_unshuffled_card.target_x = x;
				_unshuffled_card.target_y = y - (2 * _deck_num);
				_unshuffled_card.target_depth = num_cards - _deck_num;
				shuffle_timer_2 = 0;
				audio_play_sound(snd_move, 1, false);
			}
			else{
				state = CARD_STATES.INITIAL;
			}
		}
		break;
}


move_timer++;

if(move_timer > 20){
	move_timer = 0;
}