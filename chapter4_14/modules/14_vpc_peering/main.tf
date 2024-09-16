###################################################
# VPC Peering Connection
###################################################
resource "aws_vpc_peering_connection" "this" {
  provider = aws.requester

  vpc_id = local.requester_vpc.id

  peer_vpc_id   = local.accepter_vpc.id
  peer_owner_id = local.accepter_account_id
  peer_region   = local.accepter_region

  # accepter 리소스를 별도로 생성할 것이기 때문에 false여도 상관 없음
  auto_accept = false

  tags = merge(
    local.module_tag,
    {
      Side = local.is_cross_provider ? "Requester" : "Requester & Accepter"
    }
  )
}

locals {
  peering_id = aws_vpc_peering_connection.this.id
}

###################################################
# VPC Peering Accepter
###################################################
resource "aws_vpc_peering_connection_accepter" "this" {
  provider                  = aws.accepter
  vpc_peering_connection_id = local.peering_id
  auto_accept               = true # 여기에서 auto_accept 설정

  tags = merge(
    local.module_tag,
    {
      Side = local.is_cross_provider ? "Accepter" : "Requester & Accepter"
    }
  )
}

locals {
  peering_accepter_id = aws_vpc_peering_connection_accepter.this.id
}

###################################################
# VPC Peering Option
###################################################
resource "aws_vpc_peering_connection_options" "requester" {
  provider = aws.requester

  vpc_peering_connection_id = local.peering_accepter_id

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_vpc_peering_connection_options" "accepter" {
  provider = aws.accepter

  vpc_peering_connection_id = local.peering_accepter_id

  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}

###################################################
# 각 VPC 내 모든 라우팅 테이블에 라우트 추가
###################################################
resource "aws_route" "requester_to_accepter" {
  for_each = toset(local.requester_rtbs)
  provider = aws.requester

  route_table_id            = each.key
  destination_cidr_block    = local.accepter_vpc.cidr_block
  vpc_peering_connection_id = local.peering_id
}

resource "aws_route" "accepter_to_requester" {
  for_each = toset(local.accepter_rtbs)
  provider = aws.accepter

  route_table_id            = each.key
  destination_cidr_block    = local.requester_vpc.cidr_block
  vpc_peering_connection_id = local.peering_id
}
