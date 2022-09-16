function cartItem(imgSrc, color, size, logoDesign, price, type) {
   this.imgSrc = imgSrc,
   this.color = color;
   this.size = size;
   this.logoDesign = logoDesign;
   this.price = price
   this.type = type
   this.quantity = 1
}
function appendCartItem(cartItem)
{
   const jsonObj = JSON.stringify(cartItem)
   if(!localStorage.getItem('cartItems'))
   {
      cartItems = JSON.parse(localStorage.getItem('cartItems') || "[]")
      cartItems.push(cartItem)
      localStorage.setItem('cartItems', cartItems)
   }
}
function checkValues(imgSrc, theType)
{
   const colorGetter = document.getElementById('color') 
   const color = colorGetter.options[colorGetter.selectedIndex].text 
   const sizeGetter = document.getElementById('size')
   const size = sizeGetter.options[sizeGetter.selectedIndex].text
   const logoDesignGetter = document.getElementById('logodesign') 
   const logoDesign = logoDesignGetter.options[logoDesignGetter.selectedIndex].text
   const cartButton = document.getElementsByClassName("cart-button")[0]
   const selectParagraph = document.getElementsByClassName('select-another')[0]
   const cartImage = document.getElementsByClassName('cart')[0]
   if (color != "" && size != "" && logoDesign != "")
   {
      cartButton.setAttribute('style', 'animation: bounce 1s')
      createCartItem(imgSrc, theType)
      selectParagraph.setAttribute('style', 'display: none;')
      cartImage.setAttribute('style', 'animation: bounce 1s')
   }
   else
   {
      
      cartButton.setAttribute('style', "animation: shake 1s; background-color: red;")
      
      selectParagraph.textContent = "Please select your variant"
      selectParagraph.setAttribute('style', "color: red")
   }
}
function setShirtPrice()
{
   let logoDesignGetter = document.getElementById('logodesign')
   let logoDesign = logoDesignGetter.options[logoDesignGetter.selectedIndex].text 
   let priceTag = document.getElementById('priceTag')
   if (logoDesign == "Full Color Print")
   {
      priceTag.textContent = "$24.99"
   }
   else
   {
      priceTag.textContent = "$19.99"
   }
}
function setHoodiePrice()
{
   let logoDesignGetter = document.getElementById('logodesign')
   let logoDesign = logoDesignGetter.options[logoDesignGetter.selectedIndex].textContent
   let priceTag = document.getElementById('priceTag')
   if (logoDesign == "Full Color Print")
   {
      priceTag.textContent = "$39.99"
   }
   else
   {
      priceTag.textContent = "$34.99"
   }
}
function checkJoggersValue(imgSrc, price, theType)
{
   const sizeGetter = document.getElementById('size') 
   const size = sizeGetter.options[sizeGetter.selectedIndex].text
   const cartButton = document.getElementsByClassName("cart-button")[0]
   const selectParagraph = document.getElementsByClassName('select-another')[0]
   const cartImage = document.getElementsByClassName('cart')[0]
   if(size != "")
   {
      cartButton.setAttribute('style', 'animation: bounce 1s')
      createJoggerCartItem(imgSrc, price, theType)
      selectParagraph.setAttribute('style', 'display: none;')
      cartImage.setAttribute('style', 'animation: bounce 1s')
   }
   else
   {
      
      cartButton.setAttribute('style', "animation: shake 1s; background-color: red;")
      
      selectParagraph.textContent = "Please select your variant"
      selectParagraph.setAttribute('style', "color: red")
   }
}
function checkSnapbackValue(imgSrc, price, theType)
{
   const colorGetter = document.getElementById('color') 
   const color = colorGetter.options[colorGetter.selectedIndex].text
   const cartButton = document.getElementsByClassName("cart-button")[0]
   const selectParagraph = document.getElementsByClassName('select-another')[0]
   const cartImage = document.getElementsByClassName('cart')[0]
   if(color != "")
   {
      cartButton.setAttribute('style', 'animation: bounce 1s')
      createSnapbackCartItem(imgSrc, price, theType)
      selectParagraph.setAttribute('style', 'display: none;')
      cartImage.setAttribute('style', 'animation: bounce 1s')
   }
   else
   {
      
      cartButton.setAttribute('style', "animation: shake 1s; background-color: red;")
      
      selectParagraph.textContent = "Please select your variant"
      selectParagraph.setAttribute('style', "color: red")
   }
}
function createCartItem(imgSrc, theType)
{
   const colorGetter = document.getElementById('color') 
   const color = colorGetter.options[colorGetter.selectedIndex].text 
   const sizeGetter = document.getElementById('size')
   const size = sizeGetter.options[sizeGetter.selectedIndex].text
   const logoDesignGetter = document.getElementById('logodesign') 
   const logoDesign = logoDesignGetter.options[logoDesignGetter.selectedIndex].textContent
   const price = document.getElementById('priceTag').textContent.substring(1)
   const myCartItem = new cartItem(imgSrc, color, size, logoDesign, price, theType);
   
   cartItems = JSON.parse(localStorage.getItem('cartItems') || "[]")
   cartItems.push(myCartItem)
   const json = JSON.stringify(cartItems)
   localStorage.setItem('cartItems', json)

   let numCart = localStorage.getItem('numCart') || "0"
   numCart = parseFloat(numCart) + 1
   let numItems = document.getElementsByClassName('centered')[0]
   numItems.textContent = numCart
   numItems.setAttribute('style', 'animation: bounce 1s')
   localStorage.setItem('numCart', numCart)
}
function createJoggerCartItem(imgSrc, price, theType)
{
   const sizeGetter = document.getElementById('size')
   const size = sizeGetter.options[sizeGetter.selectedIndex].text
   const myCartItem = new cartItem(imgSrc, "Black", size, "FullColorPrint", price, theType);
   
   cartItems = JSON.parse(localStorage.getItem('cartItems') || "[]")
   cartItems.push(myCartItem)
   const json = JSON.stringify(cartItems)
   localStorage.setItem('cartItems', json)

   let numCart = localStorage.getItem('numCart') || "0"
   numCart = parseFloat(numCart) + 1
   let numItems = document.getElementsByClassName('centered')[0]
   numItems.textContent = numCart
   numItems.setAttribute('style', 'animation: bounce 1s')
   localStorage.setItem('numCart', numCart)
}
function createSnapbackCartItem(imgSrc, price, theType)
{
   const colorGetter = document.getElementById('color')
   const color = colorGetter.options[colorGetter.selectedIndex.text]
   if(color === 'purple')
   {
      const myCartItem = new cartItem(imgSrc, color, "Fit", "Purple", price, theType);
      cartItems = JSON.parse(localStorage.getItem('cartItems') || "[]")
      cartItems.push(myCartItem)
      const json = JSON.stringify(cartItems)
      localStorage.setItem('cartItems', json)

   }
   else{
      const myCartItem = new cartItem(imgSrc, color, "Fit", "FullColorPrint", price, theType);
      cartItems = JSON.parse(localStorage.getItem('cartItems') || "[]")
      cartItems.push(myCartItem)
      const json = JSON.stringify(cartItems)
      localStorage.setItem('cartItems', json)
   }

   let numCart = localStorage.getItem('numCart') || "0"
   numCart = parseFloat(numCart) + 1
   let numItems = document.getElementsByClassName('centered')[0]
   numItems.textContent = numCart
   numItems.setAttribute('style', 'animation: bounce 1s')
   localStorage.setItem('numCart', numCart)
}
function createBuckethatCartItem(imgSrc, price, theType)
{
   const cartImage = document.getElementsByClassName('cart')[0]
   
   cartImage.setAttribute('style', 'animation: bounce 1s')
   const myCartItem = new cartItem(imgSrc, "Pink", "Fit", "Pink", price, theType);
   
   cartItems = JSON.parse(localStorage.getItem('cartItems') || "[]")
   cartItems.push(myCartItem)
   const json = JSON.stringify(cartItems)
   localStorage.setItem('cartItems', json)
   
   let numCart = localStorage.getItem('numCart') || "0"
   numCart = parseFloat(numCart) + 1
   let numItems = document.getElementsByClassName('centered')[0]
   numItems.textContent = numCart
   numItems.setAttribute('style', 'animation: bounce 1s')
   localStorage.setItem('numCart', numCart)
}
