
resource "aws_elasticache_cluster" "acgecc-redis" {
  cluster_id           = "acgecc-redis"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
  subnet_group_name    = "redsubnet"

}

resource "aws_elasticache_subnet_group" "redsubnet" {
  name       = "redsubnet"
  subnet_ids = [aws_subnet.privsubnet.id]
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis3.2"
}