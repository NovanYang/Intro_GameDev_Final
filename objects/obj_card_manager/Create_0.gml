//position of hand

hand_x_offset = 100;

//number of cards in deck
//num_cards = 0;

enum CARD_STATES{
	STAND_BY,
	INITIAL,
	REVEAL,
	ACTION,
	CHOOSE_ENEMY,
	DEAL,
	CLEAN_UP,
	SHUFFLE,
	RESTART,
	ATTACK
}

//set the initial state to opponent deal
state = CARD_STATES.STAND_BY;

//this controls when a card can move
//from the deck to the hand
//or the hand to the discard
//or the discard to the deck
//you'll need a seperate one for when the game pauses
//to show the player information
move_timer = 0;
choose_timer = 0;
shuffle_timer = 0;
shuffle_timer_2 = 0;
discard_track = 0;

//lists for different card states
deck = ds_list_create();
player_hand = ds_list_create();
selected = ds_list_create();
discard = ds_list_create();
unshuffled_card = ds_list_create();
slot = ds_list_create();

for(var _i = 0; _i < num_cards; _i++){
	//make a card
	var _new_card = instance_create_layer(x, y, "Instances", obj_card);
	_new_card.face_index = _i % 3;
	_new_card.face_up = false;
	_new_card.in_player_hand = false;
	_new_card.picked = false;
	_new_card.lock = false;
	_new_card.enemy = false;
	_new_card.discard = false;
	_new_card.target_depth = 0;
	_new_card.target_x = x;
	_new_card.target_y = y;
	ds_list_add(deck, _new_card);
}

//shuffle the deck
randomize();
ds_list_shuffle(deck);

//set the depth and y pos of the cards to be staggered
//to make it look like a real deck
for(var _i = 0; _i < num_cards; _i++){
	deck[| _i].target_depth = num_cards - _i;
	deck[| _i].target_y = y - (2 * _i);
}
