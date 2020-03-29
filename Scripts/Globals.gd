extends Node

#warning-ignore:unused_class_variable
var state = "Menu"
#warning-ignore:unused_class_variable
var money = 1000
#warning-ignore:unused_class_variable
var buildMode = 0
#warning-ignore:unused_class_variable
var tileMatrix
#warning-ignore:unused_class_variable
var tileMatrixSize = 32
#warning-ignore:unused_class_variable
var cursorCoords
#warning-ignore:unused_class_variable
var population = 0
#warning-ignore:unused_class_variable
var entry;
#warning-ignore:unused_class_variable
var buildManager
#warning-ignore:unused_class_variable
var cityManager
#warning-ignore:unused_class_variable
var camera
#warning-ignore:unused_class_variable
var gui
#warning-ignore:unused_class_variable
var game
#warning-ignore:unused_class_variable
var roadHasChanged = false
#warning-ignore:unused_class_variable
var taxRate = 0.01