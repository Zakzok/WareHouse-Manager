THE MODEL----------------------------------------------------------
We have some distributer warehouses and one or more 'master' warehouses.
The master warehouse must be stocked up of all items initially, and
our goal is stock up certain warehouses with certain items. This 
simulates a single run of stocking up items around our distributor
warehouses.

Please note that you will need to run this using prppp.

Here are the bullet points of our current model:

-Our network of warehouses is connected by roads.

-We have vehicles that are able to move along the roads between
warehouses.

-Vehicles can be loaded and unloaded with any specific one item.

-Each action (drive(3),(loader(1),unloader(1)) has a specified
cost associated with it.

-Ours goal is to achieve the goal state of stocking up items in specific
warehouses while minimizing the total cost.

-Note that once a warehouse has stock of an item, it has infinitely
much of it. This is infact intended as we want the planner to move
item stock between distributors. Once we are able to implement 
'numerical' values for specific stocks, we will be splitting the items
when they are being transpored.

TESTING-------------------------------------------------------------

-You must create a network of warehouses connected by roads. Roads
are recommended to be two-way.

-You must create a set of vehicles, and must initialize each vehicle
correctly by placing it in a specific warehouse and specifying whether
it is loaded or if it is empty.

-You must specify in the goal state which distributer warehouses must
have stock of a specific item
