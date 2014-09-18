package main

import (
	"fmt"
	"net/http"
	"encoding/json"
	"webhooks/publishers/shopify"
	"webhooks/consumer"	
)

func index(w http.ResponseWriter, req *http.Request){
	fmt.Fprintf(w, "Hello World!!")
}

func webhookHandle(w http.ResponseWriter, req *http.Request){
	var msg shopify.OrderCreation
	decoder := json.NewDecoder(req.Body)
	err := decoder.Decode(&msg)
    if err != nil{
        panic("Ruh Roh")
    }    
    var textMsg string
    textMsg = fmt.Sprintf(`New order for %d items worth $%s\n`, len(msg.Line_items), msg.Subtotal_price)    
    for i := range msg.Line_items{
    	line_item := msg.Line_items[i]
    	textMsg += fmt.Sprintf(`%d %s \n`, line_item.Quantity, line_item.Name)    	
    }
    go slack.Publish(textMsg)
}

func main() {
	http.HandleFunc("/", index)
	http.HandleFunc("/webhook", webhookHandle)
	addr := ":8080"
	fmt.Printf("Listening on %s\n", addr)
	http.ListenAndServe(addr, nil)	
}