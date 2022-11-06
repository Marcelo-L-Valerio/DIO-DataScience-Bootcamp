# 4 Projeto do Bootcamp

## Bootcamp Data Science Unimed-BH/DIO

### Neste projeto, foram realizadas duas entregas separadas, ambas envolvendo modelagem de um banco de dados para aplicações diferentes: a primeira atividade foi completar o modelo desenvolvido em aula de um banco de dados de um e-commerce, e o segundo foi desenvolver do zero um banco de dados de uma oficina automotiva, seguindo algumas regras de negócio citadas em aula. Cada projeto possui seu arquivo .png para abrir apenas a imagem da modelagem, e um arquivo .mwb, para abrir o mesmo no workbench

## Primeiro modelo - e-commerce

### O objetivo desse projeto é modelar um banco de dados para uma aplicação e-commerce, considerando alguns aspectos listados a seguir, a partir de algumas regras de negócio, criar o diagrama do BD, e enviá-lo em png.

## Entidades

### As entidades que devem ser obrigatóriamente no negócio são: CLiente, Pedido, Produto, Estoque, Fornecedor, Vendedor terceiro.

### Algumas entidades que foram necessárias de serem criadas ao decorrer do projeto: Usuário (generaliza cliente e vendedor), carteira (com cartões e conta bancária para reembolso) e entrega (acompanhamento do pedido).

## Justificativas

### Pelas peculiaridades do projeto, tomei a liberdade de tomar algumas decisões, como criar entidade conta bancária para vendas de terceiros e reembolsos quando o pagamento não for em cartão de crédito, datas de pagamento, postagem e chegada do pedido, generalização de cliente e vendedor, e, para identificar se o usuário é pessoa física ou jurídica, foi adicionado o atributo tipo (CHARFIELD(2)), para, na aplicação ser tratado, para, a partir do campo tipo (PF ou PJ), exigir apenas o CPF ou CNPJ, além de atributos específicos, como método de pagamento.

## Segundo modelo - oficina mecânica

### Neste projeto, foi proposto desenvolver do zero um banco de dados para uma oficina mecânica com algumas particularidades, citadas abaixo.

## Entidades

### As entidades, propostas pela monitora foram: ordem de serviço, serviço, peça e mecânico. Por escolha pessaol, resolvi adicionar mais algumas regras: cada cliente pode ter um ou mais carro, mas nenhum carro pode não ter um cliente associado; a ordem de serviço tem os atributos obrigatórios, como data de entrega, código, e outros, e por meio de entidades de relacionamento é possível buscar pelos mecânicos associados a ela, assim como as peças, quantidades, e os serviços executados.

## Justificativas

### Algumas justificativas que achei não triviais e importantes de citar: o serviço de revisão, citado na confecção do projeto, pode ser salvo apenas como um dado na entidade "serviço", sendo assim, não criei uma nova entidade apenas para ela; outra escolha que acho que vale citar foi a de associar a peça a um serviço, ou diretamente à ordem, por fim escolhi a última, pelo fato de as peças serem diferentes para cada carro, logo, o valor varia, e seria necessário criar vários serviços como "troca do filtro de oleo - Volkswagen", e outro pra Ford, perpetuando dados não tão úteis, que podem ser acessados igualmente por meio de um select. Para obter o valor total da ordem, deve-se procurar na tabela de serviço pelos valores da mão de obra, e na de peças para os valores, e na de relação entre ordem e peça para ver a quantidade utilizada.