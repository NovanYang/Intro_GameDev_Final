//when in choose enemy state
if(obj_card_manager.state == CARD_STATES.CHOOSE_ENEMY){
	if(position_meeting(mouse_x, mouse_y, id)){
		//if clicked, set the target enemy to this enemy
		if(mouse_check_button_pressed(mb_left) && !died){
			//show_debug_message(id);
			ds_list_add(obj_card_manager.slot, id);
			//goes to the attack state
			obj_card_manager.state = CARD_STATES.ATTACK;
		}
	}
}

if(health_point <= 0){
	died = true;
}

