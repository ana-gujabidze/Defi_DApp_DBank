import { dbank } from "../../declarations/dbank";

window.addEventListener("load", async function() {
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault();

  const button = event.target.querySelector("#submit-btn");

  const inputValue = document.getElementById("input-amount").value;
  const withdrawValue = document.getElementById("withdrawal-amount").value;

  button.setAttribute("disabled", true);

  if (inputValue) {
    await dbank.topUp(parseFloat(inputValue));
  }

  if (withdrawValue) {
    await dbank.withdraw(parseFloat(withdrawValue));
  }
  
  await dbank.compound();

  update();

  document.getElementById("input-amount").value = "";
  document.getElementById("withdrawal-amount").value = "";

  button.removeAttribute("disabled");
});

async function update() {
  const currentValue = await dbank.checkValue();
  document.getElementById("value").innerText = Math.round(currentValue * 100) / 100;
}