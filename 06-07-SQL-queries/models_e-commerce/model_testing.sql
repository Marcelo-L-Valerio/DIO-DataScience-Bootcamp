INSERT into Users (complete_name, is_pf, cpf, cellphone, email)
	values ('Marcelo Valerio', True, '17471958049', '188010531', 'email 4'),
			('Jonas Lopes', True, '31242243020', '765129158', 'email 1'),
            ('Maria Cristina', True, '28950852004', '476342532', 'email 9'),
            ('Carla Aparecida', True, '35254170042', '766385771', 'email 3'),
            ('Joao Junior', True, '63854689098', '665238390', 'email 7'),
            ('Milton dos Santos', True, '84036002082', '176083025', 'email 2');

INSERT into Users (complete_name, is_pf, cnpj, cellphone, email)
	values ('Eliane e Raimunda Roupas Ltda', False, '40318840000111', '188010531', 'email 14'),
			('Edson e Giovana Adega ME', False, '57439565000197', '765129158', 'email 11'),
            ('Ricardo e Henry Automóveis Ltda', False, '11056091000101', '476342532', 'email 19'),
            ('Danilo e Valentina Eletrônica Ltda', False, '94968773000100', '766385771', 'email 13'),
            ('Julio e Tomás Construções Ltda', False, '81505307000146', '665238390', 'email 17'),
            ('Ryan e Clara Informática Ltda', False, '24293316000187', '176083025', 'email 12');

INSERT into Products (category, prod_description, price, avaliation)
	values('Vestuario', 'Camiseta', 50.0, 4.0),
    ('Eletronicos', 'PC', 2000, 5.0),
    ('Bebidas', 'Vinho', 30, 3),
    ('Carro', 'HB20', 30000, 3.5),
    ('Construção', 'Cimento', 25, 5),
    ('Eletronicos', 'PS5', 3000, 4.5);
    
INSERT into Providers (social_reazon, cnpj)
	values ('Vende quase tudo ltda', '12345678910123'),
    ('Vende o resto ltda', '12345678910111'),
    ('Ryan e Clara Informática Ltda', '24293316000187');
    
INSERT into Provides (idProduct, idProvider)
	values (1, 1), (2, 1), (3, 2), (4, 1), (5, 2), (6, 2), (2, 3);

-- Tabela de fornecedores e produtos
select social_reazon, prod_description from Provides natural join Providers natural join Products;

INSERT into Inventory (address) values('AV do porto, Santos, SP'), ('AV perto do aeroporto, São Paulo, SP'), 
	('AV perto do porto, Rio de Janeiro, RJ');

INSERT into Stocked_at (idProduct, idInventory, quantity)
	values(1, 1, 50), (1, 2, 30), (2, 2, 10), (3, 1, 2), (4, 3, 5), (5, 2, 10), (6, 3, 9), (4, 2, 10);
    
-- Valor total em cada estoque, por produtos, ordenado de forma decrescente
Select prod_description, address, (quantity*price) as valor_em_estoque from stocked_at 
	natural join Inventory natural join Products order by valor_em_estoque DESC;

-- Endereço, produtos, e quantidades nos estoques
select address, prod_description, quantity from Stocked_at natural join Inventory natural join Products;

-- retorna os mesmos dados, mas so os com estoque menor que 10, que precisam ser repostos
select address, prod_description, quantity from Stocked_at natural join Inventory
	natural join Products having quantity < 10;

insert into sellers (idUser) values (7), (8), (9), (10), (11), (12);
insert into seller_offers (idSeller, idProduct, quantity)
	values (1, 1, 30), (2, 3, 10), (3, 4, 3), (4, 6, 2), (5, 5, 50), (6, 6, 9), (6, 2, 10);
    
-- retorna os vendedores autonomos, os produtos que vendem e as quantidades
select prod_description, quantity, complete_name from seller_offers natural join Products natural join
	(Sellers natural join Users);
    
insert into Orders (payment_stt, shipping, payment_method, idUser, order_date)
	values ('Aguardando', 0, 'Pix', 1, '2022-01-01'), ('Aprovado', 25, 'Cartão', 1, '2022-03-01'),
    ('Cancelado', 150, 'Boleto', 2, '2022-03-03'), ('Aprovado', 10, 'Boleto', 3, '2022-01-01'),
    ('Aguardando', 10, 'Pix', 4, '2022-02-01'), ('Aprovado', 0, 'Cartão', 5, '2022-01-03'),
    ('Cancelado', 10, 'Cartão', 6, '2022-01-01'), ('Aprovado', 50, 'Boleto', 6, '2022-01-01');
    
-- Pedidos realizados entre 1 de janeiro de 2021, e 1 de janeiro de 2022
select * from Orders where order_date between '2021-01-01'and '2022-01-01';

-- Pedidos que tiveram frete grátis
select * from Orders where shipping = 0;

-- Quantos pedidos o usuário chamado Marcelo Valerio fez
select count(*) from Orders natural join Users where complete_name = 'Marcelo Valerio';

-- Mesmo de cima, porém somente os aprovados
select count(*) as 'quantidade de pedidos' from Orders natural join Users 
	where complete_name = 'Marcelo Valerio' and payment_stt = 'Aprovado';

INSERT into Products_in_order (idOrder, idProduct, quantity)
	values(1, 1, 1), (1, 2, 3), (2, 6, 1), (3, 5, 3), (3, 6, 5), (3, 1, 2), (4, 2, 1), (5, 3, 1), (6, 4, 8);
    
-- Valor total de cada pedido, em ordem decrescente
SELECT idOrder, complete_name, sum(p.quantity*price) as total_order_value from Products_in_order p natural join
	Products natural join (Orders natural join Users) group by idOrder order by total_order_value DESC;

INSERT into Wallets (idUser)
	values (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12);
    
INSERT into Credit_cards (idWallet, credit_card_number, due_date, name_in_credit_card, owner_cpf)
	values(1, 123213124, '2032-01-01', 'NOME 1', '14123123123'),
    (2, 5341412412, '2032-02-01', 'NOME 2', '12412313124'),
    (2, 4351412412, '2032-02-01', 'NOME 8', '12412313142'),
    (3, 2142135223, '2035-01-01', 'NOME 3', '12412123125'),
    (4, 51312123124, '2022-09-01', 'NOME 9', '12412312129'),
    (5, 51231231212, '2034-01-01', 'NOME 4', '12123123127'),
    (6, 5213123123, '2032-06-01', 'NOME 5', '12423123128'),
    (6, 56765446321, '2032-08-01', 'NOME 6', '12412312311');
    
-- Quantos cartões cada um tem cadastrado
SELECT complete_name, count(cc.idWallet) from Credit_cards as cc natural join (users u natural join Wallets w) where 
	w.idWallet = cc.idWallet group by idUser;
    
INSERT into Address (idUser, cep, state, city, district, public_place, complement)
	values (1, '32412334', 'SP', 'São Paulo', 'sla', 'Rua 1', null),
    (2, '32441234', 'RJ', 'Rio de Janeiro', 'Bairro aleatorio', 'Rua 5', 'apto 103'),
    (3, '13125211', 'MT', 'Cidade x', 'Bairro bonito', 'AV principal, n 150', null),
    (4, '51231231', 'RN', 'Natal', 'Bairro feio', 'Rua 12', 'em frente a farmacia'),
    (5, '32441232', 'RJ', 'Rio de Janeiro', 'Bairro aleatorio2', 'Rua 52', 'apto 1032');
    
-- endereços no RJ
select * from Address where state = 'RJ';

-- Left join que retorna os usuários que não cadastraram um endereço ainda
-- Obs: Na idealização do projeto, PJ, também pode comprar coisas, apenas não apliquei para simplificar
select u.idUser, complete_name from Users u left join Address a on u.idUser = a.idUser where a.idUser is null
	and is_pf = True;
    
INSERT into Delivery (idOrder, delivery_status, tracking_code, post_date, delivery_date)
	values(1, 'A caminho', '123421123', '2022-03-03', null),
    (2, 'Efetivada', '123421124', '2022-03-03', '2022-04-03'),
    (5, 'Posto de dist', '123421125', '2022-04-03', null),
    (6, 'Efetivada', '123421132', '2022-06-15', '2022-08-03'),
    (7, 'A caminho', '123421126', '2022-05-03', null),
    (8, 'Efetivada', '123421127', '2022-09-15', '2022-10-30');
    
-- Comparação do tempo de espera das entregas ja realizadas, da postagem até a porta do cliente
SELECT idOrder, DATEDIFF(delivery_date, post_date) as shipping_time from Delivery natural join Orders
	where delivery_status = 'Efetivada' order by shipping_time;