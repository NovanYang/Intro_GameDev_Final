if(clicked){
	image_index = 0;
	if(obj_card_manager.state == CARD_STATES.CHOOSE_ENEMY){
		with(obj_card){
			lock = false;
		}
		ds_list_add(obj_card_manager.player_hand, ds_list_find_value(obj_card_manager.selected, 0));
		ds_list_delete(obj_card_manager.selected, 0);
		obj_card_manager.state = CARD_STATES.ACTION;
	}
}