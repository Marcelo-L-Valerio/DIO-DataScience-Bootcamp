# 4 Projeto do Bootcamp

## Bootcamp Data Science Unimed-BH/DIO

### O objetivo desse projeto é modelar um banco de dados para uma aplicação e-commerce, considerando alguns aspectos listados a seguir, a partir de algumas regras de negócio, criar o diagrama do BD, e enviá-lo em png

## Entidades

### As entidades que devem ser obrigatóriamente no negócio são: CLiente, Pedido, Produto, Estoque, Fornecedor, Vendedor terceiro

### Algumas entidades que foram necessárias de serem criadas ao decorrer do projeto: Usuário (generaliza cliente e vendedor), carteira (com cartões e conta bancária para reembolso) e entrega (acompanhamento do pedido)

## Justificativas

### Pelas peculiaridades do projeto, tomei a liberdade de tomar algumas decisões, como criar entidade conta bancária para vendas de terceiros e reembolsos quando o pagamento não for em cartão de crédito, datas de pagamento, postagem e chegada do pedido, generalização de cliente e vendedor, e, para identificar se o usuário é pessoa física ou jurídica, foi adicionado o atributo tipo (CHARFIELD(2)), para, na aplicação ser tratado, para, a partir do campo tipo (PF ou PJ), exigir apenas o CPF ou CNPJ, além de atributos específicos, como método de pagamento.