paypal.Buttons({
   style:{
      color: 'blue',
      shape: 'pill'
   },
   createOrder:function(data, actions){
      var items = JSON.parse(localStorage.getItem('cartItems'))
      let paypalItem = [];
      for (let i = 0 ; i < items.length; i++) {
         let currency = "USD";
         let quantity = items[i].quantity;
         let name = items[i].type + " " + items[i].size + " " + items[i].color + " " + items[i].logoDesign + " ";
         let amount = items[i].price;
        //let pushItem = {"quantity": quantity};  
         paypalItem.push({"name": name, "unit_amount": {"currency_code": currency,"value": amount},"quantity": quantity});
      }

      console.log("StackOverFow", paypalItem )
      return actions.order.create(
         {
            purchase_units: [{
               amount:{
                  currency_code: "USD",
                  value: localStorage.getItem('total'),
                  breakdown: {
                     item_total: {
                        currency_code: "USD",
                        value: localStorage.getItem('total')
                     }
                  }
               },
               items: paypalItem
            }]
         }
      );
   },
   onApprove: function(data, actions){
      return actions.order.capture().then(function(details){
         window.location.replace('http://127.0.0.1:5500/success.html')
         
      })
   },
   onCancel: function(data){
      window.location.replace('http://127.0.0.1:5500/cancel.html')
   }
}).render('#paypal-payment-button');
