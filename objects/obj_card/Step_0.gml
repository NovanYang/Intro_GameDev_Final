if(in_player_hand && obj_card_manager.state == CARD_STATES.ACTION){
	if(position_meeting(mouse_x, mouse_y, id)){
		if(mouse_check_button_pressed(mb_left)){
			//show_debug_message("Mouse button pressed over object");
		}
	}
}

if(obj_card_manager.state == CARD_STATES.ACTION){
	if(in_player_hand && !discard){
		if(position_meeting(mouse_x, mouse_y, id)){
			if(!picked){
				target_y = target_y - 10;
				picked = true;
			}
			if(mouse_check_button_pressed(mb_left)){
				//show_debug_message("leave hand!");
				lock = true;
				ds_list_add(obj_card_manager.selected, id);
				//ds_list_delete(obj_card_manager.player_hand, ds_list_find_index(obj_card_manager.player_hand, id));
				for(var _i = 0; _i < ds_list_size(obj_card_manager.player_hand); _i++){
					if(ds_list_find_value(obj_card_manager.player_hand, _i) == id){
						ds_list_delete(obj_card_manager.player_hand, _i);
					}
				}
				audio_play_sound(snd_move, 1, false);
			}
		}
		else{
			if(picked && !lock){
				target_y = target_y + 10;
				picked = false;
			}
		}
	}
}


