---
layout: main
title: "Vamonos API Reference"
header: Vamonos API Reference
---


Vamonos.Widget.VarName
======================

[Back](index.html)

VarName shows the variable name and provides a buton to set the variable as a watchVar, and visual feedback for editable variables in editMode.


### Constructor Arguments

 * **container** :: *String* | *jQuery Selector* -- **required**

    The id or a jQuery selector of the div in which this widget should draw itself.



 * **varName** :: *String* -- **required**

    the name of variable that this widget represents



 * **displayName** :: *String* -- optional

    alternate varname to display - defaults to varName



 * **inputVar** :: *Boolean* -- default Value: `false`

    whether to accept input for this variable in edit mode



 * **watchable** :: *Boolean* -- default Value: `true`

    whether the variable can be set as a watchVar



 * **watching** :: *Boolean* -- default Value: `false`

    whether the variable starts off set as a watchVar


