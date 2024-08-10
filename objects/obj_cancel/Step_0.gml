//The canceallation of selected card can only used when the card is in Choose enemy state
if(obj_card_manager.state != CARD_STATES.CHOOSE_ENEMY){
	visible = false;
}
else{
	visible = true;
}
