  const produtos = [
        { id: 1, nome: "Brigadeiro Gourmet", preco: 20, qtd: 1, img: "https://via.placeholder.com/60" },
        { id: 2, nome: "Caixa de Trufas", preco: 35, qtd: 2, img: "https://via.placeholder.com/60" },
        { id: 3, nome: "Bolo no Pote", preco: 15, qtd: 1, img: "https://via.placeholder.com/60" }
      ];

      let cupomAtivo = 0;

      const cartItemsDiv = document.getElementById("cart-items");
      const subtotalEl = document.getElementById("subtotal");
      const taxaEl = document.getElementById("taxa");
      const descontoEl = document.getElementById("desconto");
      const totalEl = document.getElementById("total");
      const cartCountEl = document.getElementById("cart-count");
      const cupomMsg = document.getElementById("cupom-msg");

      function renderCart() {
        cartItemsDiv.innerHTML = "";
        let subtotal = 0;
        let totalQtd = 0;

        produtos.forEach(produto => {
          subtotal += produto.preco * produto.qtd;
          totalQtd += produto.qtd;

          cartItemsDiv.innerHTML += `
            <div class="cart-item">
              <img src="${produto.img}" alt="${produto.nome}">
              <div class="info">
                <h6>${produto.nome}</h6>
                <p>R$ ${produto.preco},00</p>
              </div>
              <div>
                <button class="btn btn-sm btn-outline-secondary" onclick="alterarQtd(${produto.id}, -1)">-</button>
                <span class="mx-2">${produto.qtd}</span>
                <button class="btn btn-sm btn-outline-secondary" onclick="alterarQtd(${produto.id}, 1)">+</button>
              </div>
              <button class="btn btn-sm btn-danger ms-3" onclick="removerProduto(${produto.id})"><i class="fas fa-trash"></i></button>
            </div>
          `;
        });

        // Taxa de entrega (grátis acima de 50)
        let taxa = subtotal >= 50 ? 0 : 5;

        // Cupom aplicado
        let desconto = (subtotal * cupomAtivo) / 100;

        subtotalEl.textContent = `Subtotal: R$ ${subtotal},00`;
        taxaEl.textContent = `Taxa de entrega: R$ ${taxa},00`;
        descontoEl.textContent = `Desconto: R$ ${desconto},00`;
        totalEl.textContent = `Total: R$ ${subtotal - desconto + taxa},00`;
        cartCountEl.textContent = totalQtd;
      }

      function alterarQtd(id, delta) {
        const produto = produtos.find(p => p.id === id);
        if (produto) {
          produto.qtd += delta;
          if (produto.qtd <= 0) removerProduto(id);
          renderCart();
        }
      }

      function removerProduto(id) {
        const index = produtos.findIndex(p => p.id === id);
        if (index !== -1) {
          produtos.splice(index, 1);
          renderCart();
        }
      }

      function aplicarCupom() {
        const cupomInput = document.getElementById("cupom").value.trim().toUpperCase();
        if (cupomInput === "DOCE10") {
          cupomAtivo = 10;
          cupomMsg.textContent = "Cupom aplicado: 10% de desconto!";
          cupomMsg.classList.remove("text-danger");
          cupomMsg.classList.add("text-success");
        } else {
          cupomAtivo = 0;
          cupomMsg.textContent = "Cupom inválido.";
          cupomMsg.classList.remove("text-success");
          cupomMsg.classList.add("text-danger");
        }
        renderCart();
      }

      // Inicializa
      renderCart();