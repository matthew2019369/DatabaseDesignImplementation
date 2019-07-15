# DatabaseDesignImplementation
Database Design and Implementation

#Case	Background
Spock	Bank	whose	motto	is	“Live	long	and	prosper” has	been	helping customers	with	loans over	
the	last	40	years.	They	started	storing	data	in	a	file-based	system	and	then transitioned	into	using	
spreadsheets.	As	years	progressed,	the	number	of	customers	has	grown	exponentially	leading to	
an	 increase	 in	 number	 of	 branches	 and volume	 of	 data. Spock	 Bank	 finds it	 quite	 difficult	 to	
manipulate	and	share	the data	across	branches.	Although	Spock	bank	originally	started	as	a	loanonly	 bank,	 they	 now	 operate	 ATM	 machines	 and	 provide	 customer	 with	 debit	 cards	 for	 cash	
withdrawals.	
You	have	been provided	with	the	following	business	rules about	Spock	Bank
• Every	 branch	 of	 Spock	 Bank is	 provided	 with	 a	 unique	 identifier.	 Details	 of	 a	 branch	
include:	name,	address,	and	phone	number.
• Each	customer is provided	with	a	unique	identifier.	Details	of	a	customer	include: name,
address, contact	number,	email	address,	and	join	date.	
• An	 account	 can	 be	 one	 of	 many	 different	 types.	 Each	 type	 of	 account	 has	 a	 unique	
identifier.	Each	account	 type	needs	 to	include:	name,	a	description,	interest	 rate	and	a	
yearly	service	fee.	
• An	 account	 is	 identified	 by	 a	 combination	 of	 BSB	 and	 an	 account	 number. Details	 of	
account	such	as	type	of	the	account	and current	balance	are	stored.
• Every	 customer	 with	 an	 account	 may	 be	 provided	 with	 more	 than	 one debit	 card	 to	
withdraw	cash.	Each	debit	card	has	its	own	card	number.	Details	of	a	debit	card include:	
expiry	date,	CVV	number,	and	PIN	number.	
• Every	ATM	machine	of	Spock	Bank	is	provided	with	a	unique	identifier.	Details	of	an	ATM	
include:	location,	opening	hours,	and	maximum	cash	capacity.
• Every	employee	of	Spock	Bank	is	provided	with	a	unique	identifier.	This identifier	is	used	
across	the	all	of	the	branches.	Details	of	an	employee	would	include:	name,	address,	phone	
number,	position	and	annual	salary.	
• Every	 department	 of	 Spock	 Bank	 is	 provided	 with	 a	 unique	 identifier.	 Details	 of	 a	
department	would	include:	name,	office	location, and	a	contact	number.
• A	loan	can	be	one	of	many	different	types.	Each	type	of	loan	has	a	unique	identifier.	Each	
loan	type	needs	to	include:	name	and	description
• A	loan is	identified	by	a	unique number.	Details	of	loan such	as	interest	rate,	total	loan	
amount, and	outstanding balance	are	stored.
• Every	 cash	 withdrawal	 is	 identified	 by	 a	 withdrawal	 number.	 Other	 details	 of	 the	
withdrawal	 would	 include:	 ATM	 number – where	 the	 withdrawal	 happened,	the	 card	
number, date	and	time	of	withdrawal, and	the	withdrawal	amount.	
• Every	 loan	 repayment	 is	 identified	 by	 a	 repayment	 number.	 Other	 details	 of	 the	
repayment	would	include:	the	loan	number – what	the	repayment	is	for,	the	repayment	
amount,	date	and	time	of	repayment,	and	the	employee	who	monitors	the	loan	payment.
ISYS224/ITEC624 2018 - Assignment	1
4
• A	branch	many	have	multiple	ATMs.	An	ATM	may	be	associated	with	a	bank (branch)
• An	account	type	may	have	multiple	accounts.	An	account	will	be	of	a	particular	type	only.
• A	 customer	 may	 have	 multiple	 accounts.	 An	 account	 could	 be	 shared	 by	 multiple	
customers	(joint	account).
• Every	customer	of	an	account	could	choose	to	get	a	debit	card.	A	debit	card	belongs	to	a	
customer
• An	ATM	can	have	multiple	withdrawals.	A	withdrawal	is	registered	at	a	particular	ATM.
• A	debit	card	can	have	multiple	withdrawals.	A	withdrawal	is	registered	for	a	particular	
ATM (debit	card)
• A	loan	type	may	have	multiple	loans.	A	loan	will	be	of	a	particular	type	only.
• Every loan	is	associated	with	an	account.	An account	may	not	be	linked	with	a	loan.
• A	repayment	is	done	for	a	particular	loan.	A	loan may	have	multiple	repayments.
• Every repayment	 is	 overlooked	 by	 an	 employee.	 An	 employee	 may	 monitor	 multiple	
repayments.	Repayment	is	not	connected	to	an	account.	
• An	employee	works for	a	department	at	a	particular	branch.	A	branch	will	have	multiple	
employees	in	different	departments.	
• A	 manager,	 who	 is	 an	 employee	 manages	 a	 department	 at	 a	 particular	 branch.	 Each	
department	in	every	branch	has	one	manager	only.	Also,	start	date	and	end	date	is	stored	
for	every	manager’s	employment	history.

# Data model
The model created is based on the business rules and it is included inside isys224
