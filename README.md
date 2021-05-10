# esx_wirtschaftwatcher
 This project monitors their FiveM economy and evaluates it graphically from all users.
![image](https://user-images.githubusercontent.com/34350217/113492823-c0998500-94da-11eb-8d3f-b343ef676983.png)
1. Import tabeles.sql
2. add esx_wirtschaftwatcher to your sever and add it to cfg
3. add index.php to an webserver to monitor your Economy.

If you want to get a better and detailed insight into your economy.
You should use [Ghidra](https://ghidra-sre.org/).
Here you can import the following tables to show them graphically.

* wirtschaft_item_sells -> this shows you if an user sell items and get money 

* wirtschaft -> this show you the hole server economy

* wirtschaft_users -> this show you the economy changes each user.

## IMPORTANT
The script saves the data every day at 04:00 at night. 
If you want it to save earlier you have to enable manual saving in the config, then it saves at every start.

## How to add resources to the item sells like esx_drugs?
after you give the player the money in the server.lua
you add this.

TriggerEvent('wirtschaft:logItemSell', xPlayer, xItem.name, xItem.count, price)
## Donate:

If you want to donate money, you support me a lot, it helps me to buy paid development environments or just to have a coffee or a beer. Also it is a great confirmation for me to see that you like my projects so much!

[Paypal](https://www.paypal.com/pools/c/8qO8Xpf81J)
