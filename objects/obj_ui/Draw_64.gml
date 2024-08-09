//set different color and font for different types of ui
switch(ui_type){
	case "LEVEL_START":
		draw_set_halign(fa_center);
		draw_set_font(fnt_level_ui);
		draw_set_color(c_gray);
	
	case "ENERGY":
		
}

//when the ui should not appear permanantly
if(!permanant){
	if(appear_timer < appear_duration){
		draw_text(x, y, ui_message);
		appear_timer++
	}
	else{
		//destory the ui once it should be
		instance_destroy();
	}
}
else{
	draw_text(x, y, ui_message);
}