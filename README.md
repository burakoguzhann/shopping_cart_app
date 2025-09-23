# shopping_cart app

Bir e-commerce temeli barındıran app. API'den gelen ürünler anasayfada listeleniyor. Sepete ekleme fonksiyonu ile eklendiğinde adet artırma / azaltma ile fiyat güncellemesi oluyor. Ayrıyeten SQLite ile ürün eklenebilir. Ürün ekle butonuna basıldığında Başlık ve Ücret girildiğinde sayfanın alt tarafında da SQLite'dan gelen ürünler listeleniyor. 

# Kullanılan teknolojiler: 
SQLite ile Auth system kuruldu.
SQLite ile bir veri ekleme / listeleme sistemi kuruldu. 
State management Provider ile yapıldı. 
FakeAPI'ye http.post isteği atarak API'deki ürünler listelendi. 
Sharedpref. ile sepete eklenen ürünlerin sepette kalması sağlandı. 


# shopping_cart app

An app with an e-commerce foundation. Products from the API are listed on the home page. When added with the add to cart function, the quantity can be increased/decreased and the price updated. Additionally, products can be added with SQLite. When the add product button is pressed, the title and price are entered, and the products from SQLite are listed at the bottom of the page. 

# Technologies used: 
An Auth system was set up with SQLite.
A data addition/listing system was set up with SQLite. 
It was done with State management Provider. 
Products from the API were listed by sending an http.post request to FakeAPI. 
Sharedpref. was used to ensure that products added to the cart remained in the cart. 

