extends Node2D

const player: String = "Player"
const cpu: String = "Máquina"

@onready var first_choose: Node = $CanvasLayer/FirstChoose
@onready var board: GridContainer = $CanvasLayer/Board
@onready var text_label: Label = $CanvasLayer/TextLabel
@onready var cell_1: Button = $CanvasLayer/Board/Cell1
@onready var cell_2: Button = $CanvasLayer/Board/Cell2
@onready var cell_3: Button = $CanvasLayer/Board/Cell3
@onready var cell_4: Button = $CanvasLayer/Board/Cell4
@onready var cell_5: Button = $CanvasLayer/Board/Cell5
@onready var cell_6: Button = $CanvasLayer/Board/Cell6
@onready var cell_7: Button = $CanvasLayer/Board/Cell7
@onready var cell_8: Button = $CanvasLayer/Board/Cell8
@onready var cell_9: Button = $CanvasLayer/Board/Cell9
@onready var cell_list: Array[Button]

@export var cpu_thinking_time: int = 2

var win_conditions: Dictionary = {"column1": "", "column2": "", "column3": "",
								"line1": "", "line2": "", "line3": "",
								"diagonal1": "", "diagonal2": ""}
var player_symbol: String
var cpu_symbol: String
var turn: String
var turn_number: int
var player_wins: bool = false
var cpu_wins: bool = false

func _ready() -> void:
	turn_number = 1
	for cell: Button in board.get_children():
		cell_list.append(cell)
	turn = player if randi_range(0,1) == 0 else cpu
	if turn == cpu:
		set_cpu_symbol()

func _process(_delta: float) -> void:
	if player_wins:
		text_label.text = "Você venceu"
		for cell: Button in board.get_children():
			cell.disabled = true
	elif cpu_wins:
		text_label.text = "A máquina venceu"
		for cell: Button in board.get_children():
			cell.disabled = true
	else:
		text_label.text = "É a sua vez" if turn == player else "É a vez da máquina"

func update_win_conditions(symbol: String) -> void:
	if(cell_list[0].text == cell_list[3].text and cell_list[0].text == cell_list[6].text and cell_list[0].text == symbol):
		win_conditions["column1"] = symbol
	elif(cell_list[1].text == cell_list[4].text and cell_list[1].text == cell_list[7].text and cell_list[1].text == symbol):
		win_conditions["column2"] = symbol
	elif(cell_list[2].text == cell_list[5].text and cell_list[2].text == cell_list[8].text and cell_list[2].text == symbol):
		win_conditions["column3"] = symbol
	elif(cell_list[0].text == cell_list[1].text and cell_list[0].text == cell_list[2].text and cell_list[0].text == symbol):
		win_conditions["line1"] = symbol
	elif(cell_list[3].text == cell_list[4].text and cell_list[3].text == cell_list[5].text and cell_list[3].text == symbol):
		win_conditions["line2"] = symbol
	elif(cell_list[6].text == cell_list[7].text and cell_list[6].text == cell_list[8].text and cell_list[6].text == symbol):
		win_conditions["line3"] = symbol
	elif(cell_list[0].text == cell_list[4].text and cell_list[0].text == cell_list[8].text and cell_list[0].text == symbol):
		win_conditions["diagonal1"] = symbol
	elif(cell_list[2].text == cell_list[4].text and cell_list[2].text == cell_list[6].text and cell_list[2].text == symbol):
		win_conditions["diagonal2"] = symbol

func set_cpu_symbol():
	var available_cells: Array[Button] = cell_list.filter(func(button: Button):
		return button.disabled == false
		)
	
	var cell: Button = available_cells.pick_random()
	cell.text = cpu_symbol
	cell.disabled = true
	update_win_conditions(cpu_symbol)
	if(cpu_symbol in win_conditions.values()):
		cpu_wins = true
	change_turn()

func set_clicked_cell_symbol(cell: Button):
	cell.text = player_symbol
	cell.disabled = true
	update_win_conditions(player_symbol)
	if(player_symbol in win_conditions.values()):
		player_wins = true
	change_turn()

func change_turn() -> void:
	if player_wins or cpu_wins:
		return
	if turn == player:
		turn = cpu
		set_cpu_symbol()
	else:
		turn = player
	turn_number += 1

func _on_cell_1_pressed() -> void:
	set_clicked_cell_symbol(cell_1)

func _on_cell_2_pressed() -> void:
	set_clicked_cell_symbol(cell_2)

func _on_cell_3_pressed() -> void:
	set_clicked_cell_symbol(cell_3)

func _on_cell_4_pressed() -> void:
	set_clicked_cell_symbol(cell_4)

func _on_cell_5_pressed() -> void:
	set_clicked_cell_symbol(cell_5)

func _on_cell_6_pressed() -> void:
	set_clicked_cell_symbol(cell_6)

func _on_cell_7_pressed() -> void:
	set_clicked_cell_symbol(cell_7)

func _on_cell_8_pressed() -> void:
	set_clicked_cell_symbol(cell_8)

func _on_cell_9_pressed() -> void:
	set_clicked_cell_symbol(cell_9)

func _on_choose_o_pressed() -> void:
	player_symbol = "O"
	cpu_symbol = "X"
	board.visible = true
	text_label.visible = true
	for child: Control in first_choose.get_children():
		child.visible = false

func _on_choose_x_pressed() -> void:
	player_symbol = "X"
	cpu_symbol = "O"
	board.visible = true
	text_label.visible = true
	for child: Control in first_choose.get_children():
		child.visible = false
