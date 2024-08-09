draw_self();
draw_set_color(c_white);
draw_set_font(fnt_energy);
draw_text(x+20, y+15, string(obj_game_manager.current_health) + "/" + string(obj_game_manager.max_health));
