if(position_meeting(mouse_x, mouse_y, id)){
	show_description_timer++;
}
else{
	show_description_timer = 0;
	show_description = false;
}

if(show_description_timer > show_description_duration){
	show_description = true;
}