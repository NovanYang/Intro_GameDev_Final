//when pressed and release, indicate a correct end round action
if(clicked){
	image_index = 0;
	//goes to the clean up process and then enemy's round
	if(obj_card_manager.state == CARD_STATES.ACTION){
		obj_card_manager.state = CARD_STATES.CLEAN_UP;
	}
}