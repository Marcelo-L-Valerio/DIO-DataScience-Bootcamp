INSERT into Clients (full_name, is_pf, cpf, address, cellphone)
	values ('Marcelo Valerio', True, '17471958049', 'Rua 1', '1232142123'),
			('Jonas Lopes', True, '31242243020', 'Rua 3', '4123121223'),
            ('Maria Cristina', True, '28950852004', 'Rua 7', '4123123122');
INSERT into Clients (full_name, is_pf, cnpj, address, cellphone)
	values('Transportadora do Marcinho', False, '35254170042321', 'Rua 7', '5433423233'),
            ('Carlao Fretados', False, '63854689098321', 'Rua 10', '6234234323'),
            ('Busão do Davi', False, '84036002082312', 'Rua 1', '6324326213');
            
INSERT into Vehicles (idClient, vehicle_type, automaker, model, vehicle_year, license)
	values(1, 'Carro', 'Ford', 'Focus', '2010', '123abcd'),
    (1, 'Caminhão', 'Mercedes-Benz', 'n sei nomes', '1999', '321dcba'),
    (2, 'Carro', 'VW', 'Gol', '2015', '521asdh'),
    (3, 'Moto', 'Honda', 'n sei tambem', '2020', '153isne'),
    (4, 'Carro', 'Porsche', 'Cayenne', '2023', '837jasb'),
    (5, 'Caminhão', 'Volvo', 'caminhao2', '2004', '937hsbu'),
    (6, 'Caminhão', 'Ford', 'f13000', '1988', '735usbd');

-- Listagem dos clientes e veiculos, em ordem decrescente
Select full_name, automaker, model, vehicle_year from Clients c inner join vehicles v 
	using (idClient) where c.idClient = v.idClient order by vehicle_year DESC;
    
INSERT into Order_of_service(idVehicle, emission_date, order_status, delivery_preview)
	values(1, '2022-01-01', 'Em execução', '2022-04-01'),
		(2, '2022-03-01', 'Aguardando aprovação', '2022-03-09'),
        (3, '2022-03-01', 'Fazendo cotação', null),
        (4, '2022-01-01', 'Concluido', '2022-02-20'),
        (5, '2022-01-01', 'Fazendo cotação', null),
        (6, '2022-03-01', 'Em execução', '2022-03-20'),
        (7, '2022-03-01', 'Concluido', '2022-03-02');
        
-- Calculo do prazo de cada concerto
Select full_name, automaker, model, DATEDIFF(delivery_preview, emission_date) as fix_time from Order_of_service 
	natural join Vehicles natural join Clients;
    
INSERT into Pieces(price, piece_desc, automaker)
	values(250, 'Coxim hidráulico', 'Ford'),
    (4000, 'Motor completo gol', 'VW'),
    (1000, 'Radiador', 'Honda'),
    (1500, 'Amortecedor', 'Porsche'),
    (15000, 'Carreta', 'Volvo/Ford'),
    (400, 'Amortecedor', 'Ford'),
    (1500, 'Alternador', 'Mercedes-benz');
    
INSERT into Uses_piece(idOrder, idPiece, quantity)
	values(1, 6, 4), (2, 7, 1), (3, 2, 1), (4, 3, 1),
    (5, 4, 4), (6, 5, 1), (7, 5, 1);


-- Mostra o nome do dono, a peça a ser trocada, valor total e compara a marca da peça e do automóvel,
-- mostrando apenas as ordens que as marcas são as mesmas
SELECT full_name, piece_desc, (price*quantity) as pieces_value, p.automaker as piece_brand,
v.automaker as car_brand, model from Uses_piece natural join Pieces p natural join Order_of_service 
natural join Vehicles v natural join Clients having piece_brand = car_brand;

INSERT into Mechanical(mechanical_name, address, specialty)
	values('Gerson', 'Av central, 1949', 'Caminhão'),
		('Marcio', 'Rua 7, 823', 'Carro'),
        ('Carlos', 'Rua 9, 312', 'Moto');
        
INSERT into Works_on(idOrder, idMechanical)
	values(1, 2), (1, 3), (2, 1), (3, 2), (4, 3), (5, 2), (6, 1), (6, 2), (7, 1);
    
-- quantos serviços de cada tipo os mecanicos realizaram (concluido, em execução, etc)
SELECT order_status, mechanical_name, count(idMechanical) as projects_number from Works_on
natural join Mechanical natural join Order_of_service group by order_status, idMechanical
order by order_status DESC, projects_number DESC;

INSERT into Service(labor, service_desc)
	values(700, 'Revisão básica'), (1300, 'Revisão completa'),
    (150, 'Troca de amortecedores'), (800, 'Troca de motor'),
    (200, 'Troca radiador'), (2000, 'Instalação de carreta'),
    (500, 'Martelinho de ouro'), (50, 'Troca de óleo');
    
INSERT into Has_service(idOrder, idService)
	values(1, 3), (1, 8), (2, 7), (2, 2), (3, 4), (3, 7), (4, 5),
    (4, 1), (5, 3), (5, 7), (6, 6), (7, 6);
    
-- calcula o valor da ordem de serviço, e separa em valor das peças e do trabalho
SELECT idOrder, sum(labor) as labor_value, (price*quantity) as pieces_value from Order_of_service as os natural join
(has_service as hs natural join Service as s)natural join(uses_piece natural join Pieces) group by os.idOrder;

-- Calcula o valor arrecadado pelo trabalho por cada mecânico
SELECT Mechanical_name, sum(labor) as mechanical_labor from Order_of_service natural join (has_service natural join Service) natural join (works_on
natural join Mechanical) group by idMechanical
