draw_self();
//text out the current health
draw_set_color(c_white);
draw_set_font(fnt_energy);
draw_text(x+20, y+15, string(obj_game_manager.current_health) + "/" + string(obj_game_manager.max_health));

if(show_description){
	draw_set_color(make_color_rgb(204, 142, 75));
	draw_rectangle(100, 250, room_width - 100, 450, false);
	draw_set_color(c_red);
	draw_rectangle(110, 260, room_width - 110, 440, true);
	draw_set_halign(fa_left);
	draw_set_font(fnt_description);
	draw_text_ext(120, 270, "Health: Current health, lose the match if dropped to 0 or below", 40, 350);
	draw_set_halign(fa_center);
	
}
