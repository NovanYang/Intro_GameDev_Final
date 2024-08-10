//when pressed and release, indicate a correct cancel action
if(clicked){
	//return to the initial image index
	image_index = 0;
	//unlock all the cards
	if(obj_card_manager.state == CARD_STATES.CHOOSE_ENEMY){
		with(obj_card){
			lock = false;
		}
		
		//add the selected card back to player's hand
		ds_list_add(obj_card_manager.player_hand, ds_list_find_value(obj_card_manager.selected, 0));
		//delete from the selected list
		ds_list_delete(obj_card_manager.selected, 0);
		//return to action state
		obj_card_manager.state = CARD_STATES.ACTION;
	}
}