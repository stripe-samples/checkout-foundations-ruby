document.addEventListener('DOMContentLoaded', async () => {
  let urlParams = new URLSearchParams(window.location.search);
  let sessionId = urlParams.get('session_id');

  if (sessionId) {
    const {customer, session, line_items} = await fetch(`order-info?session_id=${sessionId}`)
      .then((r) => r.json());

    setText("customer_name", customer.name);
    setText("customer_email", customer.email);
    setText("payment_status", `Payment Status: ${session.payment_status}`);

    let currencyFmt = Intl.NumberFormat("en-US", {
      style: "currency",
      currency: `${session.currency}`,
    });

    setText("order_total", `Order Total: ${currencyFmt.format(session.amount_total/100)}`);

    //add list items to display
    let lineItemsText = "";
    for (const line_item of line_items.data) {
      lineItemsText += `<div class="line_item">
        ${line_item.description}(${line_item.quantity}):
        ${currencyFmt.format(line_item.amount_total/100)}</div>`;
    };
    setText("line_items", lineItemsText);
  }
});

const setText = (elementId, text) => {
  const element = document.querySelector(`#${elementId}`);
  element.innerHTML = text;
}