//same thing with obj_card
draw_self();
if(obj_card_manager.state == CARD_STATES.CHOOSE_ENEMY && !died){
	//show_debug_message("loc!");
	draw_sprite(spr_card_loc, 0, x, y);
}

draw_set_font(fnt_enemy);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_text(x - 20, y + 40, attack_point);
draw_text(x + 20, y + 40, health_point);

//if the card is farther than 1 from its target
if(abs(x - target_x) > 1) {
	//move towards the target by 10%
	x = lerp(x, target_x, .1);
	//draw above other cards
	depth = -1000;
	//if the card is less than 1 from its target
} else {
	//set its x to the target as well as the depth
	x = target_x;
	depth = target_depth;
}

//if the card is farther than 1 from its target
if(abs(y - target_y) > 1) {
	//move towards the target by 10%
	y = lerp(y, target_y, .1);
	//draw above other cards
	depth = -1000;
	//if the cards is less than 1 from its target
} else {
	//set the y to the target as well as the depth
	y = target_y;
	depth = target_depth;
}

if(died){
	sprite_index = spr_enemy_died;
}