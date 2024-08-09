/// @description Insert description here
// You can write your code in this editor

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

//draw the card to the target depth (this is for staggered effects)
//depth = target_depth;

//show the card's face based on its index
if(face_index == 0) sprite_index = spr_fireball;
if(face_index == 1) sprite_index = spr_blizzard;
if(face_index == 2) sprite_index = spr_kunai;

//BUT if the card is face up, just show the card back
if(!face_up) sprite_index = spr_back;


//draw the card
draw_sprite(sprite_index, image_index, x, y);

if(lock){
	draw_sprite(spr_card_lock, 0, x, y);
}






