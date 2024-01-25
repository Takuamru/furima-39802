const pay = () => {
  const publicKey = 'pk_test_c207b00da96ac02ebb676754';
  const payjp = Payjp(publicKey);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    // トークンを生成し、フォームに追加
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラーハンドリング
        console.log(response.error.message);
      } else {
        // トークンを取得し、フォームに追加
        const token = response.id;
        const tokenObj = `<input value="${token}" name='purchase_form[token]' type="hidden">`;
        form.insertAdjacentHTML("beforeend", tokenObj);

        // クレジットカードの情報をクリア
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();

        // フォームを送信
        form.submit();
      }
    });
  });
};

window.addEventListener("turbo:load", pay);

