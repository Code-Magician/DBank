import { dbank } from "../../declarations/dbank";

async function updateAmount() {
  const currAmount = await dbank.checkBalance();

  document.getElementById("value").innerText = currAmount.toFixed(2);
}

window.addEventListener("load", updateAmount);

document.querySelector("form").addEventListener("submit", async (e) => {
  e.preventDefault();

  const submitBtn = document.getElementById("submit-btn");
  submitBtn.setAttribute("disabled", true);

  const topUpEle = document.getElementById("input-amount");
  const withdrawalEle = document.getElementById("withdrawal-amount");

  const topUpAmount = parseFloat(topUpEle.value);
  const withdrawlAmount = parseFloat(withdrawalEle.value);

  topUpEle.value = "";
  withdrawalEle.value = "";

  if (topUpAmount)
    await dbank.topUp(topUpAmount);

  if (withdrawlAmount)
    await dbank.withdraw(withdrawlAmount);

  await dbank.compound();
  await updateAmount();

  submitBtn.removeAttribute("disabled");
})