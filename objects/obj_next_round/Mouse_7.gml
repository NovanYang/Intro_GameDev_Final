if(clicked){
	image_index = 0;
	if(obj_card_manager.state == CARD_STATES.ACTION){
		obj_card_manager.state = CARD_STATES.CLEAN_UP;
	}
}