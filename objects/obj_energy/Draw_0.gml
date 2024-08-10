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