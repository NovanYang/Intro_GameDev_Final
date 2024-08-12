draw_self();
draw_set_font(fnt_energy);
//draw out the current energy
if(obj_game_manager.current_energy > 0){
	draw_set_color(c_yellow);
}
else{
	draw_set_color(c_red);
}
draw_text(x+20, y+15, string(obj_game_manager.current_energy) + "/" + string(obj_game_manager.max_energy));

if(show_description){
	draw_set_color(make_color_rgb(204, 142, 75));
	draw_rectangle(100, 250, room_width - 100, 450, false);
	draw_set_color(c_yellow);
	draw_rectangle(110, 260, room_width - 110, 440, true);
	draw_set_halign(fa_left);
	draw_set_font(fnt_description);
	draw_text_ext(120, 270, "Energy: used to spell case, refill after each round", 40, 350);
	draw_set_halign(fa_center);
	
}