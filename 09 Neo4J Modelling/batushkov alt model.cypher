LOAD CSV WITH HEADERS FROM 'https://vbatushkov.bitbucket.io/log_of_calls.csv' AS line
MERGE (c1:City { name: line.from_city })
MERGE (p1:Person { name: line.from_name, number: line.from_number, gender: line.from_gender })
MERGE (p1)-[:FROM]->(c1)
MERGE (c2:City { name: line.to_city })
MERGE (p2:Person { name: line.to_name, number: line.to_number, gender: line.to_gender })
MERGE (p2)-[:FROM]->(c2)
CREATE (p1)-[:CALL { from: datetime(line.from_dt),
		 to: datetime(line.to_dt),
                 duration: duration.between(datetime(line.from_dt), datetime(line.to_dt)).minutes }
]->(p2);
