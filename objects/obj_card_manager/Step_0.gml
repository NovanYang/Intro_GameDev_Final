switch(state) {
	//do nothing in stand by state
    case CARD_STATES.STAND_BY:
        break;
    
	//deals 3 cards
    case CARD_STATES.INITIAL:

        if (move_timer == 0) {
			//find the number of cards in players hand
            var _player_num = ds_list_size(player_hand);
			//when cards in hand is less then 3, deal
            if (_player_num < 3) {
                var _dealt_card = ds_list_find_value(deck, ds_list_size(deck) - 1);
				//list management
                ds_list_delete(deck, ds_list_size(deck) - 1);
                ds_list_add(player_hand, _dealt_card);
                
				//card roperties change
                _dealt_card.in_player_hand = true;
                _dealt_card.target_x = room_width / 3 + _player_num * hand_x_offset;
                _dealt_card.target_y = room_height * 0.85;
				audio_play_sound(snd_move, 1, false);
            }
			else{
				//change state to REVEAL
				state = CARD_STATES.REVEAL;
				break;
			}
        }
        break;
	
	//change the property of card of face up to true
	case CARD_STATES.REVEAL:
		var _new_level_ui = instance_create_layer(room_width/2, room_height/2, "Instances", obj_ui);
		_new_level_ui.ui_type = "LEVEL_START";
		_new_level_ui.ui_message = "YOUR ROUND";
		_new_level_ui.appear_duration = 30;
		_new_level_ui.permanant = false;
		if(move_timer == 0){
			//change all cards in the hands list
			for(var _i = 0; _i < ds_list_size(player_hand); _i++){
				player_hand[| _i].face_up = true;
			}
			state = CARD_STATES.ACTION;
		}
		break;
	
	//when specific one card is selected, goes to the choose enemy state
    case CARD_STATES.ACTION:
		if(move_timer == 0){
			if(ds_list_size(selected) == 1){
				state = CARD_STATES.CHOOSE_ENEMY;
			}
		}
        break;
	
	//obj_enemy clicked to change state
	case CARD_STATES.CHOOSE_ENEMY:
		break;
	
	//calculate for round damage and cast spell
	case CARD_STATES.ATTACK:
		if(move_timer == 0){
			//set variable for target enemy, used spell and boolean to check if energy energy can be used
			var _target = ds_list_find_value(slot, 0);
			var _spell = ds_list_find_value(selected, 0);
			var _enough_energy = false;
			//check for energy use and deal damage if has enough energy
			if(_spell.sprite_index == spr_blizzard_new){
				if(obj_game_manager.current_energy >= 3){
					_enough_energy = true;
					obj_game_manager.current_energy -= 3;
					with(obj_enemy){
						health_point -= 2;
						//instance_create_depth(x, y, -2000, obj_enemy_hit_effect);
					}
					instance_create_depth(0, 128, -2000, obj_blizzard_effect);
					audio_play_sound(snd_frost, 1, false);
				}
			}
			else if(_spell.sprite_index == spr_fireball_new){
				if(obj_game_manager.current_energy >= 2){
					_enough_energy = true;
					obj_game_manager.current_energy -= 2;
					//_target.health_point -= 3;
					audio_play_sound(snd_fire, 1, false);
					//instance_create_depth(_target.x, _target.y, -2000, obj_enemy_hit_effect);
					var _fireball_bullet = instance_create_depth(_spell.x, _spell.y, -2000, obj_fireball_bullet);
					_fireball_bullet.speed = 10;
					_fireball_bullet.direction = point_direction(_spell.x, _spell.y, _target.x, _target.y);
					_fireball_bullet.image_angle = _fireball_bullet.direction;
				}
			}
			else if(_spell.sprite_index == spr_kunai_new){
				if(obj_game_manager.current_energy >= 1){
					_enough_energy = true;
					obj_game_manager.current_energy -= 1;
					//_target.health_point -= 1;
					audio_play_sound(snd_kunai, 1, false);
					//instance_create_depth(_target.x, _target.y, -2000, obj_enemy_hit_effect);
					var _kunai_bullet = instance_create_depth(_spell.x, _spell.y, -2000, obj_kunai_bullet);
					_kunai_bullet.speed = 15;
					_kunai_bullet.direction = point_direction(_spell.x, _spell.y, _target.x, _target.y);
					_kunai_bullet.image_angle = _kunai_bullet.direction;
				}
			}
			
			//if the card is correctly 
			if(_enough_energy){
				//set property of the casted spell card
				_spell.lock = false;
				_spell.discard = true;
				//set to the discard location and depth
				_spell.target_y = _spell.y - 20;
				_spell.target_x = _spell.x;
				_spell.target_depth = num_cards - discard_track;
				discard_track += 1;
				//add to discard list
				ds_list_add(discard, _spell);
				state = CARD_STATES.ATTACK_DISPLAY;
				audio_play_sound(snd_move, 1, false);
			}
			else{
				//Add a new UI indicate the Lack of energy
				var _new_level_ui = instance_create_layer(room_width/2, room_height/2, "Instances", obj_ui);
				_new_level_ui.ui_type = "LEVEL_START";
				_new_level_ui.ui_message = "Lack of Energy";
				_new_level_ui.appear_duration = 30;
				_new_level_ui.permanant = false;
				_spell.lock = false;
				//return to ACTION state
				state = CARD_STATES.ACTION;
				ds_list_add(player_hand, _spell);
			}
			
			ds_list_delete(selected, 0);
			ds_list_delete(slot, 0);
		}
		break;
		
	case CARD_STATES.CLEAN_UP:
		if(move_timer == 0){
			//clean up player's hands list
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
			}
			//return to stand by state and go to enemy round
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
				//put the top card from discard to the bottom of the unshuffled list
				var _discard_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
				ds_list_delete(discard, ds_list_size(discard) - 1);
				ds_list_insert(unshuffled_card, 0, _discard_card);
				//set location by to the deck and reset the properties
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
			//goes to the restart state
			state = CARD_STATES.RESTART;
			discard_track = 0;
		}
		break;
	
	case CARD_STATES.RESTART:
		//reorder each card in the unshuffled list
		shuffle_timer++;
		shuffle_timer_2++;
		if(shuffle_timer > 30 && shuffle_timer_2 > 5){
			var _unshuffled_num = ds_list_size(unshuffled_card);
			var _deck_num = ds_list_size(deck);
			if(_unshuffled_num > 0){
				var _unshuffled_card = ds_list_find_value(unshuffled_card, ds_list_size(unshuffled_card) - 1);
				//put the card back to deck
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
	
	case CARD_STATES.ATTACK_DISPLAY:
		var _attacked_card = ds_list_find_value(discard, ds_list_size(discard) - 1);
		shuffle_timer ++;
		if(shuffle_timer > 60){
			_attacked_card.target_y =  y - 2 * discard_track;
			_attacked_card.target_x = 0.9 * room_width;
			shuffle_timer = 0;
			state = CARD_STATES.ACTION;
		}
		break;
}


move_timer++;

if(move_timer > 20){
	move_timer = 0;
}