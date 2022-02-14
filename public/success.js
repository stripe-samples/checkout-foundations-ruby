document.addEventListener('DOMContentLoaded', async () => {
  let urlParams = new URLSearchParams(window.location.search);
  let sessionId = urlParams.get('session_id');

  if (sessionId) {
    const {customer, session} = await fetch(`order-info?session_id=${sessionId}`)
      .then((r) => r.json());

    setText("customer_name", customer.name);
    setText("customer_email", customer.email);
    setText("payment_status", session.payment_status);

    let currencyFmt = Intl.NumberFormat("en-US", {
      style: "currency",
      currency: `${session.currency}`,
    });

    setText("order_total", `${currencyFmt.format(session.amount_total/100)}`);
  }
});

const setText = (elementId, text) => {
  const element = document.querySelector(`#${elementId}`);
  element.innerHTML = text;
}