document.addEventListener('DOMContentLoaded', function(){
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    if (inputValue >= 300 && inputValue <= 9999999) {
      let tax = Math.floor(inputValue * 0.1);
      let gain = inputValue - tax;

      addTaxPrice.innerHTML = tax;
      profit.innerHTML = gain;
    } else {
      addTaxPrice.innerHTML = '';
      profit.innerHTML = '';
    }
  });
});
