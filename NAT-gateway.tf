resource "aws_eip" "name" {
 depends_on = [aws_internet_gateway.ourInternalGateway]
}


resource "aws_nat_gateway" "ourNAT" {
  allocation_id = aws_eip.name.id
  subnet_id = aws_subnet.pub-sub-1.id
  

  

}

