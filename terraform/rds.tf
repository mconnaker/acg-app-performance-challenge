
resource "aws_db_subnet_group" "acgeccdbsgn" {
  name       = "acgeccdbsgn"
  subnet_ids = [aws_subnet.datasubnet.id, aws_subnet.datasubnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "acgecc-db" {
    allocated_storage = 100
    db_subnet_group_name = "acgeccdbsgn"
    engine = "postgres"
    engine_version = "11.10"
    identifier = "acgecc-db"
    instance_class = "db.t2.micro"
    password = "acgecc21"
    skip_final_snapshot = true
    storage_encrypted = false
    username = "acgeccdb"
    vpc_security_group_ids = ["${aws_security_group.db-sg.id}"]
}