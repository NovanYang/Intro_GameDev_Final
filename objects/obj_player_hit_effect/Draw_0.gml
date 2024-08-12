effect_timer++

if(effect_timer < effect_duration){
	draw_set_alpha(0.5);
	draw_set_color(c_red);
	draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
	draw_set_alpha(1.0);
}
else{
	instance_destroy(id);
}