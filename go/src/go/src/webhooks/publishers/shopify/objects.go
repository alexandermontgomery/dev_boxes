package shopify

type LineItem struct {
	Name string
	Quantity int
}

type OrderCreation struct {
    Subtotal_price string
    Order_number int
    Line_items []LineItem
}